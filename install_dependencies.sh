#!/bin/bash

# Define the installation directory
INSTALL_DIR="$HOME/my_electron_app_bundle"
mkdir -p "$INSTALL_DIR"

# Define the PATH to include the binaries
export PATH="$INSTALL_DIR/bin:$INSTALL_DIR/node/bin:$INSTALL_DIR/jdk/bin:$INSTALL_DIR/adb:$PATH"

# Create directories for each installation
mkdir -p "$INSTALL_DIR/bin"
mkdir -p "$INSTALL_DIR/node"
mkdir -p "$INSTALL_DIR/appium"
mkdir -p "$INSTALL_DIR/ffmpeg"
mkdir -p "$INSTALL_DIR/jdk"
mkdir -p "$INSTALL_DIR/adb"

# Install adb
echo "Installing adb..."
brew install --prefix="$INSTALL_DIR" adb

# Install Node.js
echo "Installing Node.js..."
brew install --prefix="$INSTALL_DIR" node

# Install Appium
echo "Installing Appium..."
npm install -g appium --prefix "$INSTALL_DIR"

# Install Appium UI Automator 2 driver
echo "Installing Appium UI Automator 2 driver..."
npm install -g appium-uiautomator2-driver --prefix "$INSTALL_DIR"

# Install FFmpeg
echo "Installing FFmpeg..."
brew install --prefix="$INSTALL_DIR" ffmpeg

# Install JDK
echo "Installing JDK..."
brew install --prefix="$INSTALL_DIR" openjdk

# Export PATH for the Electron app
echo "Exporting PATH for the Electron app..."
echo "export PATH=\"$INSTALL_DIR/bin:$INSTALL_DIR/node/bin:$INSTALL_DIR/jdk/bin:$INSTALL_DIR/adb:\$PATH\"" >> ~/.bash_profile

# Source the updated .bash_profile to apply changes
source ~/.bash_profile

echo "Installation completed successfully."
