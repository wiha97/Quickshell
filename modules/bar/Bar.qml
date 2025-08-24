import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.modules.widgets as Widgets
import QtQuick.Effects
import qs


PanelWindow {
  id: panel

  function compare(local, conf){
    if(local === conf){
      return conf;
    }
  }

  property int barHeight: Conf.barHeight // Default: 50
  property int barWidth: Conf.barWidth
  property int lineHeight: Conf.lineHeight
  property int widgetHeight: barHeight / 1.4
  property int rad: widgetHeight / 2
  property int fontSize: barHeight / 2
  property int topMarge: Conf.topMarge
  property int sideMarge: Conf.sideMarge
  property string mainColor: Conf.mainColor
  property string secColor: Conf.secColor
  property string lineColor: Conf.lineColor
  property string accentColor: Conf.accentColor
  property string mainBColor: Conf.mainBColor
  property string secBColor: Conf.secBColor
  property string txtColor: Conf.txtColor
  property string secTxtColor: Conf.secTxtColor
  property bool showLine: Conf.showLine
  property bool barOnTop: Conf.barOnTop

  anchors {
    top: barOnTop
    // left: true
    // right: true
    bottom: !barOnTop
  }

  implicitHeight: barHeight
  implicitWidth: barWidth
  margins {
    top: topMarge
    left: sideMarge
    right: sideMarge
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
      height: lineHeight
      color: lineColor
      opacity: 0.8
      radius: Conf.rad
      border.color: mainBColor
      border.width:1

    }

    Row {
      id: appRow
      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
      }
      Widgets.Titlebar {
        parentId: panel
      }
    }


    //  Workspaces
    //
    Row {
      anchors.centerIn: parent

      Widgets.Workspaces {
        parentId: panel
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
        parentId: panel
      }
      Widgets.Bluetooth {
        parentId: panel
      }
      Widgets.Audio {
        parentId: panel
      }
      // Widgets.PowPro {
      //   parentId: panel
      // }
      Widgets.Battery {
        parentId: panel
      }

      Widgets.Clock {
        parentId: panel
      }
    }
  }
}
