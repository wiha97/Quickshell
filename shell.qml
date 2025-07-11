//@ pragma UseQApplication

import QtQuick
import Quickshell
import "./modules/bar/"
import Quickshell.Hyprland

ShellRoot {
  id: root

  Loader {
    active: true
    sourceComponent: Bar{}
    property int hgt: 50
    sourceComponent: Bar {
      barHeight: Hyprland.workspaces.values.length < 8 ? hgt : hgt * 0.8 
    }
  }
}
