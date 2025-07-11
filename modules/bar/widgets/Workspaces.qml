import QtQuick
import Quickshell
import Quickshell.Hyprland


//  Workspaces
//
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
        color: "#202020"
        border.color: modelData.active || wId === "-98" ? secBColor : "#202020"
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

          Repeater {
            model: modelData.toplevels

            Text {
              color: "white"
              text: "*"
              font.pixelSize: fontSize
            }
          }
        }
      }
    }
  }
}
