import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Fusion
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs
import qs.modules.widgets
import qs.modules.widgets.assets

PanelWindow {
  property string mainColor: Conf.mainColor
  property string mainBColor: Conf.mainBColor
  property int dashHeight: screen.height / 2
  property int dashWidth: screen.width / 2
  property int rad: 25
  Component.onCompleted: {
    if (this.WlrLayershell != null) {
      this.WlrLayershell.layer = WlrLayer.Top;
      this.WlrLayershell.keyboardFocus = KeyboardFocus.OnDemand;
    }
  }

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
    color: "transparent"
    border.color: mainBColor
    border.width: 2
    clip: true

    Rectangle {
      anchors.fill: parent
      color: mainColor
    }

    MouseArea {
      anchors.fill: parent
      hoverEnabled: true

      onEntered: {
        margins.bottom = -5;
        timer.stop();
      }
      onExited: timer.start()
    }
    Timer {
      id: timer
      repeat: false
      interval: 300
      onTriggered: {
        margins.bottom = -dashHeight+10;
      }
    }
    RowLayout{
      anchors.fill: parent
      Rectangle {
        // topLeftRadius: rad
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
          DashBtn {
            title: "Themes"
            view: "../widgets/Colors.qml"
            loader: viewLoader
          }
          DashBtn {
            title: "Wallpapers"
            view: "../widgets/Wallpapers.qml"
            loader: viewLoader
          }
        }
      }
      Loader {
        Layout.margins: 10
        id: viewLoader
        focus: true
        source: "../widgets/Settings.qml"
        Layout.fillWidth: true
        Layout.fillHeight: true
      }
      Wallpapers {
        id: wpview
        visible: false
      }
      Keys.onPressed: (event)=>{
        console.log("pressed key", event.text);
      }
    }
  }
}
