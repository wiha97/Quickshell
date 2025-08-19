import QtQuick
import QtQuick.Controls
import Quickshell
import qs

Rectangle {
  required property string confName
  required property int confInt
  required property int min
  required property int max
  required property int step

  color: "transparent"
  width: parent.width
  height: 20
  Label {
    // width: confName.length * 10
    Text {
      text: confName + ": " + confInt
      color: Conf.secTxtColor
      font.pixelSize: Conf.fontSize
    }
  }
  Slider {
    id: barSlider
    hoverEnabled: false
    anchors.right: parent.right
    from: min
    to: max
    snapMode: Slider.SnapAlways
    stepSize: step
    value: confInt
    onMoved: setVal(value)
  }
}
