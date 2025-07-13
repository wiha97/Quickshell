import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects
import "root:/modules/bar/widgets"
// import qs.modules
// import "root:/modules" as Modules

Rectangle {
  id: root

  required property LockContext context

  color: "transparent"

  // Ugly "solution" for non-awkward fingerprint unlock
  //
  Component.onCompleted: context.fPrintCheck();

  //  TODO: Dynamically pick WP at random from ~/Pictures/wallpapers
  Image {
    id: img
    source: "/home/tux/Pictures/Wallpapers/Cachy depths 5K.png"
    anchors.fill: parent
    fillMode: Image.PreserveAspectCrop
  }
  FastBlur{
    source: img
    radius: 40
    anchors.fill: parent
  }
  // Rectangle {
  //   anchors.fill: parent
  //   color: "black"
  //   opacity: 0.6
  // }
  Rectangle {
    anchors.fill: parent
    color: "transparent"
    height: statusRow.height
    width: parent.width
    Row {
      id: statusRow
      anchors {
        bottom: parent.bottom
        right: parent.right
      }
      Battery {
        accentColor: "white"
      }
    }
  }

  //  In case of bork
  //
  // Button {
  //   text: "abort!"
  //   onClicked: context.unlocked();
  // }


  ColumnLayout {
    spacing: Screen.height / 2

    anchors.centerIn: parent

    Label {
      id: clock
      property var date: new Date()

      anchors {
        horizontalCenter: parent.horizontalCenter
      }

      renderType: Text.NativeRendering
      font.pointSize: 80

      Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: clock.date = new Date();
      }

      text: Qt.formatTime(date, "HH:mm")
    }

    ColumnLayout {
      spacing: 100
      ColumnLayout {

        TextField {
          id: passwordBox

          implicitWidth: 350
          font.pixelSize: 32
          padding: 10

          horizontalAlignment: TextField.AlignHCenter
          placeholderText: qsTr("Enter password")
          background: Rectangle {
            color: "transparent"
            border.color: root.context.unlockInProgress ? "#272727" : "white"
            radius: 25
            opacity: 0.8
          }

          // focus: true
          // enabled: !root.context.unlockInProgress
          echoMode: TextInput.Password
          inputMethodHints: Qt.ImhSensitiveData

          onTextChanged: root.context.currentText = this.text;
          onAccepted: root.context.tryUnlock();
          Connections {
            target: root.context

            function onCurrentTextChanged() {
              passwordBox.text = root.context.currentText;
            }
          }
        }

        Label {
          anchors.horizontalCenter: parent.horizontalCenter
          visible: root.context.showFailure
          color: "red"
          text: "Incorrect password"
        }
      }


      // Fingerprint
      //
      ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle {
          anchors.horizontalCenter: parent.horizontalCenter
          width: fprLab.width
          height: fprLab.height / 1.5
          color: "transparent"
          property string col: root.context.fPrintFail ? "red" : "white"
          border.color: root.context.fPrintSuccess ? "limegreen" : col
          border.width: 3
          radius: 25
          Label {
            id: fprLab
            anchors.centerIn: parent
            padding: 10
            font.pixelSize: 80
            property string col: root.context.fPrintFail ? "red" : "white"
            color: root.context.fPrintSuccess ? "limegreen" : col
            text: "\uee40"
          }

          MouseArea {
            anchors.fill: parent
            onClicked: context.fPrintCheck();
          }
        }
        Label {
          visible: root.context.fPrintFail ? true : false
          anchors.horizontalCenter: parent.horizontalCenter
          color: "red"
          text: "Try again!"
        }
      }
    }
  }
}
