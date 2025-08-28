pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
  id: root
  property bool showNotes: true
  property list<Notification> noties: server.trackedNotifications.values

  NotificationServer {
    id: server
    persistenceSupported: true

    onNotification: (notify) => {
      notify.tracked = true
      showNotes = true;
      timer.start();
      console.log(JSON.stringify(notify))
    }
  }

  Timer {
    id: timer
    interval: 5000
    running: true
    onTriggered: {
      showNotes = false;
    }
  }

  function startTimer(bool){
    if(bool)
      timer.start();
    else
      timer.stop();
  }
}
