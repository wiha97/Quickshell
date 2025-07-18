import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell

Rectangle {
  // anchors.fill: parent

  color: "transparent"

  GridLayout {
    anchors.centerIn: parent
    // anchors.horizontalCenter: parent.horizontalCenter
    columns: 12

    Repeater {
      model: DesktopEntries.applications

      Rectangle {
        width: 75
        height: 75
        color: "#202020"
        radius: 25
        // Label {
        //   color: "white"
        //   font.pixelSize: 8
        //   text: modelData.name
        // }
        Image {
          anchors.centerIn: parent
          width: 50
          height: 50
          source: Quickshell.iconPath(modelData.icon)
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
