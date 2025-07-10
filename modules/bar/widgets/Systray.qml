import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

// Systray
//
Rectangle{
  visible: SystemTray.items.values.length === 0 ? false : true
  color: mainColor
  width: sysRow.width
  height: widgetHeight
  radius: rad
  border.color: mainBColor

  Row {
    id: sysRow

    anchors.centerIn: parent

    padding: 10
    spacing: 5
    Repeater {
      model: SystemTray.items

      Rectangle {
        width: fontSize
        height: fontSize
        color: "transparent"

        Image {
          source: modelData.icon
          anchors.fill: parent
        }

        MouseArea {
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

          onClicked: m => {
            if (m.button === Qt.LeftButton) {
              modelData.activate()
            } else if (m.button === Qt.MiddleButton) {
              modelData.secondaryActivate()
            } else if (m.button === Qt.RightButton && modelData.hasMenu) {
              modelData.display(parent, m.x, m.y)
            }
          }
        }
      }
    }
  }
}
