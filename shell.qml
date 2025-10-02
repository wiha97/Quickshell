//@ pragma UseQApplication
// ^ Needed for systray popup

import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import qs.modules.lockscreen
import Quickshell.Hyprland

ShellRoot {
  id: root

  Loader {
    sourceComponent:
    Variants {
      model: Quickshell.screens
      delegate: Component {
        Desktop {
          required property var modelData
          screen: modelData
        }
      }
    }
  }
  GlobalShortcut{
    name: "lockscreen"
    onPressed: lock.locked = true
  }
  LockContext {
    id: lockContext

    onUnlocked: {
      lock.locked = false;
      // Qt.quit();
    }
  }

  WlSessionLock {
    id: lock

    locked: false

    WlSessionLockSurface {
      color: "transparent"
      LockSurface {
        anchors.fill: parent
        context: lockContext
      }
    }
  }
  // Desktop {}
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
