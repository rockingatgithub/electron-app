const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('electron', {
  runInstallScript: () => ipcRenderer.invoke('run-install-script')
});
