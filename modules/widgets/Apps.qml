import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell
import Quickshell.Widgets
import qs

Rectangle {
  // anchors.fill: parent

  color: "transparent"

  ColumnLayout {
    anchors.fill: parent

      TextField {
        implicitWidth: parent.width
        font.pixelSize: Conf.fontSize
        horizontalAlignment: TextField.AlignHCenter
        placeholderText: "Search..."
        background: {
          color: "transparent"
        }
      }
    ScrollView {
      Layout.fillHeight: true
      width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
      padding: 5

      GridLayout {
        // anchors.centerIn: parent
        columns: 7

        Repeater {
          model: DesktopEntries.applications

          ClippingRectangle {
            width: 120
            height: 120
            color: "transparent"
            radius: 25
            clip: true
            // Label {
            //   color: "white"
            //   font.pixelSize: 8
            //   text: modelData.name
            // }
            Column{
              anchors.fill: parent
              padding: 5
              Image {
                // anchors.centerIn: parent
                width: parent.width - 50
                height: parent.height - 50
                anchors.horizontalCenter: parent.horizontalCenter
                source: Quickshell.iconPath(modelData.icon)
              }
              Label {
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                text: modelData.name
                width: parent.width
                wrapMode: Text.Wrap
                font.pixelSize: 12
              }
            }
              MouseArea {
                anchors.fill: parent
                onClicked: modelData.execute();
                // onClicked: console.log("clicked on: " + modelData.name);
              }
          }
        }
      }
    }
  }
}
