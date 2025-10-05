pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs

Singleton {
  id: root
  property list<string> walls
  property string lockscreen

  function getWPByName(name){
    console.log(walls.length + " Looking for WP with name " + name)
    // walls.forEach((wp) => {
    for(let i = 0; i < walls.length; i++){
      let wp = walls[i];
      // console.log(wp)
      if(wp.includes(name) && name.length > 0){
        // console.log("WP contains " + name)
        return wp;
      }
    }
    // return walls.filter((wp)=>wp.includes(name)).first()
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
            let fullPath = Conf.wpPath + "/" + wp;
            root.walls.push(fullPath);
            if(fullPath.includes(Conf.lockscreen)){
              root.lockscreen = fullPath;
              console.log(fullPath);
            }
          }
        }
      }
    }
  }

  // Gives wpPath time to set
  Timer {
    running: true
    repeat: false
    interval: 300
    onTriggered: proc.running = true
  }
}
