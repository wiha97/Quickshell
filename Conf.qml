pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs

Singleton {
  id: root

  property list<string> walls
  property list<string> files;
  property list<FileView> fViews;
  property string location: "/home/tux/.config/quickshell"

  Process {
    id: getUser
    running: true
    command: ["whoami"]
    stdout: StdioCollector {
      onStreamFinished: {
        user = this.text.substring(0,this.text.indexOf("\n"))
      }
    }
  }
  property string user

  Process {
    running: true
    command: ["ls", "-f", location+"/themes"]
    stdout: StdioCollector {
      onStreamFinished: {
        let out = this.text.split("\n");
        for(let i = 0; i < out.length; i++){
          let file = out[i]
          file = file.substring(0, file.indexOf('.'));
          if(file.length > 0){
            files.push(file)
            console.log(file);
            // fViews.push();
          }
        }
      }
    }
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
      }
    }
  }

  Repeater {
    model: files
    FileView {
      id: modelData
      path: Qt.resolveUrl("./themes/"+modelData+".json")

      blockLoading: true
      watchChanges: true
      onFileChanged: reload()
    }
  }

  FileView {
    id: jsonFile
    path: Qt.resolvedUrl("./themes/conf.json")

    blockLoading: true
    watchChanges: true
    onFileChanged: reload()
  }
  FileView {
    id: xboxFile
    path: Qt.resolvedUrl("./themes/xbox.json")

    blockLoading: true
    watchChanges: true
    onFileChanged: reload()
  }

  property var job: changeTheme("default");
  // readonly property var job: JSON.parse(jsonFile.text())
  readonly property var apps: DesktopEntries.applications.values

  function changeTheme(theme) {
    // return JSON."./themes/"+theme+".json";
    switch(theme){
      case "xbox":
        return JSON.parse(xboxFile.text());
      case "default":
        return(JSON.parse(jsonFile.text()));
    }
  }

  function getVal(input, value){
    if(input === null || !input)
      return value;
    return input;
  }

  function getIcon(app){
    if(app.includes("."))
      app = app.substring(app.lastIndexOf(".")+1)
    switch (app) {
      case "jetbrains-rider":
        app = "rider";
        break;
      case "jetbrains-idea":
        app = "intellij";
        break;
      case "teams_for_linux":
        app = "teams";
        break;
      case "qtpass":
        app = "qtpass";
        break;
      case "dolphin":
        app = "dolphin";
        break;
      case "tidal-hifi":
        app = "tidal hi-fi";
        break;
      case "prismlauncher":
        app = "prism launcher";
        break;
    }
    for(let i = 0; i < apps.length; i++){
      let entry = apps[i];
      // if(entry.name.toLowerCase().includes("prism"))
      //   console.log(entry.name)
      if(entry.name.toLowerCase().includes(app))
      {
        return entry.icon;
      }
    }
    console.log("Did not find icon for: " + app)
  }

  // Process {
  //   running: true
  //   command: ["notify-send", "-a", "Quickshell", "Loaded Quickshell"]
  // }

  // Component.onCompleted: console.log("clip: "+Quickshell.clipboardText)

  property int barHeight: job.barHeight ? job.barHeight : 50 // Default: 50
  property int barWidth: job.barWidth ? job.barWidth : Screen.width -50
  property int widgetHeight: getVal(job.widgetHeight, barHeight / 1.4)
  property int lineHeight: getVal(job.lineHeight, widgetHeight / 4)
  property int rad: job.rad ? job.rad : widgetHeight / 2
  property int fontSize: barHeight / 2
  property int topMarge: getVal(job.topMargin, 0)
  property int sideMarge: getVal(job.sideMargin, 15)
  property string mainColor: getVal(job.mainColor, "#272727")
  property string secColor: getVal(job.secColor, "#202020")
  property string lineColor: getVal(job.lineColor, mainColor)
  property string accentColor: getVal(job.accentColor, "dodgerblue")
  property string hilightColor: getVal(job.hilightColor, "dodgerblue")
  property string mainBColor: getVal(job.mainBColor, accentColor)
  property string secBColor: getVal(job.secBColor, accentColor)
  property string txtColor: getVal(job.txtColor, accentColor)
  property string secTxtColor: getVal(job.secTxtColor, txtColor)
  property bool showLine: getVal(job.showLine, true)
  property bool barOnTop: getVal(job.barOnTop, true)
  // property string wpPath: "/home/tux/Pictures/Wallpapers"
  property string wpPath: getVal(job.wpPath, "/home/"+user+"/Pictures/wallpapers")
  property string background: job.background.length > 0 ? wpPath+"/"+job.background : null
  // property string background: getVal(wpPath+"/"+job.background,null)
}
