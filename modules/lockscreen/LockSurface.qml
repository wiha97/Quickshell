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
  property bool hasFprint



  Process {
    running: true
    command: ["lsusb"]
    stdout: StdioCollector {
      onStreamFinished: {
        root.hasFprint = this.text.toLowerCase().includes("fingerprint")
      }
    }
  }

  Component.onCompleted: console.log(hasFprint)

  color: "#05272727"

  // Ugly "solution" for non-awkward fingerprint unlock
  //
  // Component.onCompleted: context.fPrintCheck();

  //  TODO: Dynamically pick WP at random from ~/Pictures/wallpapers
  Image {
    id: img
    source: WPService.lockscreen
    anchors.fill: parent
    fillMode: Image.PreserveAspectCrop
  }
  FastBlur{
    visible: passwordBox.focus
    source: img
    radius: passwordBox.text.length * 10
    anchors.fill: parent
  }

  Timer {
    id: typeTimer
    running: false
    repeat: false
    interval: 1500
    onTriggered: {
      if(passwordBox.text.length === 0)
        root.focus = true
    }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      if(hasFprint)
        context.fPrintCheck();
      if(passwordBox.text.length === 0)
        root.focus = true
    }
  }

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

  focus: true

  Keys.onPressed: (e) => {
    passwordBox.focus = true;
    if(e.key == QT.Key_Return)
      root.context.tryUnlock();
  }


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

      // Timer {
      //   interval: 1000
      //   running: true
      //   repeat: true
      //
      //   onTriggered: clock.date = new Date();
      // }

      text: TimeService.time
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
            visible: passwordBox.focus
            // color: "transparent"
            color: "#272727"
            border.color: root.context.unlockInProgress ? "#272727" : "white"
            radius: 25
            opacity: 0.8
          }

          // focus: !hasFprint
          enabled: !root.context.unlockInProgress
          echoMode: TextInput.Password
          inputMethodHints: Qt.ImhSensitiveData

          onFocusChanged: {
            typeTimer.stop();
            typeTimer.start();
          }

          onTextChanged: {
            typeTimer.stop();
            typeTimer.start();
            root.context.currentText = this.text;
          }
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
        visible: hasFprint
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
  Item {
    anchors {
      top: parent.top
      horizontalCenter: parent.horizontalCenter
    }
    height: screen.height / 10
    Label {
      font.pixelSize: 26
      anchors.centerIn: parent
      text: HyprSplash.msg
      color: "lightblue"
    }
  }
  //  In case of bork
  //
  // Button {
  //   text: "abort!"
  //   onClicked: context.unlocked();
  // }
}
