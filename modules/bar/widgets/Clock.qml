import QtQuick
import Quickshell
import "root:/"

Container {
  width: dateRow.width
  Row {
  id: dateRow
  anchors.centerIn: parent
  padding: 10

  Text {
   id: timeDisp
   property string cTime: "..."


   text: cTime + " \udb82\udd54"
   color: Conf.txtColor
   font.pixelSize: Conf.fontSize

   Timer {
     interval: 1000
     running: true
     repeat: true

     onTriggered: {
       var date = new Date()
       timeDisp.cTime = Qt.formatTime(date, "HH:mm")
     }
   }
  }
 }
}
