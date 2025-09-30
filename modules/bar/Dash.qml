import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Fusion
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Widgets
import qs
import qs.modules.singles
import qs.modules.widgets
import qs.modules.widgets.assets

PanelWindow {
  id: dashy
  focusable: true
  property string mainColor: Conf.mainColor
  property string mainBColor: Conf.mainBColor
  property int dashHeight: screen.height / 2
  property int dashWidth: screen.width / 2
  property int rad: 25
  property int stowedHeight: 22
  Component.onCompleted: {
    this.WlrLayershell.layer = WlrLayer.Top;
    this.WlrLayershell.keyboardFocus = KeyboardFocus.OnDemand;
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
    bottom: -dashHeight + stowedHeight
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
        margins.bottom = -dashHeight+stowedHeight;
      }
    }
    ColumnLayout {
      anchors.fill: parent
      Row {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 5
        Text {
          anchors.verticalCenter: parent.verticalCenter
          text: TitleService.title
          color: Conf.txtColor
          font.pixelSize: screen.height / 100
        }
        Text {
          visible: TitleService.icon === "N/A"
          text: ""
          color: "#589FEF"
          // font.pixelSize: fSize
          anchors.verticalCenter: parent.verticalCenter
        }
        Rectangle {
          visible: TitleService.icon != "N/A"
          anchors.verticalCenter: parent.verticalCenter
          width: Conf.fontSize
          height: Conf.fontSize
          color: "transparent"
          Image {
            anchors.fill: parent
            source: Quickshell.iconPath(Conf.getIcon(TitleService.icon))
          }
        }
      }
      RowLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        // anchors.fill: parent
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
              view: "../widgets/SystemInfo.qml"
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
        GlobalShortcut{
          name: "toggle-apps"
          onPressed: {
            if(screen.name == Hyprland.focusedMonitor.name) {
              viewLoader.source = "../widgets/Apps.qml"
              dashy.margins.bottom = -5;
            }
          }
        }
        Keys.onPressed: (event)=>{
          if(event.key == Qt.Key_Escape){
            dashy.margins.bottom = -dashHeight+10;
          }
        }
      }
      Wallpapers {
        id: wpview
        visible: false
      }
    }
  }
}
