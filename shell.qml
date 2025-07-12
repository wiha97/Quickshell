//@ pragma UseQApplication

import QtQuick
import Quickshell
import "./modules/bar/"
import Quickshell.Hyprland

ShellRoot {
  id: root

  Loader {
    active: true
    property int hgt: 50
    sourceComponent: Bar {
      // Conf.barHeight: Hyprland.workspaces.values.length < 8 ? hgt : hgt * 0.8
      // showLine: false
    }
  }
  // Loader {
  //   active: Hyprland.workspaces.values.length > 8 ? true : false
  //   sourceComponent: SecBar {
  //     barOnTop: false
  //     barHeight: 40
  //   }
  // }
}
