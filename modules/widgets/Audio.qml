import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire

WidBase {
  width: row.width
  property bool expanded: false;
  property PwNode sink: Pipewire.defaultAudioSink
  PwObjectTracker {
    objects: Pipewire.defaultAudioSink
    onObjectsChanged: sink = Pipewire.defaultAudioSink
  }
  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered: {
      expanded = true;
      timer.stop();
    }
    onExited: timer.start();
  }
  Timer {
    id: timer
    interval: 1000
    running: false
    repeat: false

    onTriggered: expanded = false
  }
  Row {
    id: row
    padding: 10
    spacing: 10
    anchors.verticalCenter: parent.verticalCenter
    Text {
      Component.onCompleted: check();
      function check(){
        let nodes = Pipewire.nodes.values;
        for(let i = 0; i < nodes.length; i++){
          if(nodes[i].audio != null && !nodes[i].isStream) {
            // console.log("Node: " + nodes[i].nickname);
            // console.log("Vol: " + nodes[i].audio.volume);
          }
        }
        let links = Pipewire.links.values;
        for(let i = 0; i < links.length; i++){
          // console.log("src: " + links[i].source.name);
          // if(nodes[i].audio != null)
          // console.log("trgt: " + links[i].target.name);
        }
        let objs = PwObjectTracker.objects.values;
        console.log(objs.length);
        for(let i = 0; i < objs.length; i++){
          // console.log("pw: " + objs[i].name);
          // if(nodes[i].audio != null)
          // console.log("trgt: " + links[i].target.name);
        }
      }
      // text: Pipewire.defaultAudioSink.nickname
      text: ""
      color: txtColor
    }

    Slider {
      hoverEnabled: false
      visible: expanded
      to: 1
      from: 0
      value: sink.audio.volume
      onValueChanged: sink.audio.volume = value;
      // text: "ello"
      // color: txtColor
    }

    Text {
      visible: expanded
      function fixed(){
        let vol = sink.audio.volume * 100;
        return vol.toFixed();
      }
      text: fixed();
      color: txtColor
      font.pixelSize: fontSize / 2
      anchors.verticalCenter: parent.verticalCenter
    }
  }
}
