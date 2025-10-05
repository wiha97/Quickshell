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
  property string monitor: screen.model
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
          property string model: modelData.model
          property string input: modelData.name
          color: Conf.hilightColor
          opacity: rect.monitor === model ? 1 : 0.4
          height: parent.height
          width: ((screen.width / 2) - 60) / Quickshell.screens.length - (Quickshell.screens.length * 15) - (15 * 2)
          radius: 15
          Column {
              anchors.centerIn: parent
            Label {
              text: model
              anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
              text: "("+input+")"
              font.pixelSize: 10
              anchors.horizontalCenter: parent.horizontalCenter
            }
          }
          MouseArea {
            anchors.fill: parent
            hoverEnabled: false
            onClicked: {
              if(rect.monitor === model)
                rect.monitor = screen.model
              else
                rect.monitor = model
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
                id: currentBox
                visible: {
                  for(let i = 0; i < Conf.perMonBgs.length; i++){
                    let split = Conf.perMonBgs[i].split(":");
                    let mon = split[0];
                    let wp = split[1];
                    if(modelData.includes(wp))
                      return true;
                  }
                  return false;
                }
                // visible: modelData.includes(Conf.background) && Conf.background.length > 0
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
                  for(let i = 0; i < Conf.perMonBgs.length; i++){
                    let split = Conf.perMonBgs[i].split(":");
                    let mon = split[0];
                    let wp = split[1];
                    if(mon === rect.monitor){
                      // Conf.perMonBgs[i] = monitor+":"
                      Conf.perMonBgs[i] = monitor+":"+modelData
                      // console.log(Conf.perMonBgs)
                    }
                  }
                  // if(!modelData.includes(Conf.background) || Conf.background.length == 0){
                  //   Conf.background = null;
                  //   Conf.background = modelData;
                  // } else {
                  //   Conf.background = null;
                  // }
                }
              }
            }
          }
        }
      }
    }
  }
}
