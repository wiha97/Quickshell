import QtQuick
import Quickshell
import Quickshell.Wayland
import "./modules/lockscreen/"
import "./modules/bar/"
import "./modules/bar/widgets/"

ShellRoot {
  LockContext {
    id: lockContext

    onUnlocked: {
      lock.locked = false;

      Qt.quit();
    }
  }

  WlSessionLock {
    id: lock

    locked: true

    WlSessionLockSurface {
      color: "transparent"
      LockSurface {
        anchors.fill: parent
        context: lockContext
      }
      // Battery{
      //   anchors {
      //     bottom: true
      //
      //   }
      // }
    }
  }
}
