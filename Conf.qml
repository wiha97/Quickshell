pragma Singleton

import QtQuick
import Quickshell

Singleton {
  id: root

  property int barHeight: 50 // Default: 50
  property int widgetHeight: barHeight / 1.4
  property int rad: widgetHeight / 2
  property int fontSize: barHeight / 2
  property int topMarge: 10
  property string mainColor: "#272727"
  property string accentColor: "#32cd32"
  property string mainBColor: accentColor
  property string secBColor: accentColor
  property string txtColor: accentColor
  property string secTxtColor: txtColor
  property bool showLine: true
  property bool barOnTop: true
}
