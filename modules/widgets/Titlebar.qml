import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs
import qs.modules.singles

WidBase {
  width: titleRow.width
  // width: activeWinTxt.width + fontSize + 20
  property HyprlandToplevel active: Hyprland.activeToplevel

  Row {
    id: titleRow
    anchors.verticalCenter: parent.verticalCenter
    anchors.centerIn: parent
    padding: 10
    spacing: 5
    Text {
      id: activeWinTxt
    anchors.verticalCenter: parent.verticalCenter

      property int fSize: fontSize
      function tFunc(){
        let maxNum = 55;
        if(active.title.length > maxNum){
          fSize = fontSize / 1.5
          return active.title.substring(0,maxNum)+"..."
        }
        fSize = fontSize
        return active.title
      }
      // padding: 10
      color: txtColor
      font.pixelSize: fSize
      text: active.workspace.focused ? tFunc() : HyprSplash.msg
      // text: "// TODO: Finish this panel"
    }
    Rectangle {
      anchors.verticalCenter: parent.verticalCenter
      width: fontSize * 1.2
      height: fontSize * 1.2
      color: "transparent"
      Image {
        anchors.fill: parent
        property string app: active.wayland.appId
        source: Quickshell.iconPath(
          Conf.getIcon(active.workspace.focused ?
          app.toLowerCase() : "cachyoshello"));
      }
    }
  }
}
