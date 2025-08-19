import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs

Container {
  width: workspaceRow.width
  height: barHeight

  Row {
    id: workspaceRow

    anchors.centerIn: parent
    spacing: 8
    padding: 8

    Repeater {
      model: Hyprland.workspaces

      Rectangle {
        property string wId: modelData.id
        width: barHeight * 2
        height: widgetHeight
        radius: rad / 2
        color: secColor
        border.color: modelData.active || wId === "-98" ? secBColor : secColor
        border.width: 2

        MouseArea {
          anchors.fill: parent

          onClicked: wId === "-98" ? Hyprland.dispatch("togglespecialworkspace scratchpad") :
                                     Hyprland.dispatch("workspace " + modelData.id)
        }

        Column {}
        Row {

          anchors.centerIn: parent
          Text {
            text: wId === "-98" ? "\udb85\udce7" : modelData.name
            font.pixelSize: fontSize
            color: txtColor
          }

          Text {
            // anchors.verticalCenter: parent.verticalCenter
            text: "["+modelData.toplevels.values.length+"]"
            color: secTxtColor
            font.pixelSize: fontSize * 0.5
          }

          // Repeater {
          //   model: modelData.toplevels
          //
          //   Text {
          //     color: secTxtColor
          //     text: "*"
          //     font.pixelSize: fontSize * 0.5
          //   }
          // }
        }
        Row {
          anchors.fill: parent
          Repeater {
            model: modelData.toplevels
            Rectangle {
              width: parent.height / 2
              height: parent.height / 2
              color: "transparent"
              Image {
                width: parent.width
                height: parent.height
                source: Quickshell.iconPath(Conf.getIcon(modelData.wayland.appId.toLowerCase()));
                // Component.onCompleted: getIcon();
              }
            }
          }
        }
      }
    }
  }
// PopupWindow {
  //   anchor.window: panel
  //   anchor.rect.x: parentWindow.width / 2 - width / 2
  //   anchor.rect.y: parentWindow.height
  //   width: 500
  //   height: 500
  //   visible: true
  // }    
}
