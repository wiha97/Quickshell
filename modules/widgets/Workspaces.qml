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

          onClicked:{
            switch (wId){
              case "-98":
                Hyprland.dispatch("togglespecialworkspace scratchpad");
                break;
              default:
                Hyprland.dispatch("moveworkspacetomonitor " + modelData.id + " current");
                Hyprland.dispatch("workspace " + modelData.id);
                break;
            }
          }
          // wId === "-98" ? Hyprland.dispatch("togglespecialworkspace scratchpad") : {
          //   Hyprland.dispatch("moveworkspacetomonitor + " modelData.id)
          //   Hyprland.dispatch("workspace " + modelData.id)
          // }
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
              width: fontSize
              height: fontSize
              anchors.verticalCenter: parent.verticalCenter
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

    Rectangle {
      // width: barHeight * 2
      height: widgetHeight+2
      width: txt.width + 10
      radius: rad / 2
      color: secColor
      border.color: secColor
      border.width: 1
      Text {
        id: txt
        anchors.centerIn: parent
        text: "+"
        font.pixelSize: fontSize
        color: txtColor
      }

      MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch("workspace emptymn")
        // onClicked: wId === "-98" ? Hyprland.dispatch("togglespecialworkspace scratchpad") :
        //                            Hyprland.dispatch("workspace " + modelData.id)
      }
    }
  }
}
