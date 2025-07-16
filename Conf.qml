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

  property int barHeight: job.barHeight ? job.barHeight : 50 // Default: 50
  property int widgetHeight: getVal(job.widgetHeight, barHeight / 1.4)
  property int rad: job.rad ? job.rad : widgetHeight / 2
  property int fontSize: barHeight / 2
  property int topMarge: getVal(job.margin, 10)
  property string mainColor: getVal(job.mainColor, "red")
  property string accentColor: getVal(job.accentColor, "dodgerblue")
  property string mainBColor: getVal(job.mainBColor, accentColor)
  property string secBColor: getVal(job.secBColor, accentColor)
  property string txtColor: getVal(job.txtColor, accentColor)
  property string secTxtColor: getVal(job.secTxtColor, txtColor)
  property bool showLine: getVal(job.showLine, true)
  property bool barOnTop: getVal(job.barOnTop, true)
}
