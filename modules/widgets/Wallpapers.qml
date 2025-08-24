import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Fusion
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import qs

Rectangle {
  color: "transparent"
  property list<string> wps

  Process {
    running: true
    command: ["ls", Conf.wpPath]
    stdout: StdioCollector {
      onStreamFinished: {
        let output = this.text.split("\n");
        for(let i = 0; i < output.length; i++) {
          if(output[i].length > 0) {
            wps.push(Conf.wpPath + output[i]);
          }
        }
      }
    }
  }

  ScrollView {
    anchors.fill: parent
    padding: 5;
    hoverEnabled: false
    GridLayout {
      columns: 4
      Repeater {
        model: wps
        ClippingRectangle {
          width: Screen.width / 10
          height: Screen.height / 10
          radius: 10
          color: "transparent"
          Image {
            anchors.fill: parent
            source: modelData
            asynchronous: true
          }
          MouseArea {
            anchors.fill: parent
            onClicked: Conf.background = modelData;
          }
        }
      }
    }
  }
}
