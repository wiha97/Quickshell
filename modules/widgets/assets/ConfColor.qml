import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import Quickshell
import qs

Rectangle {
  required property string confName
  required property string confColor

  color: "transparent"
  width: parent.width
  height: 20
  Label {
    width: confName.length * 10
    Text {
      text: confName
      color: Conf.secTxtColor
      font.pixelSize: Conf.fontSize
    }
  }
  Rectangle {
    anchors {
      right: parent.right
    }
    height: parent.height
    width: 50
    border.color: Conf.accentColor
    radius: 5
    color: confColor
  }
    MouseArea {
      anchors.fill: parent
      onClicked: dialog.open()
    }

  ColorDialog {
    id: dialog
    selectedColor: confColor
    options: ColorDialog.ShowAlphaChannel
    onAccepted: setCol(selectedColor)
  }
}
