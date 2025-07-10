import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower
import Quickshell.Io
// import "./widgets"
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

  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: barHeight
  margins {
    top: 10
    left: 15
    right: 15
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
      Rectangle {
        id: activeAppRect
        color: mainColor
        width: activeWinTxt.width
        height: widgetHeight
        radius: rad
        border.color: mainBColor

        Text {
          id: activeWinTxt
          padding: 20
          anchors.verticalCenter: parent.verticalCenter
          color: txtColor
          font.pixelSize: fontSize / 1.5
          text: "// TODO: Finish this panel"
        }
      }
    }


    //  Workspaces
    //
    Rectangle {
      anchors.centerIn: parent
      color: mainColor
      width: workspaceRow.width
      // height: workspaceRow.height + 16
      height: parent.height
      // radius: rad
      topRightRadius: rad
      topLeftRadius: rad
      bottomLeftRadius: rad
      bottomRightRadius: rad
      border.color: mainBColor

      Row {
        id: workspaceRow

        anchors.centerIn: parent
        spacing: 8
        padding: 8

        Repeater {
          model: Hyprland.workspaces

          Rectangle {
            property string wId: modelData.id
            width: barHeight * 2
            height: widgetHeight
            radius: rad / 2
            color: "#202020"
            border.color: modelData.active || wId === "-98" ? secBColor : "#202020"
            border.width: 2

            MouseArea {
              anchors.fill: parent

              onClicked: wId === "-98" ? Hyprland.dispatch("togglespecialworkspace scratchpad") :
                                         Hyprland.dispatch("workspace " + modelData.id)
            }

            Text {
              anchors.centerIn: parent
              text: wId === "-98" ? "\udb85\udce7" : modelData.name
              font.pixelSize: fontSize
              color: txtColor
            }
          }
        }

        Text {
          visible: Hyprland.workspaces.length === 0
          text: "None"
          color: txtColor
          font.pixelSize: fontSize
        }
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
        visible: SystemTray.items.values.length === 0 ? false : true
        color: mainColor
        width: sysRow.width
        height: widgetHeight
        radius: rad
        border.color: mainBColor

        Row {
          id: sysRow

          anchors.centerIn: parent

          padding: 10
          spacing: 5
          Repeater {
            model: SystemTray.items

            Rectangle {
              width: fontSize
              height: fontSize
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
                  } else if (m.button === Qt.RightButton && modelData.hasMenu) {
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
        color: mainColor
        width: powRow.width
        height: widgetHeight
        radius: rad
        border.color: mainBColor

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
                font.pixelSize: fontSize
                text: "pwr"
                color: txtColor
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
                    // icon += " "
                    // batTxt.text = icon + lvl.toFixed(0) + "%"
                    batTxt.text = lvl.toFixed(0) + "% " + icon
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
