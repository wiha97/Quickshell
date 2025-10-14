import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs
import qs.modules.singles

PanelWindow {
  id: bgWindow
  property string wallpaper: {
    let model = screen.model;
    for(let i = 0; i < Conf.backgrounds.length; i++) {
      let split = Conf.backgrounds[i].split(":");
      let mon = split[0];
      let wp = split[1];
      if(mon == model) {
        if(!wp.includes(Conf.wpPath) && wp.length > 0)
          wp = WPService.getWPByName(wp);
        return wp;
      }
    }
    return null
  }
  visible: wallpaper.length > 0
  color: "transparent"
  exclusionMode: ExclusionMode.Ignore
  aboveWindows: false
  anchors {
    top:true
    bottom: true
    left: true
    right: true
  }
  ClippingRectangle {
    anchors.fill: parent
    color: "transparent"
    Image {
      id: img
      source: bgWindow.wallpaper
      anchors.fill: parent
      sourceSize.width: screen.width
      sourceSize.height: screen.height
      fillMode: Image.PreserveAspectCrop
    }
  }
  Label {
    id: splashLab
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    padding: 50
    font.pixelSize: Conf.fontSize * 1.2
    color: "#79CDBE"
    text: HyprSplash.msg
  }
}
