import QtQuick
import Quickshell
import "root:/"

Rectangle {
  property string mainColor: Conf.mainColor
  property string accentColor: Conf.accentColor
  property string txtColor: accentColor
  property string mainBColor: accentColor
  property string secBColor: accentColor
  property string secTxtColor: accentColor
  property int widgetHeight: Conf.widgetHeight
  property int rad: Conf.rad
  property int fontSize: Conf.fontSize

  color: mainColor
  height: widgetHeight
  radius: rad
  border.color: mainBColor
}
