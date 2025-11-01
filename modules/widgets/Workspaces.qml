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
        property list<string> alwaysShow: ["dev"]
        property bool sameScreen: modelData.monitor.name === monitor
        property string wId: modelData.id
        property string wName: modelData.name
        property bool isVisible: {
          // let always = ["dev"];
          let monName = modelData.monitor.name;
          if(monName === monitor)
            return true;
          if(alwaysShow.includes(wName))
            return true;
          if(!modelData.active){
            if(wName === monName)
              return false;
            return true;
          }
          return false;
        }
        property string title: {
          switch(modelData.name){
              case "special:browser":
                return "";
              case "special:files":
                return "";
              case "special:magic":
                return "󱓧";
              case "special:media":
                return "";
              case "dev":
                return "";
              case monitor:
                return "󰍹";
              default:
                // if(wName.startsWith("mon"))
                //   return "󰍹";
                return "["+wName+"]";
            }
        }
        visible: isVisible
        // visible: sameScreen || !modelData.active && wName != modelData.monitor.name || wName === "dev"
        // visible: sameScreen || !modelData.active || wName === "dev"
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
            } else if(wName != modelData.monitor.name) {
              Hyprland.dispatch("moveworkspacetomonitor " + wName + " current");
              Hyprland.dispatch("workspace " + wName);
            } else {
              Hyprland.dispatch("workspace " + wName);
            }
          }
        }

        Row {
          id: row
          spacing: 5
          anchors.centerIn: parent
          Text {
            text: title
            //   switch(modelData.name){
            //     case "special:browser":
            //       return "";
            //     case "special:files":
            //       return "";
            //     case "special:magic":
            //       return "󱓧";
            //     case "special:media":
            //       return "";
            //     case "dev":
            //       return "";
            //     case monitor:
            //       return "󰍹";
            //     default:
            //       // if(wName.startsWith("mon"))
            //       //   return "󰍹";
            //       return "["+wName+"]";
            //   }
            // }
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
        onClicked: Hyprland.dispatch("workspace emptym")
      }
    }
  }
}
