pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs

Singleton {
  id: root
  property list<string> walls
  property string lockscreen

  Timer {
    running: true
    repeat: false
    interval: 200
    onTriggered: proc.running = true
  }

  Process {
    id: proc
    running: false
    command: ["ls", Conf.wpPath]
    stdout: StdioCollector {
      onStreamFinished: {
        let output = this.text.split("\n");
        for(let i = 0; i < output.length; i++) {
          let wp = output[i];
          if(wp.length > 0 && wp != "assets") {
            root.walls.push(Conf.wpPath + "/" + wp);
          }
        }
        lockscreen = root.walls[Math.floor(Math.random() * root.walls.length)]
      }
    }
  }
}
