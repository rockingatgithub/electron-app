#!/bin/bash

# Set the installation directory
INSTALL_DIR="$PWD/bundle"

# Check if brew is installed
if ! command -v brew &> /dev/null
then
    echo "Homebrew could not be found. Installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# repair brew if it has any issues
brew tap --repair

# Install adb
echo "Installing adb..."
brew install adb

# Install Node.js
echo "Installing Node.js..."
brew install node

# # Configure npm to use a global directory
# npm config set prefix '~/.npm-global'
# echo "export PATH=~/.npm-global/bin:\$PATH" >> ~/.bash_profile

# Install Appium
echo "Installing Appium..."
npm install -g appium

# Install Appium UI Automator 2 driver
echo "Installing Appium UI Automator 2 driver..."
npm install -g appium-uiautomator2-driver

# Install FFmpeg
echo "Installing FFmpeg..."
brew install ffmpeg

# Install JDK
echo "Installing JDK..."
brew install openjdk

# Create symlinks for the binaries
ln -s "$(which adb)" "$INSTALL_DIR/bin"
ln -s "$(which node)" "$INSTALL_DIR/bin"
ln -s "$(which appium)" "$INSTALL_DIR/bin"
ln -s "$(which ffmpeg)" "$INSTALL_DIR/bin"
ln -s "$(which java)" "$INSTALL_DIR/bin"

# Export PATH for the Electron app
echo "Exporting PATH for the Electron app..."
echo "export PATH=\"$INSTALL_DIR/bin:\$PATH\"" >> ~/.bash_profile

# Source the updated .bash_profile to apply changes
source ~/.bash_profile

echo "Installation completed successfully."
