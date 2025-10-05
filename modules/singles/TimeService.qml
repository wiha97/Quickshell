pragma Singleton
import QtQuick
import Quickshell

Singleton {
  id: root

  property string time: Qt.formatDateTime(new Date(), "HH:mm")
  property string secTime
  property string date: Qt.formatDateTime(new Date(), "dd MMMM 󰸗")

  Timer {
    running: true
    repeat: true
    interval: 1000
    onTriggered: {
      var date = new Date();
      root.time = Qt.formatTime(date, "HH:mm")
      root.secTime = Qt.formatTime(date, "HH:mm:ss")
      root.date = Qt.formatDate(date, "d MMMM")
    }
  }
}
