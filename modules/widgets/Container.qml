import QtQuick
import Quickshell
import "root:/"

Rectangle {
  property QtObject parentId: Conf
  property string mainColor: parentId.mainColor
  property string accentColor: parentId.accentColor
  property string txtColor: parentId.txtColor
  property string mainBColor: parentId.mainBColor
  property string secBColor: parentId.secBColor
  property string secTxtColor: parentId.secTxtColor
  property int widgetHeight: parentId.widgetHeight
  property int rad: parentId.rad
  property int fontSize: parentId.fontSize

  color: mainColor
  height: widgetHeight
  radius: rad
  border.color: mainBColor
}
