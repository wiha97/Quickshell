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

  onCurrentTextChanged: showFailure = false;

  function tryUnlock() {
    if (currentText === "") {
      return;
    }
    root.unlockInProgress = true;
    pwdPam.start();
  }
  function fPrintCheck() {
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
        root.unlocked();
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
