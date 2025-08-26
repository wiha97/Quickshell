pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property string msg

  Process {
    id: proc
    running: true
    command: ["hyprctl", "splash"]
    stdout: StdioCollector {
      onStreamFinished: root.msg = this.text
    }
  }
}
