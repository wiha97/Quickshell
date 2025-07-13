import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

// Systray
//
Container {
  visible: SystemTray.items.values.length === 0 ? false : true
  width: sysRow.width

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
          id: mArea
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

          onClicked: m => {
            if (m.button === Qt.LeftButton) {
              if(modelData.onlyMenu)
                menuAnchor.open();
              modelData.activate()
            } else if (m.button === Qt.RightButton && modelData.hasMenu) {
              menuAnchor.open();
            }
          }
          QsMenuAnchor {
            id: menuAnchor
            menu: modelData.menu

            anchor.window: mArea.QsWindow.window
            anchor.adjustment: PopopAdjustment.Flip

            anchor.onAnchoring: {
              const window = mArea.QsWindow.window
              const widgetRect = window.contentItem.mapFromItem(mArea, 0, mArea.height, mArea.width, mArea.height);
              console.log("open plz");

              menuAnchor.anchor.rect = widgetRect;
            }
          }
        }
      }
    }
  }
}
