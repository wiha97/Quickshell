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
  property list<int> notiHeights: ["65", "100", "200"]
  // property int totalHeight: (notes.length * notiHeight) + 35 + (5 * notes.length);
  property int baseHeight: 35 + (5 * notes.length);
  property int totalHeight
  property bool show: NotificationService.showNotes;
  anchors {
    bottom: true
    right: true
  }
  margins {
    right: 10
    bottom: 10
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
      if (note.body.length < 46)
        height += notiHeights[0]
      else
        height += notiHeights[1]
      if(hasImage(note))
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
        color: "black"
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
              if(note.image.includes("qsimage"))
                iconImg = note.image;
              else
                icon = note.appIcon;
            } else {
              if(note.image.includes("/icon/")){
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
            let height = notiHeights[0];
            if(modelData.body.length > 46)
              height = notiHeights[1];
            if(hasImage(modelData))
              height = notiHeights[2] + 100;
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
          ColumnLayout{
            height: parent.height
            width: 460
            Row {
              leftPadding: 5
              topPadding: 5
              Image {
                visible: icon || iconImg
                source: icon ? Quickshell.iconPath(icon) : iconImg
                width: 22
                height: 22
                anchors.verticalCenter: parent.verticalCenter
              }
              Text {
                text: title
                // text: modelData.appName.length > 0 ? modelData.appName : modelData.summary
                color: Conf.txtColor
                leftPadding: 5
                anchors.verticalCenter: parent.verticalCenter
                // padding: 5
              }
            }
            ScrollView {
              visible: !image
              // Layout.fillWidth: true
              Layout.fillHeight: true
              padding: 5
              Text {
                text: bodyMsg
                wrapMode: Text.WordWrap
                width: 440
                color: Conf.secTxtColor
                anchors.bottom: parent.bottom
                bottomPadding: 5
                leftPadding: 5
                font.pixelSize: Conf.fontSize
              }
            }
            ScrollView {
              visible: image
              width: parent.width
              Layout.fillHeight: true
              Layout.fillWidth: true
              // ClippingRectangle {
              //   height: img.height
              //   radius: 15
              //   width: img.width
                Image {
                  id: img
                  source: image
                  sourceSize.height: notiHeights[2] + 70
                  fillMode: Image.PreserveAspectCrop
                  // anchors.horizontalCenter: parent.horizontalCenter
                }
              // }
            }

          }
          Rectangle {
            id: close
            height: parent.height
            width: parent.width / 8
            color: "transparent"
            opacity: 0.5
            anchors.right: parent.right
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
