import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower

PanelWindow {
  id: panel

  property int rad: 15
  property int barHeight: 35

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

    Rectangle {
      id: apps


    }


    //  Workspaces
    //
    Rectangle {
      anchors.centerIn: parent
      color: '#272727'
      width: workspaceRow.width + 16
      height: workspaceRow.height + 16
      radius: rad
    }

    Row {
      id: workspaceRow

      anchors.centerIn: parent
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

    Row {
      id: infoRow

      spacing: 10

      anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
      }

      // Systray
      //
      Rectangle{
        color: "#272727"
        width: sysRow.width
        height: barHeight
        radius: rad

        Row {
          id: sysRow

          anchors.centerIn: parent

          padding: 10
          spacing: 5
          Repeater {
            model: SystemTray.items

            Rectangle {
              width: 20
              height: 20
              color: "transparent"

              Image {
                source: modelData.icon
                anchors.fill: parent
              }

              MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                onClicked: m => {
                  if (m.button === Qt.LeftButton) {
                    modelData.activate()
                  } else if (m.button === Qt.MiddleButton) {
                    modelData.secondaryActivate()
                  } else if (m.button === Qt.RightButton && model.hasMenu) {
                    modelData.display(parent, m.x, m.y)
                  }
                }
              }
            }
          }
        }
      }

      //  Battery
      //
      Rectangle {
        color: "#272727"
        width: powRow.width
        height: barHeight
        radius: rad

        Row {
          id: powRow
          spacing:5
          padding: 10
          anchors.centerIn: parent

          Repeater {
            model: UPower.displayDevice
            Rectangle{
              width: batTxt.width
              height: 24
              color: "transparent"
              Text {
                id: batTxt
                font.pixelSize: 25
                text: "bat"
                color: "#ffffff"
                anchors.centerIn: parent
                Timer {
                  interval: 1000
                  running: true
                  repeat: true

                  onTriggered: {
                    let lvl = modelData.percentage * 100
                    let icon = modelData.state === 2 ? "" : "\udb81\udea5"
                    if (lvl < 10)
                      icon += "\udb80\udc83"
                    else if (lvl < 15)
                      icon += "\udb80\udc7a"
                    else if (lvl < 20)
                      icon += "\udb80\udc7b"
                    else if (lvl < 30)
                      icon += "\udb80\udc7c"
                    else if (lvl < 40)
                      icon += "\udb80\udc7d"
                    else if (lvl < 50)
                      icon += "\udb80\udc7e"
                    else if (lvl < 60)
                      icon += "\udb80\udc7f"
                    else if (lvl < 70)
                      icon += "\udb80\udc80"
                    else if (lvl < 80)
                      icon += "\udb80\udc81"
                    else if (lvl < 90)
                      icon += "\udb80\udc82"
                    else if (lvl < 100)
                      icon += "\udb80\udc79"
                    icon += " "
                    batTxt.text = icon + lvl + "%"
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
        width: dateRow.width
        height: barHeight
        radius: rad

        Row {
          id: dateRow
          anchors.centerIn: parent
          padding: 10

          Text {
            id: timeDisp
            property string cTime: "..."


            text: cTime + " \udb82\udd54"
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
    }
  }
}
