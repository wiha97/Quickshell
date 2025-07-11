import QtQuick
import Quickshell
import Quickshell.Hyprland
import "./widgets" as Widgets

PanelWindow {
  id: panel

  property int barHeight: 50 // Default: 50
  property int widgetHeight: barHeight / 1.4
  property int rad: widgetHeight / 2
  property int fontSize: barHeight / 2
  property string mainColor: "#272727"
  property string accentColor: "#32cd32"
  property string mainBColor: accentColor
  property string secBColor: accentColor
  property string txtColor: accentColor
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
    top: 10
    left: 15
    right: 15
    bottom: 10
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
      Rectangle{
        color: mainColor
        width: dateRow.width
        height: widgetHeight
        radius: rad
        border.color: mainBColor

        Row {
          id: dateRow
          anchors.centerIn: parent
          padding: 10

          Text {
            id: timeDisp
            property string cTime: "..."


            text: cTime + " \udb82\udd54"
            color: txtColor
            font.pixelSize: fontSize

            Timer {
              interval: 1000
              running: true
              repeat: true

              onTriggered: {
                var date = new Date()
                timeDisp.cTime = Qt.formatTime(date, "HH:mm")
              }
            }
          }
        }
      }
    }
  }
}
