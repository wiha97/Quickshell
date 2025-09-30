pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs

Singleton {
  id: root
  property string info

  Process {
    running: true
    command: ["fastfetch", "--logo", "none"]
    stdout: StdioCollector {
      onStreamFinished: root.info = this.text
    }
  }
}
