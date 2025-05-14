#!/bin/bash

DOCK_PLIST="$HOME/Library/Preferences/com.apple.dock.plist"

# Remove all persistent apps from the Dock
defaults write com.apple.dock persistent-apps -array

function add_app() {
    local APP_PATH="$1"
    /usr/libexec/PlistBuddy -c "Add persistent-apps:0 dict" "$DOCK_PLIST"
    /usr/libexec/PlistBuddy -c "Add persistent-apps:0:tile-data dict" "$DOCK_PLIST"
    /usr/libexec/PlistBuddy -c "Add persistent-apps:0:tile-data:file-data dict" "$DOCK_PLIST"
    /usr/libexec/PlistBuddy -c "Add persistent-apps:0:tile-data:file-data:_CFURLString string file://${APP_PATH}" "$DOCK_PLIST"
    /usr/libexec/PlistBuddy -c "Add persistent-apps:0:tile-data:file-data:_CFURLStringType integer 15" "$DOCK_PLIST"
    /usr/libexec/PlistBuddy -c "Add persistent-apps:0:tile-type string file-tile" "$DOCK_PLIST"
}

add_app "/System/Applications/Safari.app"
add_app "/System/Applications/App Store.app"
add_app "/System/Applications/System Settings.app"
# Kill the Dock to apply changes
killall Dock

echo "Dock configuration complete."