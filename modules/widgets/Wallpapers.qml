import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Fusion
import Quickshell
import Quickshell.Widgets
import qs
import qs.modules.singles

Rectangle {
  id: rect
  color: "transparent"
  property list<string> wps
  focus: true

  ColumnLayout {
    anchors.horizontalCenter: parent.horizontalCenter
    height: parent.height
    focus: true
    TextField {
      focus: true
      Keys.onPressed: (event)=>{
        console.log("Captured: ", event.text);
        event.accepted = true;
      }

      hoverEnabled: false
      implicitWidth: parent.width
      font.pixelSize: Conf.fontSize
      horizontalAlignment: TextField.AlignHCenter
      background: Rectangle {
        color: "transparent"
      }
      placeholderText: Conf.wpPath
    }
    Row {
      visible: Quickshell.screens.length > 1
      height: 50
      // width: parent.width
      anchors.horizontalCenter: parent.horizontalCenter
      spacing: 15
      Repeater {
        property int screenCount: Quickshell.screens.length
        model: Quickshell.screens
        Rectangle {
          color: Conf.secColor
          height: parent.height
          width: ((screen.width / 2) - 60) / Quickshell.screens.length - (Quickshell.screens.length * 15) - (15 * 2)
          radius: 15
          Column {
              anchors.centerIn: parent
            Label {
              text: modelData.model
              anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
              text: "("+modelData.name+")"
              font.pixelSize: 10
              anchors.horizontalCenter: parent.horizontalCenter
            }
          }
        }
      }
    }
    Column {
      Layout.fillHeight: true
      Layout.fillWidth: true
      ScrollView {
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        hoverEnabled: false
        padding: 10
        GridLayout {
          columns: 4
          Repeater {
            model: WPService.walls
            ClippingRectangle {
              width: screen.width / 10
              height: screen.height / 10
              radius: 10
              color: "#A5202020"
              Image {
                anchors.fill: parent
                source: modelData
                sourceSize.width: parent.width
                sourceSize.height: parent.height
                asynchronous: true
              }
              Rectangle {
                visible: Conf.background == modelData
                anchors.fill: parent
                opacity: 0.6
                color: "#202020"
                Label {
                  text: "CURRENT"
                  anchors.centerIn: parent
                }
              }
              Label {
                anchors {
                  bottom: parent.bottom
                  right: parent.right
                }
                background: Rectangle {
                  color: "black"
                  anchors.fill: parent
                  opacity: 0.8
                  radius: 5
                }
                text: {
                  let idx = modelData.lastIndexOf("/");
                  return modelData.substring(idx+1, modelData.indexOf("."));
                }
              }
              MouseArea {
                anchors.fill: parent
                onClicked: {
                  if(Conf.background != modelData){
                    Conf.background = modelData;
                  } else {
                    Conf.background = null;
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
