#!/bin/bash

DOCK_PLIST="$HOME/Library/Preferences/com.apple.dock.plist"

/usr/libexec/PlistBuddy -c "Clear persistent-apps" "$DOCK_PLIST"

# App list with full paths
APPS=(
  "/Applications/Safari.app"
  "/System/Applications/App Store.app"
  "/System/Applications/System Settings.app"
)

INDEX=0
for APP_PATH in "${APPS[@]}"; do
  /usr/libexec/PlistBuddy -c "Add persistent-apps:$INDEX dict" "$DOCK_PLIST"
  /usr/libexec/PlistBuddy -c "Add persistent-apps:$INDEX:tile-data dict" "$DOCK_PLIST"
  /usr/libexec/PlistBuddy -c "Add persistent-apps:$INDEX:tile-data:file-data dict" "$DOCK_PLIST"
  /usr/libexec/PlistBuddy -c "Add persistent-apps:$INDEX:tile-data:file-data:_CFURLString string file://${APP_PATH}" "$DOCK_PLIST"
  /usr/libexec/PlistBuddy -c "Add persistent-apps:$INDEX:tile-data:file-data:_CFURLStringType integer 15" "$DOCK_PLIST"
  /usr/libexec/PlistBuddy -c "Add persistent-apps:$INDEX:tile-type string file-tile" "$DOCK_PLIST"
  INDEX=$((INDEX + 1))
done

killall Dock
