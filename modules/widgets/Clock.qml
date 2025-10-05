import QtQuick
import QtQuick.Controls
import Quickshell
import qs
import qs.modules.singles

WidBase {
  width: dateRow.width
  property bool showDate
  Row {
    id: dateRow
    anchors.centerIn: parent
    padding: 10
    spacing: 5
    Text {
      id: timeDisp
      text: showDate ? TimeService.secTime : TimeService.time
      color: txtColor
      font.pixelSize: fontSize
    }
    Text {
      text: "󰥔"
      color: txtColor
      font.pixelSize: fontSize

    }
    Text {
      visible: showDate
      color: txtColor
      font.pixelSize: fontSize
      text: TimeService.date
    }
  }
  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered: showDate = true;
    onExited: showDate = false;
  }
}
