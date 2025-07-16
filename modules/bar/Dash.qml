import QtQuick
import Quickshell
import "root:/"

PanelWindow {
  property string mainColor: Conf.mainColor
  property string mainBColor: Conf.mainBColor
  property int dashHeight: 500
  property int dashWidth: Screen.width / 2
  property int rad: 25

  implicitHeight: dashHeight
  implicitWidth: dashWidth

  anchors {
    bottom: true
    left: false
    right: false
  }

  margins {
    bottom: -dashHeight + 10
  }

  color: "transparent"

  Rectangle {
    anchors.fill: parent
    topRightRadius: rad
    topLeftRadius: rad
    color: mainColor
    border.color: mainBColor
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true

    onEntered: margins.bottom = -10;
    onExited: margins.bottom = -dashHeight+10;
  }
}
