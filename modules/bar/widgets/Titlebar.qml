import QtQuick
import Quickshell
import Quickshell.Hyprland
import "root:/"

Container {
  width: activeWinTxt.width

  Text {
    id: activeWinTxt
    anchors.centerIn: parent

    property HyprlandToplevel active: Hyprland.activeToplevel
    property int fSize: Conf.fontSize
    function tFunc(){
      let maxNum = 65;
      if(active.title.length > maxNum){
        fSize = Conf.fontSize / 1.5
        return active.title.substring(0,maxNum)+"..."
      }
      fSize = Conf.fontSize
      return active.title
    }
    padding: 10
    color: Conf.txtColor
    font.pixelSize: fSize
    text: active.workspace.focused ? tFunc() : "Hyprland/Quickshell"
    // text: "// TODO: Finish this panel"
  }
}
