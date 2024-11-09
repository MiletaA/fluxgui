#!/bin/bash

# Define project directory and paths
PROJECT_DIR="$HOME/fluxgui"
ICON_DIR="$PROJECT_DIR/icons/hicolor"
DESKTOP_ENTRY_PATH="$HOME/.local/share/applications/fluxgui.desktop"
ICON_CACHE_DIR="$HOME/.local/share/icons/hicolor"

# Step 1: Remove the fluxgui project directory
if [ -d "$PROJECT_DIR" ]; then
    echo "Removing project directory at $PROJECT_DIR..."
    rm -rf "$PROJECT_DIR"
else
    echo "Project directory $PROJECT_DIR does not exist. Skipping..."
fi

# Step 2: Remove icons specific to fluxgui from user's icon directory
echo "Removing fluxgui icons from $ICON_CACHE_DIR..."
for size in 16x16 22x22 24x24 32x32 48x48 64x64 96x96; do
    ICON_PATH="$ICON_CACHE_DIR/$size/apps/fluxgui.svg"
    if [ -f "$ICON_PATH" ]; then
        rm "$ICON_PATH"
        echo "Removed icon at $ICON_PATH"
    else
        echo "No icon found at $ICON_PATH. Skipping..."
    fi
done

# Step 3: Refresh the icon cache to reflect icon removal
echo "Updating icon cache..."
gtk-update-icon-cache "$ICON_CACHE_DIR"

# Step 4: Remove the .desktop entry from user's applications menu
if [ -f "$DESKTOP_ENTRY_PATH" ]; then
    echo "Removing desktop entry at $DESKTOP_ENTRY_PATH..."
    rm "$DESKTOP_ENTRY_PATH"
else
    echo "Desktop entry $DESKTOP_ENTRY_PATH does not exist. Skipping..."
fi

# Final confirmation
echo "All fluxgui-related files and configurations have been removed."

