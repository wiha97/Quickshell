import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Fusion
import Quickshell
import Quickshell.Io
import qs
import qs.modules.singles

WidBase {
  id: base
  width: dateRow.width
  property bool showDate
  property bool showCal: false
  Row {
    id: dateRow
    anchors.centerIn: parent
    padding: 10
    spacing: 5
    Label {
      id: timeDisp
      anchors.verticalCenter: parent.verticalCenter
      text: showDate ? TimeService.secTime : TimeService.time
      font.pixelSize: fontSize
      color: txtColor
    }
    Text {
      text: "󰥔"
      color: txtColor
      font.pixelSize: fontSize

    }
    Label {
      visible: showDate
      // color: txtColor
      anchors.verticalCenter: parent.verticalCenter
      font.pixelSize: fontSize
      text: TimeService.date + " "
      color: txtColor
    }
  }
  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered: showDate = true;
    onExited: {
      showDate = false;
      // showCal = false;
    }
    onClicked: showCal = !showCal
  }
  PanelWindow {
    visible: showCal
    anchors {
      top: true
      right: true
    }
    margins {
      right: 30
    }
    implicitWidth: 250
    implicitHeight: 190
    color: "transparent"
    Rectangle {
      anchors.fill: parent
      color: mainColor
      radius: rad
      border.color: mainBColor
      Label {
        id: cal
        anchors.centerIn: parent
        text: TimeService.cal
        color: txtColor
        font.pixelSize: 18
        font.family: "JetBrainsMonoNL Nerd Font Mono"
      }
    }

    MouseArea {
      anchors.fill: parent
      hoverEnabled: true
      onExited: showCal = false
    }
  }
}
