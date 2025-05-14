#!/bin/bash

# Clear all persistent apps from the Dock
defaults write com.apple.dock persistent-apps -array

# Define list of apps to add (name and full path)
declare -A apps
apps["Safari"]="/System/Applications/Safari.app"
apps["System Settings"]="/System/Applications/System Settings.app"
apps["App Store"]="/System/Applications/App Store.app"

# Loop through and add each app to the Dock
for name in "${!apps[@]}"; do
    path="${apps[$name]}"
    uri="file://${path// /%20}"
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
