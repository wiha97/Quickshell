import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Fusion
import Quickshell
import Quickshell.Widgets
import qs
import qs.modules.widgets
import qs.modules.widgets.assets

PanelWindow {
  property string mainColor: Conf.mainColor
  property string mainBColor: Conf.mainBColor
  property int dashHeight: 500
  property int dashWidth: Screen.width / 2
  property int rad: 25

  implicitHeight: dashHeight
  implicitWidth: dashWidth
  exclusionMode: ExclusionMode.Ignore

  anchors {
    bottom: true
    left: false
    right: false
  }

  margins {
    bottom: -dashHeight + 10
  }

  color: "transparent"

  ClippingRectangle {
    anchors.fill: parent
    topRightRadius: rad
    topLeftRadius: rad
    color: mainColor
    border.color: mainBColor
    border.width: 2
    clip: true

    MouseArea {
      anchors.fill: parent
      hoverEnabled: true

      onEntered: margins.bottom = -10;
      onExited: margins.bottom = -dashHeight+10;
    }
    Item {
      clip: true
      anchors.fill: parent
      RowLayout{
        anchors.fill: parent
        Rectangle {
          topLeftRadius: rad
          width: 150
          Layout.fillHeight: true
          // height: parent.height
          color: "transparent"
          ColumnLayout {
            // property QtObject activeView
            anchors.top: parent.top
            width: parent.width
            DashBtn {
              // topLeftRadius: rad
              title: "Overview"
              view: "../widgets/Titlebar.qml"
              loader: viewLoader
            }
            DashBtn {
              title: "Apps"
              view: "../widgets/Apps.qml"
              loader: viewLoader
            }
            DashBtn {
              title: "Settings"
              view: "../widgets/Settings.qml"
              loader: viewLoader
            }
          }
        }
        Loader {
          id: viewLoader
          source: "../widgets/Apps.qml"
          Layout.fillWidth: true
          Layout.fillHeight: true
        }
      }
    }
  }
}
