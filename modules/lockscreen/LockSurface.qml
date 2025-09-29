import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects
import qs
import qs.modules.widgets
import qs.modules.singles

Rectangle {
  id: root

  required property LockContext context
  property string hasFprint: ""


  Process {
    running: true
    command: ["lsusb", "|", "grep", "-i", "fingerprint"]
    stdout: StdioCollector {
      onStreamFinished: {
        hasFprint = this.text
        // console.log(hasFprint)
      }
    }
  }

  color: "#05272727"

  // Ugly "solution" for non-awkward fingerprint unlock
  //
  // Component.onCompleted: context.fPrintCheck();

  //  TODO: Dynamically pick WP at random from ~/Pictures/wallpapers
  Image {
    id: img
    source: WPService.lockscreen
    // source: WPService.walls[10]
    // source: Conf.wpPath + "/"+WPService.walls[2]
    // source: Conf.wpPath + "/archblue.png"
    anchors.fill: parent
    fillMode: Image.PreserveAspectCrop
    // Timer {
    //   running: true
    //   interval: 5000
    //   repeat: true
    //   onTriggered: {
    //     img.source = WPService.walls[Math.floor(Math.floor(Math.random(0, WPService.walls.length -1)*10))]
    //   }
    // }
  }
  // FastBlur{
  //   source: img
  //   radius: 10
  //   anchors.fill: parent
  // }

  Timer {
    running: true

  }

  MouseArea {
    anchors.fill: parent
    onClicked: context.fPrintCheck();
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
        txtColor: "white"
        mainBColor: "white"
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
            // color: "transparent"
            color: "#272727"
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
        visible: hasFprint.length > 0 ? true : false
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
