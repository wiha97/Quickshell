//@ pragma UseQApplication
// ^ Needed for systray popup

import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import qs.modules.lockscreen
import qs.modules.singles
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
    onPressed: {
      lock.locked = true
      console.log("lock: " + Conf.lockscreen)
      if(Conf.lockscreen === "random") {
        WPService.lockscreen = WPService.walls[Math.floor(Math.random() * WPService.walls.length)]
        rndTimer.start();
      }
    }
  }
  LockContext {
    id: lockContext

    onUnlocked: {
      lock.locked = false;
      rndTimer.stop();
    }
  }

  // Picks random wp
  Timer {
    id: rndTimer
    running: false
    repeat: true
    interval: 10000
    onTriggered: WPService.lockscreen = WPService.walls[Math.floor(Math.random() * WPService.walls.length)]
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
}
