import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs
import qs.modules.singles

PanelWindow {
  id: bgWindow
  visible: Conf.perMonBgs.length && Conf.showWP
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
      // source: Conf.background
      source: {
        let model = screen.model;
        for(let i = 0; i < Conf.perMonBgs.length; i++) {
          let wp = Conf.perMonBgs[i]
          if(wp.startsWith(model)){
            let wpName = wp.substring(wp.indexOf(":")+1);
            if(!wpName.includes(Conf.wpPath))
              wpName = WPService.getWPByName(wpName)
            // console.log("wp: "+wpName+" "+model);
            return wpName;
            // return Conf.wpPath+"/"+wp.substring(wp.indexOf(":")+1)
          }
        }
      }
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
