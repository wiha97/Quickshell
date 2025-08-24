import QtQuick
import Quickshell
import Quickshell.Services.UPower

WidBase {
  width: pow.width
  Text {
    id: pow
    color: txtColor
    anchors.centerIn: parent
    text: PowerProfiles.profile
  }
}
