pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  FileView {
    id: jsonFile
    path: Qt.resolvedUrl("./conf.json")

    blockLoading: true
  }

  readonly property var job: JSON.parse(jsonFile.text())

  function getVal(input, value){
    if(input === null)
      return value;
    return input;
  }

  function getIcon(app){
    // console.log(DesktopEntries.applications.values.length)
    let apps = DesktopEntries.applications;
    switch (app) {
      case "jetbrains-rider":
        app = "rider";
      case "jetbrains-idea":
        app = "intellij";
      case "com.github.ismaelmartinez.teams_for_linux":
        app = "teams"
      case "distro":
        app = "cachyos hello"
    }
    for(let i = 0; i < apps.values.length; i++){
      let entry = apps.values[i];
      if(entry.name.toLowerCase().includes("cachy"))
        console.log(entry.name)
      if(entry.name.toLowerCase().includes(app))
      {
        return entry.icon;
      }
    }
    console.log("Did not find icon for: " + app)
  }


  property int barHeight: job.barHeight ? job.barHeight : 50 // Default: 50
  property int barWidth: job.barWidth ? job.barWidth : Screen.width
  property int widgetHeight: getVal(job.widgetHeight, barHeight / 1.4)
  property int lineHeight: getVal(job.lineHeight, widgetHeight / 4)
  property int rad: job.rad ? job.rad : widgetHeight / 2
  property int fontSize: barHeight / 2
  property int topMarge: getVal(job.topMargin, 10)
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
}
