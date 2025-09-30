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
    // command: ["btop"]
    // stdout: SplitParser {
    //   onRead: data => {
    //     label.text = data
    //   }
    // }
    command: ["fastfetch", "--logo", "none"]
    stdout: StdioCollector {
      onStreamFinished: root.info = this.text
    }
  }
}
