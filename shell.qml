//@ pragma UseQApplication
// ^ Needed for systray popup

import QtQuick
import Quickshell
import qs.modules.bar
import Quickshell.Hyprland

ShellRoot {
  id: root

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
