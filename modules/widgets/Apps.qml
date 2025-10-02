import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell
import Quickshell.Widgets
import qs
import qs.modules.singles

Rectangle {
  // anchors.fill: parent

  property var entries: AppService.entries;
  // property var entries: {
  //   let apps = AppService.entries;
  //   // apps.sort();
  //   return apps;
  // }
  color: "transparent"

  ColumnLayout {
    anchors.fill: parent

    TextField {
      id: searchBox
      focus: true
      hoverEnabled: false
      implicitWidth: parent.width
      font.pixelSize: Conf.fontSize
      horizontalAlignment: TextField.AlignHCenter
      placeholderText: "Search..."
      background: {
        color: "transparent"
      }
      onTextChanged: {
        let apps = AppService.entries;
        let filter = searchBox.text.toLowerCase();
        apps = apps.filter((app) => app.name.toLowerCase().includes(filter));
        apps.sort((a,b) => a.name.localeCompare(b.name));
        // apps.sort();
        entries = apps;
      }
      Keys.onPressed: (e) => {
        if(e.key == Qt.Key_Escape) {
          console.log("pressed escape")
          appGrid.focus = true
        } else if(e.key == Qt.Key_Right){
          appGrid.next();
        } else if(e.key == Qt.Key_Left){
          appGrid.prev();
        } else if(e.key == Qt.Key_Down){
          appGrid.down();
        } else if(e.key == Qt.Key_Up){
          appGrid.up();
        } else if(e.key == Qt.Key_Return){
          appGrid.open();
          searchBox.text = "";
        }
      }
    }
    ScrollView {
      id: scrolly
      Layout.fillHeight: true
      width: parent.width
      anchors.horizontalCenter: parent.horizontalCenter
      padding: 5
      hoverEnabled: false

      GridLayout {
        id: appGrid
        property int colCount: 8
        columns: colCount
        property int item: 0
        function next(){
          item++
          if(item > entries.length -1)
            item = 0;
          // else
          rep.itemAt(item).focus = true
        }
        function prev(){
          item--
          if (item < 0)
            item = entries.length -1;
          rep.itemAt(item).focus = true
        }
        function up(){
          item -= colCount
          if (item < 0)
            item = 0;
          rep.itemAt(item).focus = true
          scrolly.ScrollBar.vertical.position = (item+1 / colCount) / 235
        }
        function down(){
          item += colCount
          if (item > entries.length -1)
            item = entries.length -1;
          rep.itemAt(item).focus = true
          scrolly.ScrollBar.vertical.position = (item+1 / colCount) / 235
        }
        function open(){
          entries[item].execute();
        }

        Repeater {
          id: rep
          model: entries
          ClippingRectangle {
            property int idx: appGrid.item
            width: screen.width / 20 // 120
            height: screen.width / 20 // 120
            color: focus ? Conf.hilightColor : "transparent"
            radius: 25
            clip: true
            Keys.onPressed: (e) => {
              console.log("pressed "+e.key)
              if(e.key == Qt.Key_Right){
                appGrid.next();
              }
            }
            // KeyNavigation.right: appGrid.next();
            Column{
              anchors.fill: parent
              padding: 5
              Image {
                // anchors.centerIn: parent
                sourceSize.width: parent.width - 50
                sourceSize.height: parent.height - 50
                anchors.horizontalCenter: parent.horizontalCenter
                source: Quickshell.iconPath(modelData.icon)
              }
              Label {
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                text: modelData.name
                // text: ""+parent.parent.idx
                width: parent.width
                wrapMode: Text.Wrap
                font.pixelSize: 12
              }
            }
            MouseArea {
              anchors.fill: parent
              onClicked: {
                modelData.execute();
                searchBox.text = "";
              }
            }
          }
        }
      }
    }
  }
}
