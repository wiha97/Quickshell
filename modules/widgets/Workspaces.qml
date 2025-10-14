import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs

WidBase {
  width: workspaceRow.width
  height: barHeight
  property var workspaces: Hyprland.workspaces
  property string monitor: screen.name
  property bool current: true

  Row {
    id: workspaceRow

    anchors.centerIn: parent
    spacing: 8
    padding: 8

    Repeater {
      model: workspaces
      // model: Hyprland.workspaces

      Rectangle {
        property bool sameScreen: modelData.monitor.name === monitor
        visible: sameScreen || !modelData.active
        property string wId: modelData.id
        property string wName: modelData.name
        // width: barHeight * 2
        height: widgetHeight+2
        width: 15+row.width
        radius: rad / 2
        color: secColor
        border.color: modelData.active || wName.includes("special") ? secBColor : secColor
        border.width: 1

        MouseArea {
          anchors.fill: parent

          onClicked:{
            if(wName.includes("special")){
              Hyprland.dispatch("togglespecialworkspace " + wName.substring(wName.indexOf(":")+1));
            } else {
              Hyprland.dispatch("moveworkspacetomonitor " + modelData.id + " current");
              Hyprland.dispatch("workspace " + modelData.id);
            }
          }
        }

        Row {
          id: row
          spacing: 5
          anchors.centerIn: parent
          Text {
            text: {
              switch(modelData.name){
                case "special:browser":
                  return "";
                case "special:files":
                  return "";
                case "special:magic":
                  return "󱓧";
                case "special:media":
                  return "";
                default:
                  return "["+modelData.name+"]";
              }
            }
            // text: wId === "-98" ? "\udb85\udce7" : "["+modelData.name+"]"
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
      visible: monitor === Hyprland.focusedMonitor.name
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
