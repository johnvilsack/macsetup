#!/bin/bash

# Allowed apps – keep these in the Dock
ALLOWED_APPS=(
  "Safari.app"
  "App Store.app"
  "System Settings.app"
)

# Get the current dock apps
CURRENT_APPS=$(defaults read com.apple.dock persistent-apps | grep _CFURLString\" | awk -F 'file://' '{print $2}' | sed 's/\";//' | xargs -I {} basename "{}")

# Iterate and remove anything not in allowed list
for APP in $CURRENT_APPS; do
  if [[ ! " ${ALLOWED_APPS[*]} " =~ " $APP " ]]; then
    osascript -e "tell application \"Dock\" to set persistent apps to {}"
    break
  fi
done

# Re-add allowed apps
defaults write com.apple.dock persistent-apps -array
for APP in "${ALLOWED_APPS[@]}"; do
  APP_PATH="/Applications/$APP"
  if [ -e "$APP_PATH" ]; then
    defaults write com.apple.dock persistent-apps -array-add "<dict>
      <key>tile-data</key>
      <dict>
        <key>file-data</key>
        <dict>
          <key>_CFURLString</key>
          <string>file://$APP_PATH/</string>
          <key>_CFURLStringType</key>
          <integer>15</integer>
        </dict>
      </dict>
      <key>tile-type</key>
      <string>file-tile</string>
    </dict>"
  fi
done

# Restart Dock to apply changes
killall Dock

