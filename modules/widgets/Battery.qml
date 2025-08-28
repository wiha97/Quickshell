import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs


//  Battery
//
WidBase {
  width: powRow.width
  // property string tColor: Conf.txtColor

  Row {
    id: powRow
    spacing:5
    padding: 10
    anchors.centerIn: parent

    Repeater {
      model: UPower.displayDevice
      Rectangle {
        width: batTxt.width
        height: 24
        color: "transparent"
        Text {
          id: batTxt
          font.pixelSize: fontSize
          text: "\udb80\udc83"
          color: txtColor
          anchors.centerIn: parent
          Timer {
            interval: 1000
            running: true
            repeat: true

            onTriggered: {
              let lvl = modelData.percentage * 100;
              let icon = modelData.state === 2 ? "" : "\udb81\udea5";
              if (lvl < 10)
                icon += "󱃍";
              else if (lvl < 15)
                icon += "󰁺";
              else if (lvl < 20)
                icon += "󰁻";
              else if (lvl < 30)
                icon += "󰁼";
              else if (lvl < 40)
                icon += "󰁽";
              else if (lvl < 50)
                icon += "󰁾";
              else if (lvl < 60)
                icon += "󰁿";
              else if (lvl < 70)
                icon += "󰂀";
              else if (lvl < 80)
                icon += "󰂁";
              else if (lvl < 90)
                icon += "󱈑";
              else if (lvl < 100)
                icon += "󰁹";
              batTxt.text = lvl.toFixed(0) + "% " + icon;
            }
          }
        }
      }
    }
  }
}
