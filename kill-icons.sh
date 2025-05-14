#!/bin/bash

# Clear all persistent apps from the Dock
defaults write com.apple.dock persistent-apps -array

# Add Safari
defaults write com.apple.dock persistent-apps -array-add \
    '{"tile-data" = {"file-data" = {"_CFURLString" = "file:///System/Applications/Safari.app"; "_CFURLStringType" = 15;};}; "tile-type" = "file-tile";}'

# Add App Store
defaults write com.apple.dock persistent-apps -array-add \
    '{"tile-data" = {"file-data" = {"_CFURLString" = "file:///System/Applications/App%20Store.app"; "_CFURLStringType" = 15;};}; "tile-type" = "file-tile";}'

# Add System Settings
defaults write com.apple.dock persistent-apps -array-add \
    '{"tile-data" = {"file-data" = {"_CFURLString" = "file:///System/Applications/System%20Settings.app"; "_CFURLStringType" = 15;};}; "tile-type" = "file-tile";}'

#Current Apps
echo '###'
defaults read com.apple.dock persistent-apps | grep _CFURLString
echo '###'

# Apply changes
killall Dock



echo "Dock icons updated."
