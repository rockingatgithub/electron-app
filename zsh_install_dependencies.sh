#!/bin/zsh

# Set the installation directory
INSTALL_DIR="$PWD/bundle"

# Check if brew is installed
if ! command -v brew &> /dev/null
then
    echo "Homebrew could not be found. Installing now..."
    /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# repair brew if it has any issues
brew tap --repair

# Install adb
echo "Installing adb..."
brew install --cask android-platform-tools

# Install Node.js
echo "Installing Node.js..."
brew install node

# Configure npm to use a global directory
npm config set prefix '~/.npm-global'
echo "export PATH=~/.npm-global/bin:\$PATH" >> ~/.zshrc

# Install Appium
echo "Installing Appium..."
npm install -g appium

# Install Appium UI Automator 2 driver
echo "Installing Appium UI Automator 2 driver..."
appium driver install uiautomator2

# Install FFmpeg
echo "Installing FFmpeg..."
brew install ffmpeg

# Install JDK
echo "Installing JDK..."
brew install openjdk

# Get the path to the installed JDK
JDK_PATH="$(brew --prefix openjdk)/bin/java"

# Create symlinks for the binaries
ln -sf "$(which adb)" "$INSTALL_DIR/adb/bin"
ln -sf "$(which node)" "$INSTALL_DIR/node/bin"
ln -sf "$(which appium)" "$INSTALL_DIR/appium/bin"
ln -sf "$(which ffmpeg)" "$INSTALL_DIR/ffmpeg/bin"

# Create a symlink for the Java binary
ln -sf "$JDK_PATH" "$INSTALL_DIR/java/bin"

# Export PATH for the Electron app
echo "Exporting PATH for the Electron app..."
echo "export PATH=\"$INSTALL_DIR/adb/bin:$INSTALL_DIR/node/bin:$INSTALL_DIR/ffmpeg/bin:$INSTALL_DIR/java/bin:\$PATH\"" >> ~/.zshrc

# Source the updated .zshrc to apply changes
source ~/.zshrc

echo "Installation completed successfully."