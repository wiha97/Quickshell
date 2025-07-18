import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.modules.lockscreen
import qs.modules.bar
import qs.modules.widgets

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
