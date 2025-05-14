#!/bin/bash

echo "Removing all icons from the Dock..."
defaults write com.apple.dock persistent-apps -array

# Check for System Settings vs System Preferences based on macOS version
if [ -d "/System/Applications/System Settings.app" ]; then
  SYSTEM_PREFS="/System/Applications/System Settings.app"
  SYSTEM_PREFS_NAME="System Settings"
else
  SYSTEM_PREFS="/System/Applications/System Preferences.app"
  SYSTEM_PREFS_NAME="System Preferences"
fi

# Check for App Store location
if [ -d "/System/Applications/App Store.app" ]; then
  APP_STORE="/System/Applications/App Store.app"
else
  APP_STORE="/Applications/App Store.app"
fi

echo "Adding Safari to the Dock..."
dockutil --add "/Applications/Safari.app" --no-restart || {
  echo "dockutil not found, using defaults command instead"
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Safari.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict><key>tile-type</key><string>file-tile</string></dict>"
}

echo "Adding App Store to the Dock..."
dockutil --add "$APP_STORE" --no-restart || {
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$APP_STORE</string><key>_CFURLStringType</key><integer>0</integer></dict></dict><key>tile-type</key><string>file-tile</string></dict>"
}

echo "Adding $SYSTEM_PREFS_NAME to the Dock..."
dockutil --add "$SYSTEM_PREFS" --no-restart || {
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$SYSTEM_PREFS</string><key>_CFURLStringType</key><integer>0</integer></dict></dict><key>tile-type</key><string>file-tile</string></dict>"
}

echo "Restarting the Dock to apply changes..."
killall Dock

echo "Done! Your Dock now has only Safari, App Store, and $SYSTEM_PREFS_NAME."