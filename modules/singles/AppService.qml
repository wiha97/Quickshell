pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Widgets

Singleton {
  id: root
  property var entries: {
    let apps = [];
    DesktopEntries.applications.values.forEach((app)=>{
      apps.push(app);
    });
    apps.sort((a,b) => a.name.localeCompare(b.name));
    return apps;
  }
  function appSearch(filter){
    let apps = entries;
    apps = apps.filter((app) => app.name.toLowerCase().includes(filter.toLowerCase()));
    apps.sort((a,b) => a.name.localeCompare(b.name));
    return apps;
  }
}
