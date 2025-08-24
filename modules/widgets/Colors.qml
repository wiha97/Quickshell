import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Fusion
import Quickshell
import qs
import qs.modules.widgets
import qs.modules.widgets.assets

Rectangle {
  color: "transparent"
  Row {
    anchors.fill: parent
    padding: 5
    spacing: 15
    ColumnLayout {
      Label {
        Layout.fillWidth: true
        text: "THEMES"
        horizontalAlignment: Text.AlignHCenter
      }
      Rectangle {
        property string name: "DEFAULT"
        width: 200
        height: 35
        color: Conf.hilightColor
        Label {
          anchors.centerIn: parent
          text: parent.name
          color: "white"
          font.pixelSize: Conf.fontSize
        }
        MouseArea {
          anchors.fill: parent
          onClicked: Conf.job = Conf.changeTheme(parent.name.toLowerCase())
        }
      }
      Rectangle {
        property string name: "XBOX"
        width: 200
        height: 35
        color: Conf.hilightColor
        Label {
          anchors.centerIn: parent
          text: parent.name
          color: "#32cd32"
          font.pixelSize: Conf.fontSize
        }
        MouseArea {
          anchors.fill: parent
          onClicked: Conf.job = Conf.changeTheme(parent.name.toLowerCase())
        }
      }
    }
    ColumnLayout {
      width: parent.width / 2 - 15
      height: parent.height
      Label {
        Layout.fillWidth: true
        text: "COLORS"
        horizontalAlignment: Text.AlignHCenter
      }
      ScrollView {
        Layout.fillHeight: true
        Layout.fillWidth: true
        hoverEnabled: false
        // anchors.centerIn: parent
        ScrollBar.vertical {
          visible: true
          // policy: ScrollBar.AlwaysOn
        }
        Column {
          id: column
        // anchors.centerIn: parent
          width: parent.width
          // height: parent.height
          spacing: 30
          ConfColor {
            confName: "Main Color"
            confColor: Conf.mainColor
            function setCol(colr){
              Conf.mainColor = colr;
            }
          }
          ConfColor {
            confName: "Secondary Color"
            confColor: Conf.secColor
            function setCol(colr){
              Conf.secColor = colr;
            }
          }
          ConfColor {
            confName: "Line Color"
            confColor: Conf.lineColor
            function setCol(colr){
              Conf.lineColor = colr;
            }
          }
          ConfColor {
            confName: "Accent Color"
            confColor: Conf.accentColor
            function setCol(colr){
              Conf.accentColor = colr;
            }
          }
          ConfColor {
            confName: "Highlight Color"
            confColor: Conf.hilightColor
            function setCol(colr){
              Conf.hilightColor = colr;
            }
          }
          ConfColor {
            confName: "Border Color"
            confColor: Conf.mainBColor
            function setCol(colr){
              Conf.mainBColor = colr;
            }
          }
          ConfColor {
            confName: "Secondary Border Color"
            confColor: Conf.secBColor
            function setCol(colr){
              Conf.secBColor = colr;
            }
          }
          ConfColor {
            confName: "Text Color"
            confColor: Conf.txtColor
            function setCol(colr){
              Conf.txtColor = colr;
            }
          }
          ConfColor {
            confName: "Secondary Text Color"
            confColor: Conf.secTxtColor
            function setCol(colr){
              Conf.secTxtColor = colr;
            }
          }
        }
      }
    }
  }
}
