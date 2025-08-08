import QtQuick
import QtQuick.Controls
import Quickshell
import qs

Rectangle {
  required property string confName
  required property bool confBool

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
  Switch {
    anchors.right: parent.right
    checked: confBool
    onClicked: switchBool();
    hoverEnabled: false
  }
  // Rectangle {
  //   width: Conf.fontSize
  //   height: Conf.fontSize
  //   anchors.right: parent.right
  //   Label {
  //     Text {
  //       font.pixelSize: Conf.fontSize
  //       visible: confBool
  //       text: "X"
  //     }
  //   }
  // }
  // CheckBox {
  //   anchors {
  //     right: parent.right
  //   }
  // }
}
