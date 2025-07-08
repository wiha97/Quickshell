import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.SystemTray

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

  color: "transparent"

  Rectangle {
    id: bar
    anchors.fill: parent
    color: 'transparent'
    // border.color: "#123456"
    // border.width: 3
    radius: 15

    // Rectangle {
    //   anchors {
    //     left: parent.left
    //     right: parent.right
    //     verticalCenter: parent.verticalCenter
    //   }
    //   color: '#30cd30'
    //   width: workspaceRow.width + 16
    //   implicitHeight: 25
    //   radius: 15
    //   opacity: 0.7
    // }

    //  Workspaces
    //
    Rectangle {
      anchors.centerIn: parent
      color: '#272727'
      width: workspaceRow.width + 16
      height: workspaceRow.height + 16
      radius: 15
      // opacity: 0.94
    }

    Row {
      id: workspaceRow

      anchors.centerIn: parent
      // anchors {
      //   left: parent.left
      //   verticalCenter: parent.verticalCenter
      //   leftMargin: 16
      // }
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


    // Systray
    //
    Rectangle{
      color: "#272727"
      width: sysRow.width + 10
      height: timeDisp.height
      radius:15
      anchors{
        right: parent.right
        verticalCenter: parent.verticalCenter
        rightMargin: 25 + timeDisp.width
      }

      Row {
        id: sysRow

        anchors.centerIn: parent

        spacing: 5
        Repeater {
          model: SystemTray.items

          Rectangle {
            width: 24
            height: 24
            color: "transparent"

            Image {
              source: modelData.icon
              anchors.fill: parent
            }

            MouseArea {
              anchors.fill: parent
              acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

              onClicked: mouse => {
                if (mouse.button === Qt.LeftButton) {
                  modelData.activate()
                } else if (mouse.button === Qt.MiddleButton) {
                  modelData.secondaryActivate()
                } else if (mouse.button === Qt.RightButton && model.hasMenu) {
                  modelData.display(parent, mouse.x, mouse.y)
                }
              }
            }
          }
        }
      }
    }

    // Clock
    //
    Rectangle{
      color: "#272727"
      width: timeDisp.width + 5
      height: timeDisp.height
      radius:15
      anchors{
        right: parent.right
        verticalCenter: parent.verticalCenter
        rightMargin: 10
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

      text: cTime+" \udb82\udd54"
      color: "#ffffff"
      font.pixelSize: 25

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
