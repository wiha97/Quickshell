import QtQuick
import QtQuick.Controls.Fusion
import Quickshell
import qs


Rectangle {
  property bool isClicked: false
  property string title: "null"
  property string view
  property QtObject loader

  function checkMatch(){
    if(loader.source.toString() === "" || !view.match(loader.source))
      return "transparent"
    console.log(loader.source.length + " " + view.length)
    return Conf.accentColor
  }
  color: checkMatch();
  Component.onCompleted: console.log(":< "+loader.source.toString())
  // color: view.match(loader.source) ? "#32cd32" : "transparent"
  // color: view.match(loader.source.toString()) ? "#32cd32" : "transparent"
  // color: "transparent"
  height: 50
  width: parent.width
  Label {
    anchors.centerIn: parent
    color: "white"
    text: title
  }
  MouseArea {
    anchors.fill: parent
    onClicked: {
      if(loader.source.toString().match(view))
        loader.source = "";
      loader.source = view;
    }
  }
}
