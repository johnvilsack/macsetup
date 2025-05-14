#!/bin/bash

# Clear all persistent apps from the Dock
defaults write com.apple.dock persistent-apps -array

# List of full app paths
apps=(
  "/System/Applications/Safari.app"
  "/System/Applications/System Settings.app"
  "/System/Applications/App Store.app"
)

# Loop and add each app
for app in "${apps[@]}"; do
  uri="file://${app// /%20}"
  defaults write com.apple.dock persistent-apps -array-add \
    "{\"tile-data\" = {\"file-data\" = {\"_CFURLString\" = \"$uri\"; \"_CFURLStringType\" = 15;};}; \"tile-type\" = \"file-tile\";}"
done

#Current Apps
echo '###'
defaults read com.apple.dock persistent-apps | grep _CFURLString
echo '###'

# Apply changes
killall Dock

echo "Dock icons updated."
