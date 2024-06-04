const { exec } = require('child_process');
const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('path');
const sudo = require('sudo-prompt');

function createWindow() {
  const mainWindow = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
      contextIsolation: true,
      enableRemoteModule: false,
      nodeIntegration: false
    }
  });

  mainWindow.loadFile('index.html');
}

app.whenReady().then(() => {
  createWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});

// Handle running the install script
ipcMain.handle('run-install-script', async () => {
  return new Promise((resolve, reject) => {
    const options = {
      name: 'Electron App',
    };

    // Change the permissions of the script
    sudo.exec('chmod +x ./install_dependencies.sh', options, (error, stdout, stderr) => {
      if (error) {
        reject(`Error: ${error.message}`);
      } else if (stderr) {
        reject(`Stderr: ${stderr}`);
      } else {

        sudo.exec('chown -R admin /opt/homebrew/var/homebrew', options, (error, stdout, stderr) => {
          if (error) {
            reject(`Error: ${error.message}`);
          } else if (stderr) {
            reject(`Stderr: ${stderr}`);
          } else {
            // Execute the script
            sudo.exec('sh ./install_dependencies.sh', options, (error, stdout, stderr) => {
              if (error) {
                reject(`Error: ${error.message}`);
              } else if (stderr) {
                reject(`Stderr: ${stderr}`);
              } else {
                resolve(`Stdout: ${stdout}`);
              }
            });
          }
        })
      }
    });
  });
});
