import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.modules.windows
import qs

Container {
  width: activeWinTxt.width

  Text {
    id: activeWinTxt
    anchors.centerIn: parent

    property HyprlandToplevel active: Hyprland.activeToplevel
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
    padding: 10
    color: txtColor
    font.pixelSize: fSize
    text: active.workspace.focused ? tFunc() : "Hyprland/Quickshell"
    // text: "// TODO: Finish this panel"
  }
  Launcher {
    id: popup
  }
}
