//@ pragma UseQApplication
// ^ Needed for systray popup

import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland
import qs.modules
import qs.modules.bar
import qs.modules.singles
import qs.modules.popups

ShellRoot {
  id: root

  property var screen
  LazyLoader {
    id: bgLoader
    loading: false
    component: Background {
      screen: root.screen
    }
  }
  Bar {
    screen: root.screen
    barWidth: screen.width - 50
  }
  Dash {
    screen: root.screen
  }
  NotiPop {
    screen: root.screen
  }

  // Gives wpPath time to set
  Timer {
    running: true
    repeat: false
    interval: 500
    onTriggered: bgLoader.loading = true
  }
  // Loader {
  //   id: bgLoader
  //   visible: true
  //   sourceComponent:
  //   // Background {}
  //   Variants {
  //     model: Quickshell.screens
  //     delegate: Component {
  //       Background {
  //         required property var modelData
  //         screen: modelData
  //       }
  //     }
  //   }
  // }
  //
  // Variants {
  //   model: Quickshell.screens;
  //   delegate: Component {
  //     Loader {
  //       required property var modelData
  //       property int hgt: Conf.barHeight
  //       sourceComponent: Bar {
  //         screen: modelData
  //         barWidth: modelData.width - 50
  //         // barHeight: Hyprland.workspaces.values.length < 7 ? hgt : hgt * 0.8
  //       }
  //     }
  //   }
  // }
  //
  // Loader {
  //   sourceComponent:
  //   Variants {
  //     model: Quickshell.screens;
  //     delegate: Component {
  //       Dash {
  //         required property var modelData
  //         screen: modelData
  //       }
  //     }
  //   }
  // }
  //
  // Variants {
  //   model: Quickshell.screens;
  //   delegate: Component {
  //     NotiPop {
  //       required property var modelData
  //       screen: modelData
  //     }
  //   }
  // }
}
