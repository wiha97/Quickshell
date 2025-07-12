import QtQuick
import Quickshell
import Quickshell.Bluetooth
import "root:/"

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
        font.pixelSize: Conf.fontSize
        text: modelData.connected ? modelData.battery * 100 + "%" : ""
      }
    }

    Text {
      color: Conf.txtColor
      font.pixelSize: Conf.fontSize
      text: "\udb80\udcaf"
    }
  }
}
