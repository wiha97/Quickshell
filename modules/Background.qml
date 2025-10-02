import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs
import qs.modules.singles

PanelWindow {
  id: bgWindow
  visible: Conf.background
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
      source: Conf.background
      // anchors.fill: parent
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
