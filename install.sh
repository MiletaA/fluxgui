#!/bin/bash

# Set up the project directory
PROJECT_DIR=~/fluxgui

# Clone the repo if not already done
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Cloning the fluxgui repository..."
  git clone https://github.com/xflux-gui/fluxgui.git $PROJECT_DIR
fi

# Navigate to the project directory
cd $PROJECT_DIR

# Install system-wide dependencies
echo "Installing system-wide dependencies..."
sudo apt update
sudo apt install -y python3-pip python3-venv python3-gi python3-pexpect redshift

# Install Python dependencies
echo "Installing Python dependencies..."
pip3 install -r requirements.txt

# Download xflux if not already done
if [ ! -f "$PROJECT_DIR/xflux" ]; then
  echo "Downloading xflux..."
  sudo python3 download-xflux.py
fi

# Make xflux executable
echo "Making xflux executable..."
sudo chmod +x $PROJECT_DIR/xflux

# Set up icons without moving them
echo "Setting up icons..."
ICON_DIR=$PROJECT_DIR/icons

# Set up the .desktop file for application menu (user-specific)
echo "Setting up the .desktop file..."
DESKTOP_ENTRY_PATH="$HOME/.local/share/applications/fluxgui.desktop"
mkdir -p ~/.local/share/applications

if [ ! -f "$DESKTOP_ENTRY_PATH" ]; then
  cat > $DESKTOP_ENTRY_PATH <<EOL
[Desktop Entry]
Version=1.0
Name=f.lux indicator applet
Comment=Better lighting for your computer
Exec=$PROJECT_DIR/fluxgui
Icon=$ICON_DIR/hicolor/22x22/apps/fluxgui.svg
Terminal=false
Type=Application
Categories=Utility;
EOL
  chmod +x $DESKTOP_ENTRY_PATH
else
  echo ".desktop file already exists."
fi

# Final instructions
echo "Setup is complete!"
echo "You can now launch FluxGUI from your applications menu."
