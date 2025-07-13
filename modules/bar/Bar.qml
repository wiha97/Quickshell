import QtQuick
import Quickshell
import Quickshell.Hyprland
import "./widgets" as Widgets
import QtQuick.Effects
import "root:/"


PanelWindow {
  id: panel

  property int barHeight: Conf.barHeight // Default: 50
  property int widgetHeight: barHeight / 1.4
  property int rad: widgetHeight / 2
  property int fontSize: barHeight / 2
  property int topMarge: 10
  property string mainColor: Conf.mainColor
  property string accentColor: Conf.accentColor
  property string mainBColor: accentColor
  property string secBColor: accentColor
  property string txtColor: accentColor
  property string secTxtColor: txtColor
  property bool showLine: true
  property bool barOnTop: true

  anchors {
    top: barOnTop
    left: true
    right: true
    bottom: !barOnTop
  }

  implicitHeight: barHeight
  margins {
    top: topMarge
    left: 15
    right: 15
    bottom: topMarge
  }

  color: "transparent"

  Rectangle {
    id: bar
    anchors.fill: parent
    color: 'transparent'

    Rectangle {
      visible: showLine
      anchors {
        left: parent.left
        right: parent.right
        verticalCenter: parent.verticalCenter
      }
      height: widgetHeight / 4
      color: accentColor
      opacity: 0.8
      border.color: mainColor
      border.width:1

    }

    Row {
      id: appRow
      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
      }
      Widgets.Titlebar {
        mainColor: panel.mainColor
        accentColor: panel.accentColor
        widgetHeight: panel.widgetHeight
        rad: panel.rad
        fontSize: panel.fontSize
      }
    }


    //  Workspaces
    //
    Row {
      anchors.centerIn: parent

      Widgets.Workspaces {
        mainColor: panel.mainColor
        accentColor: panel.accentColor
        widgetHeight: panel.widgetHeight
        rad: panel.rad
        fontSize: panel.fontSize
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

      Widgets.Systray {
        mainColor: panel.mainColor
        accentColor: panel.accentColor
        widgetHeight: panel.widgetHeight
        rad: panel.rad
        fontSize: panel.fontSize
      }
      Widgets.Bluetooth {
        mainColor: panel.mainColor
        accentColor: panel.accentColor
        widgetHeight: panel.widgetHeight
        rad: panel.rad
        fontSize: panel.fontSize
      }
      Widgets.Battery {
        mainColor: panel.mainColor
        accentColor: panel.accentColor
        widgetHeight: panel.widgetHeight
        rad: panel.rad
        fontSize: panel.fontSize
      }

      // Clock
      //
      Widgets.Clock {
        mainColor: panel.mainColor
        accentColor: panel.accentColor
        widgetHeight: panel.widgetHeight
        rad: panel.rad
        fontSize: panel.fontSize
      }
    }
  }
}
