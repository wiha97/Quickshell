import QtQuick
import Quickshell
import Quickshell.Hyprland

PanelWindow {
  id: panel

  anchors {
    bottom: true
    left: true
    right: true
  }

  implicitHeight: 50
  margins {
    bottom: 8
    left: 8
    right: 8
  }


  Rectangle {
    id: bar
    anchors.fill: parent
    color: '#272727'
    border.color: "#123456"
    border.width: 3
    radius: 15

    Row {
      id: workspaceRow

      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
        leftMargin: 16
      }
      spacing: 8

      Repeater {
        model: Hyprland.workspaces

        Rectangle {
          width: 120
          height: 35
          radius: 7
          color: "#202020"
          border.color: modelData.active ? "#1E90FF" : "#202020"
          border.width: 2

          MouseArea {
            anchors.fill: parent

            onClicked: Hyprland.dispatch("workspace " + modelData.id)
          }

          Text {
            anchors.centerIn: parent
            text: modelData.id
            font.pixelSize: 25
            color: "#ffffff"
          }
        }
      }

      Text {
        visible: Hyprland.workspaces.length === 0
        text: "None"
        color: "#ffffff"
        font.pixelSize: 25
      }
    }

    Text {
      id: timeDisp
      property string cTime: "..."

      anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
        rightMargin: 10
      }

      text: cTime
      color: "#ffffff"
      font.pixelSize: 25

      Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
          var date = new Date()
          timeDisp.cTime = Qt.formatTime(date, "HH:mm:ss")
        }
      }

      // Component.onCompleted: {
      //   var date = new Date()
      //   cTime = Qt.formatTime(date, "HH:mm:ss")
      // }
    }
  }
}
