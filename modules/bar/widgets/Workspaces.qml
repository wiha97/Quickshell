import QtQuick
import Quickshell
import Quickshell.Hyprland


    //  Workspaces
    //
    Rectangle {
      color: mainColor
      width: workspaceRow.width
      // height: workspaceRow.height + 16
      height: barHeight
      // radius: rad
      topRightRadius: rad
      topLeftRadius: rad
      bottomLeftRadius: rad
      bottomRightRadius: rad
      border.color: mainBColor

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

            Text {
              anchors.centerIn: parent
              text: wId === "-98" ? "\udb85\udce7" : modelData.name
              font.pixelSize: fontSize
              color: txtColor
            }
          }
        }

        Text {
          visible: Hyprland.workspaces.length === 0
          text: "None"
          color: txtColor
          font.pixelSize: fontSize
        }
      }
    }
