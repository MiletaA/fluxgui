#!/bin/bash

# Define project directory
PROJECT_DIR="$HOME/fluxgui"
ICON_DIR="$PROJECT_DIR/icons/hicolor"
DESKTOP_ENTRY_PATH="$HOME/.local/share/applications/fluxgui.desktop"

# Step 1: Set up a virtual environment
echo "Setting up a virtual environment..."
python3 -m venv "$PROJECT_DIR/venv"
source "$PROJECT_DIR/venv/bin/activate"

# Step 2: Install dependencies and fluxgui package
echo "Installing Python dependencies and the fluxgui package..."
python3 -m pip install -r "$PROJECT_DIR/requirements.txt"
python3 -m pip install .

# Step 3: Download and extract xflux
echo "Downloading and extracting xflux..."
cd "$PROJECT_DIR"
wget -O xflux.tgz https://justgetflux.com/linux/xflux64.tgz
tar -xzf xflux.tgz
chmod +x xflux
rm xflux.tgz

# Step 4: Move xflux to the virtual environment's bin directory
if [ -f "$PROJECT_DIR/xflux" ]; then
  echo "Setting up xflux..."
  mv "$PROJECT_DIR/xflux" "$PROJECT_DIR/venv/bin/xflux"
fi

# Step 5: Make main.py executable (if not already)
chmod +x "$PROJECT_DIR/src/fluxgui/main.py"

# Step 6: Copy preferences.glade to the site-packages directory
echo "Copying preferences.glade to site-packages directory..."
SITE_PACKAGES_DIR="$PROJECT_DIR/venv/lib/python3.12/site-packages/fluxgui"
mkdir -p "$SITE_PACKAGES_DIR"
cp "$PROJECT_DIR/src/fluxgui/preferences.glade" "$SITE_PACKAGES_DIR/"

# Step 7: Set up application icons
echo "Setting up icons..."
for size in 16x16 22x22 24x24 32x32 48x48 64x64 96x96; do
  mkdir -p "$HOME/.local/share/icons/hicolor/$size/apps/"
  cp "$ICON_DIR/$size/apps/fluxgui.svg" "$HOME/.local/share/icons/hicolor/$size/apps/fluxgui.svg"
done
gtk-update-icon-cache "$HOME/.local/share/icons/hicolor/"

# Step 8: Create .desktop entry for application launcher with explicit icon path
echo "Creating .desktop entry for fluxgui..."
mkdir -p "$HOME/.local/share/applications"
cat > "$DESKTOP_ENTRY_PATH" <<EOL
[Desktop Entry]
Version=1.0
Name=FluxGUI
Comment=f.lux indicator applet - better lighting for your computer
Exec=$PROJECT_DIR/venv/bin/python -m fluxgui.main
Icon=$HOME/.local/share/icons/hicolor/48x48/apps/fluxgui.svg
Terminal=false
Type=Application
Categories=Utility;
EOL

# Step 9: Rebuild the icon cache and refresh
echo "Rebuilding the icon cache and refreshing desktop entries..."
gtk-update-icon-cache "$HOME/.local/share/icons/hicolor/"
update-desktop-database "$HOME/.local/share/applications"

# Step 10: Final cleanup and deactivation
echo "Installation complete. You can launch FluxGUI from your applications menu."
deactivate
