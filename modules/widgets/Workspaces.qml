import QtQuick
import Quickshell
import Quickshell.Hyprland

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
