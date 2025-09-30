import QtQuick
import QtQuick.Controls
import qs
import qs.modules.singles

Rectangle {
  color: "transparent"
  anchors.centerIn: parent
  Label {
  anchors.centerIn: parent
    id: label
    text: Fetch.info
    font.pixelSize: Conf.fontSize * 0.8
    font.family: "MesloLGS NF"
  }
}
