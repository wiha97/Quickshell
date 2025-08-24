import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs

WidBase {
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
        // width: barHeight * 2
        height: widgetHeight+2
        width: 15+row.width
        radius: rad / 2
        color: secColor
        border.color: modelData.active || wId === "-98" ? secBColor : secColor
        border.width: 1

        MouseArea {
          anchors.fill: parent

          onClicked: wId === "-98" ? Hyprland.dispatch("togglespecialworkspace scratchpad") :
                                     Hyprland.dispatch("workspace " + modelData.id)
        }

        Row {
          id: row
          spacing: 5
          anchors.centerIn: parent
          Text {
            text: wId === "-98" ? "\udb85\udce7" : "["+modelData.name+"]"
            font.pixelSize: fontSize
            color: txtColor
          }
          Repeater {
            model: modelData.toplevels
            Rectangle {
              property string app: modelData.wayland.appId
              width: parent.height
              height: parent.height
              color: "transparent"
              Image {
                width: parent.width
                height: parent.height
                source: Quickshell.iconPath(Conf.getIcon(app.toLowerCase()));
                // Component.onCompleted: getIcon();
              }
            }
          }
        }
      }
    }
  }
}
