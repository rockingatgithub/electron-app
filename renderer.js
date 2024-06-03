document.getElementById('run-script').addEventListener('click', async () => {
    try {
      const result = await window.electron.runInstallScript();
      document.getElementById('output').innerText = result;
    } catch (error) {
      document.getElementById('output').innerText = error;
    }
  });
  