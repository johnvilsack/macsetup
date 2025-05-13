#!/bin/bash

# Temporary clean Dock plist
TMP_PLIST="/tmp/com.apple.dock.plist.$$"

# Create a clean plist file
/usr/libexec/PlistBuddy -c "Clear" "$TMP_PLIST" 2>/dev/null
/usr/libexec/PlistBuddy -c "Add persistent-apps array" "$TMP_PLIST"

function add_app {
  APP_PATH="$1"
  INDEX=$(/usr/libexec/PlistBuddy -c "Print persistent-apps" "$TMP_PLIST" 2>/dev/null | grep -c "Dict {")
  /usr/libexec/PlistBuddy -c "Add persistent-apps:$INDEX dict" "$TMP_PLIST"
  /usr/libexec/PlistBuddy -c "Add persistent-apps:$INDEX:tile-data dict" "$TMP_PLIST"
  /usr/libexec/PlistBuddy -c "Add persistent-apps:$INDEX:tile-data:file-data dict" "$TMP_PLIST"
  /usr/libexec/PlistBuddy -c "Add persistent-apps:$INDEX:tile-data:file-data:_CFURLString string file://${APP_PATH}" "$TMP_PLIST"
  /usr/libexec/PlistBuddy -c "Add persistent-apps:$INDEX:tile-data:file-data:_CFURLStringType integer 15" "$TMP_PLIST"
  /usr/libexec/PlistBuddy -c "Add persistent-apps:$INDEX:tile-type string file-tile" "$TMP_PLIST"
}

# Apps to keep
add_app "/Applications/Safari.app"
add_app "/System/Applications/App Store.app"
add_app "/System/Applications/System Settings.app"

# Replace actual plist
cp "$TMP_PLIST" "$HOME/Library/Preferences/com.apple.dock.plist"
killall Dock
rm "$TMP_PLIST"
