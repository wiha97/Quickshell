//@ pragma UseQApplication
// ^ Needed for systray popup

import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import qs.modules.bar
import qs.modules.singles
import qs.modules.popups

ShellRoot {
  id: root

  Loader {
    visible: true
    sourceComponent: PanelWindow {
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
        Image {
          id: img
          source: Conf.background
          anchors.fill: parent
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
  }

  Loader {
    property int hgt: Conf.barHeight
    sourceComponent: Bar {
      // barHeight: Hyprland.workspaces.values.length < 7 ? hgt : hgt * 0.8
    }
  }

  Loader {
    sourceComponent: Dash {}
  }

  NotiPop {}
}
