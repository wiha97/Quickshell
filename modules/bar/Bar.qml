import QtQuick
import Quickshell
import Quickshell.Hyprland
import "./widgets" as Widgets
import QtQuick.Effects
import "root:/"


PanelWindow {
  id: panel

  // property int barHeight: Conf.barHeight // Default: 50
  // property int widgetHeight: barHeight / 1.4
  // property int rad: widgetHeight / 2
  // property int fontSize: barHeight / 2
  // property int topMarge: 10
  // property string mainColor: "#272727"
  // property string accentColor: "#32cd32"
  // property string mainBColor: accentColor
  // property string secBColor: accentColor
  // property string txtColor: accentColor
  // property string secTxtColor: txtColor
  // property bool showLine: true
  // property bool barOnTop: true

  anchors {
    top: Conf.barOnTop
    left: true
    right: true
    bottom: !Conf.barOnTop
  }

  implicitHeight: Conf.barHeight
  margins {
    top: Conf.topMarge
    left: 15
    right: 15
    bottom: Conf.topMarge
  }

  color: "transparent"

  Rectangle {
    id: bar
    anchors.fill: parent
    color: 'transparent'

    Rectangle {
      visible: Conf.showLine
      anchors {
        left: parent.left
        right: parent.right
        verticalCenter: parent.verticalCenter
      }
      height: Conf.widgetHeight / 4
      color: Conf.accentColor
      opacity: 0.8
      border.color: Conf.mainColor
      border.width:1

    }

    Row {
      id: appRow
      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
      }
      Widgets.Titlebar {}
    }


    //  Workspaces
    //
    Row {
      anchors.centerIn: parent

      Widgets.Workspaces {
        // visible: Hyprland.workspaces.values.length <= 8 ? true : false
      }
    }

    Row {
      id: infoRow

      spacing: 10

      anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
      }

      Widgets.Systray {}
      Widgets.Bluetooth {}
      Widgets.Battery {}

      // Clock
      //
      Widgets.Clock {}
    }
  }
}
