import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import qs.modules.singles
import qs

PanelWindow {
  property list<Notification> notes: NotificationService.noties
  visible: notes.length === 0 ? false : true
  property list<int> notiHeights: ["65", "90", "200"]
  property int wrapLength: 38
  // property int totalHeight: (notes.length * notiHeight) + 35 + (5 * notes.length);
  property int baseHeight: 35 + (5 * notes.length);
  property int totalHeight
  property bool show: NotificationService.showNotes;
  anchors {
    bottom: true
    right: true
  }
  margins {
    right: 5
    bottom: 5
    left: 5
    top: 5
  }
  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered: {
      NotificationService.showNotes = true
      NotificationService.startTimer(false);
    }
  }
  implicitWidth: NotificationService.showNotes ? 550 : 100
  implicitHeight: NotificationService.showNotes ? getTotalHeight() : 35
  function getTotalHeight(){
    let height = baseHeight;
    notes.forEach((note)=>{
      let length = note.body.length != 0 ? note.body.length : note.summary.length;
      // console.log(length);
      if (length < wrapLength)
        height += notiHeights[0]
      else if(length < wrapLength * 6)
        height += notiHeights[1]
      if(hasImage(note) || length >= wrapLength * 6)
        height += notiHeights[2]
    });
    return height
  }
  function hasImage(mod){
    // console.log("bod: "+modelData.body)
    let icons = ["/icon/", "/qsimage/"]
    if((mod.image.length > 0 && !icons.some(i=>mod.image.includes(i))) || bodyHasImg(mod.body))
      return true;
    return false;
  }
  property list<string> formats: ["png","jpg","jpeg","svg"]
  function bodyHasImg(body){
    if(formats.some(f=>body.includes(f)))
    {
      return true;
    }
    return false;
  }
  function getPath(msg){
    if(formats.some(ext => msg.includes(ext))){
      let startIdx = msg.indexOf("/");
      for(let i = 0; i < formats.length; i++){
        let endIdx = msg.indexOf(formats[i]);
        if(endIdx >= 0){
          let formattedMsg = msg.substring(startIdx, endIdx + formats[i].length);
          return formattedMsg;
          break;
        }
      }
    }
  }
  function getUrl(msg){
    if(formats.some(ext=>msg.includes(ext)) && msg.includes("https://")){
      let split = msg.split("https://")[1];
      split = "https://"+split;
      for(let i = 0; i < formats.length; i++){
        let idx = split.indexOf(" ");
        if(idx < 0)
          idx = split.length;
        let link = split.substring(0,idx);
        return [link, msg.replace(link, "")];
      }
      return "msg contains linked image";
    }
  }
  color: "transparent"
  ClippingRectangle {
    id: rect
    anchors.fill: parent
    height: column.height
    radius: 5
    color: Conf.mainColor
    border.color: Conf.mainBColor
    border.width: 1
    Column {
      id: column
      spacing: 5
      anchors.fill: parent
      padding: 5
      ClippingRectangle {
        height: 25
        width: parent.width - 10
        color: "#202020"
        radius: 5
        Text {
          padding: 2
          text: notes.length + " noties"
          color: "white"
        }
        MouseArea {
          anchors.fill: parent
          hoverEnabled: true
          onEntered: clear.visible = true
          onClicked: {
            NotificationService.showNotes = false
            clear.visible = false
          }
        }
        Rectangle {
          id: clear
          visible: false
          height: parent.height
          width: 50
          color: "transparent"
          anchors.right: parent.right
          Text {
            color: Conf.secTxtColor
            text: "󰱢"
            anchors.centerIn: parent
          }
          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered:  {
              parent.color = "red"
              visible: true
            }
            onExited: parent.color = "transparent"
            onClicked: {
              let max = notes.length;
              for(let i = 0; i < max; i++){
                notes[i].dismiss();
              }
            }
          }
        }
      }
      Repeater {
        model: NotificationService.noties

        ClippingRectangle {
          id: notiBody
          property string title
          property string bodyMsg
          property string image
          property string icon
          property string iconImg
          Component.onCompleted: {
            let note = modelData;
            if(bodyHasImg(note.body)){
              let path;
              if(note.body.includes("https://")){
                path = getUrl(note.body)[0];
              } else {
                path = getPath(note.body);
              }
              let pathlessMsg = note.body.replace(path, "");
              if(path > pathlessMsg / 2){
                title = pathlessMsg;
              } else {
                bodyMsg = pathlessMsg;
              }
              image = path;
            } else {
              if(note.body.length > 0)
                bodyMsg = note.body;
              else
                bodyMsg = note.summary;
              // if(note.image.length > 20){
              //   image = note.image.replace("image://icon/", "");
              // }
            }
            if(note.appIcon.length > 0){
              icon = note.appIcon;
              if(note.image.includes("qsimage"))
                iconImg = note.image;
            } else {
              if(note.image.includes("/icon/")){
                // if(note.image.length < 50)
                icon = note.image.replace("image://icon/", "");
              }
            }
            if(!title.length){
              if(note.appName.length > 0)
                title = note.appName;
              else if (note.summary.length > 0)
                title = note.summary;
            }
          }
          width: parent.width - 10
          height: setHeight();
          function setHeight(){
            let height;
            let length = bodyMsg.length;
            if(length < wrapLength)
              height = notiHeights[0];
            else if(length < wrapLength * 6)
              height = notiHeights[1];
            else
              height = notiHeights[2];
            if(hasImage(modelData))
              height = notiHeights[2] + 87; // images need an extra 87 pixels
            return height;
          }
          function getImg(){
            let img = modelData.image
            console.log("hitting this?")
            if(img.length > 0 && !img.includes("/icon/"))
              return modelData.image
            return getPath(modelData.body);
          }
          color: Conf.secColor
          border.color: Conf.hilightColor
          border.width: 1
          radius: 5
          RowLayout {
            anchors.fill: parent
            ColumnLayout{
              id: contentColumn
              implicitWidth: notiBody.width - 50
              // Layout.fillWidth: true
              Layout.fillHeight: true
              // width: 460
              Row {
                leftPadding: 5
                topPadding: 5
                spacing: 5
                // height: 25
                Image {
                  visible: icon
                  source: Quickshell.iconPath(icon)
                  width: 22
                  height: 22
                  anchors.verticalCenter: parent.verticalCenter
                }
                Image {
                  visible: iconImg
                  source: iconImg
                  width: 22
                  height: 22
                  anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                  text: title
                  color: Conf.txtColor
                  anchors.verticalCenter: parent.verticalCenter
                }
              }
              ClippingRectangle {
                id: contentView
                Layout.fillHeight: true
                Layout.fillWidth: true
                radius: 20
                color: "transparent"
                ScrollView {
                  visible: !image
                  anchors.fill: parent
                  contentWidth: contentView.width
                  ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                  ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                  TextEdit {
                    text: bodyMsg
                    wrapMode: Text.WordWrap
                    width: contentView.width
                    color: Conf.secTxtColor
                    anchors.centerIn: parent
                    padding: 5
                    font.pixelSize: Conf.fontSize
                    selectByMouse: true
                  }
                }
                ScrollView {
                  visible: image
                  anchors.fill: parent
                  ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                  ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                  Image {
                    id: img
                    source: image
                    sourceSize.height: contentView.height
                    sourceSize.width: contentView.width
                    fillMode: Image.PreserveAspectCrop
                  }
                }
              }

            }
            Rectangle {
              id: close
              Layout.fillHeight: true
              // Layout.fillWidth: true
              width: 50
              color: "transparent"
              opacity: 0.5
              // anchors.right: parent.right
              radius: 5
              Text {
                text: ""
                color: Conf.secTxtColor
                anchors.centerIn: parent
                font.pixelSize: 30
              }
              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: close.color = "red";
                onExited: close.color = "transparent";
                onClicked: modelData.dismiss();
              }
            }
          }
        }
      }
    }
  }
}
