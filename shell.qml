//@ pragma UseQApplication
// ^ Needed for systray popup

import QtQuick
import Quickshell
import qs.modules.bar
import Quickshell.Hyprland

ShellRoot {
  id: root

  Loader {
    visible: true
    sourceComponent: PanelWindow {
      exclusionMode: ExclusionMode.Ignore
      aboveWindows: false
      width: Screen.width
      // height: Screen.height
      anchors {
        top:true
        bottom: true
      }
      Image {
        id: img
        source: Conf.background
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
      }
    }
  }

  Loader {
    property int hgt: Conf.barHeight
    sourceComponent: Bar {
      barHeight: Hyprland.workspaces.values.length < 7 ? hgt : hgt * 0.8
    }
  }

  Loader {
    sourceComponent: Dash {}
  }
}
