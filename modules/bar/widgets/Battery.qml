import QtQuick
import Quickshell
import Quickshell.Services.UPower


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
