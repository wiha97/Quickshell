import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Fusion
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
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
    ScrollView {
      Layout.alignment: horizontalCenter
      Layout.fillHeight: true
      padding: 5;
      hoverEnabled: false
      GridLayout {
        columns: 4
        Repeater {
          model: WPService.walls
          ClippingRectangle {
            width: Screen.width / 10
            height: Screen.height / 10
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
