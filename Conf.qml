pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

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
    // let apps = DesktopEntries.applications;
    // console.log("Setting icon for "+app)
    switch (app) {
      case "jetbrains-rider":
        app = "rider";
        break;
      case "jetbrains-idea":
        app = "intellij";
        break;
      case "com.github.ismaelmartinez.teams_for_linux":
        app = "teams";
        break;
      case "org.ijhack.qtpass":
        app = "qtpass";
        break;
      case "org.kde.dolphin":
        app = "dolphin";
        break;
      case "org.kde.discover":
        app = "upptäck";
        break;
      case "distro":
        app = "cachyos hello";
        break;
    }
    for(let i = 0; i < apps.length; i++){
      let entry = apps[i];
      // if(entry.name.toLowerCase().includes("cachy"))
        // console.log(entry.name)
      if(entry.name.toLowerCase().includes(app))
      {
        return entry.icon;
      }
    }
    console.log("Did not find icon for: " + app)
  }

  Process {
    running: true
    command: ["notify-send", "-a", "Quickshell", "Loaded Quickshell"]
  }


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
  property string wpPath: "/home/tux/Pictures/Wallpapers/"
  property string background: getVal(job.background, "/home/tux/Pictures/Wallpapers/halodark.png")
}
