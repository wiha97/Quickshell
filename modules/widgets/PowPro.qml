import QtQuick
import Quickshell
import Quickshell.Services.UPower

Container {
  width: pow.width
  Text {
    id: pow
    color: txtColor
    anchors.centerIn: parent
    text: PowerProfiles.hasPerformanceProfile
  }
}
