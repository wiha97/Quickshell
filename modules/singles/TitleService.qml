pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs

Singleton {
  id: root
  property HyprlandToplevel active: Hyprland.activeToplevel
  property string app: active.wayland.appId
  property string icon: active.workspace.focused ? app.toLowerCase().substring(app.lastIndexOf(".")+1) : "N/A"

  // property string title: active.workspace.focused ? active.title : HyprSplash.msg
  property string title: {
    if(!active.workspace.focused)
      return HyprSplash.msg
    let txt = active.title
    if(txt.length > 5)
      return txt;
    return icon + " " + txt
  }

}
