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
  // border.color: "red"
  Row {
    anchors.fill: parent
    padding: 5
    spacing: 15

    ColumnLayout {
      width: parent.width / 2 - 15
      height: parent.height
      Label {
        Layout.fillWidth: true
        text: "OPTIONS"
        horizontalAlignment: Text.AlignHCenter
      }
      ScrollView {
        Layout.fillHeight: true
        Layout.fillWidth: true
        hoverEnabled: false
        Column {
          width: parent.width
          spacing: 30
          ConfSlider {
            confName: "Bar Height"
            confInt: Conf.barHeight
            min: 10
            max: 100
            step: 5
            function setVal(val){
              Conf.barHeight = val;
            }
          }
          ConfSlider {
            confName: "Bar Width"
            confInt: Conf.barWidth
            min: 1000
            max: Screen.width
            step: 100
            function setVal(val){
              Conf.barWidth = val;
            }
          }
          ConfSlider {
            confName: "Bar Top Margin"
            confInt: Conf.topMarge
            min: 0
            max: 25
            step: 5
            function setVal(val){
              Conf.topMarge = val;
            }
          }
          ConfSlider {
            confName: "Bar Side Margin"
            confInt: Conf.sideMarge
            min: 0
            max: 25
            step: 5
            function setVal(val){
              Conf.sideMarge = val;
            }
          }
          ConfSlider {
            confName: "Widget Height"
            confInt: Conf.widgetHeight
            min: 10
            max: 100
            step: 5
            function setVal(val){
              Conf.widgetHeight = val;
            }
          }
          ConfSlider {
            confName: "Corner Radius"
            confInt: Conf.rad
            min: 0
            max: 25
            step: 1
            function setVal(val){
              Conf.rad = val;
            }
          }
          ConfSlider {
            confName: "Font Size"
            confInt: Conf.fontSize
            min: 15
            max: 40
            step: 5
            function setVal(val){
              Conf.fontSize = val;
            }
          }
          ConfSlider {
            confName: "Line Height"
            confInt: Conf.lineHeight
            min: 1
            max: Conf.barHeight
            step: 5
            function setVal(val){
              Conf.lineHeight = val;
            }
          }
          ConfCheckbox {
            confName: "Show line"
            confBool: Conf.showLine
            function switchBool(){
              Conf.showLine = !Conf.showLine;
            }
          }
          ConfCheckbox {
            confName: "Bar on top"
            confBool: Conf.barOnTop
            function switchBool(){
              Conf.barOnTop = !Conf.barOnTop;
            }
          }
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
            confName: "Acc Color"
            confColor: Conf.accentColor
            function setCol(colr){
              Conf.accentColor = colr;
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
            confName: "Sec Border Color"
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
            confName: "Sec Text Color"
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
