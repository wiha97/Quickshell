import QtQuick
import Quickshell
import Quickshell.Services.Pam

Scope {
  id: root

  signal unlocked()
  signal failed()

  property string currentText: ""
	property bool unlockInProgress: false
  property bool showFailure: false
  property bool fPrintFail: false
  property bool fPrintSuccess: false

  onCurrentTextChanged: showFailure = false;
  onFPrintFailChanged: fPrintTimer.start();
  onFPrintSuccessChanged: fPrintTimer.start();
  Timer {
    id: fPrintTimer
    interval: 500
    running: false
    repeat: false
    property int count: 3

    onTriggered: {
      if (fPrintSuccess)
        unlocked();
      else if (count <= 0) {
        fPrintCheck();
      }
      else {
        count--;
        fPrintTimer.start();
      }
    }
  }

  function tryUnlock() {
    if (currentText === "") {
      return;
    }
    root.unlockInProgress = true;
    pwdPam.start();
  }
  function fPrintCheck() {
    fPrintFail = false;
    fprPam.start();
  }

  PamContext {
    id: fprPam

    configDirectory: "pam"
    config: "password.conf"

    onPamMessage: {
      if (this.responseRequired) {
        this.respond(root.currentText);
      }
    }

    onCompleted: result => {
      if (result == PamResult.Success) {
        root.fPrintSuccess = true
        // root.unlocked();
      }
      else {
        root.currentText = "";
        root.fPrintFail = true;
      }

      root.unlockInProgress = false;
    }
  }

  PamContext {
    id: pwdPam

    configDirectory: "pam"
    config: "password.conf"

    onPamMessage: {
      if (this.responseRequired) {
        this.respond(root.currentText);
      }
    }

    onCompleted: result => {
      if (result == PamResult.Success) {
        root.unlocked();
      }
      else {
        root.currentText = "";
        root.showFailure = true;
      }

      root.unlockInProgress = false;
    }
  }
}
