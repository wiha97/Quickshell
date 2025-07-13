import QtQuick
import Quickshell
import Quickshell.Bluetooth

Container {
  property var devices: Bluetooth.devices
  visible: Bluetooth.defaultAdapter.enabled ? true : false
  width: listRow.width

  Row {
    id: listRow
    anchors.centerIn: parent
    spacing: 8
    padding: 5
    Repeater {
      anchors.centerIn: parent
      model: devices
      Text {
        anchors.verticalCenter: parent
        color: "white"
        font.pixelSize: fontSize
        text: modelData.connected ? modelData.battery * 100 + "%" : ""
      }
    }

    Text {
      color: txtColor
      font.pixelSize: fontSize
      text: "\udb80\udcaf"
    }
  }
}
