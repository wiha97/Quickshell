import QtQuick
import Quickshell
import Quickshell.Hyprland
import "root:/"

//  Workspaces
//
Container {
  width: workspaceRow.width
  height: Conf.barHeight

  Row {
    id: workspaceRow

    anchors.centerIn: parent
    spacing: 8
    padding: 8

    Repeater {
      model: Hyprland.workspaces

      Rectangle {
        property string wId: modelData.id
        width: Conf.barHeight * 2
        height: Conf.widgetHeight
        radius: Conf.rad / 2
        color: "#202020"
        border.color: modelData.active || wId === "-98" ? Conf.secBColor : "#202020"
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
            font.pixelSize: Conf.fontSize
            color: Conf.txtColor
          }

          Text {
            // anchors.verticalCenter: parent.verticalCenter
            text: "["+modelData.toplevels.values.length+"]"
            color: Conf.secTxtColor
            font.pixelSize: Conf.fontSize * 0.5
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
}
