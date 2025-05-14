#!/bin/bash

# Remove all persistent apps from the Dock
defaults write com.apple.dock persistent-apps -array

# Add Safari
defaults write com.apple.dock persistent-apps -array-add \
    '{"tile-data" = {"file-data" = {"_CFURLString" = "/System/Applications/Safari.app"; "_CFURLStringType" = 0;};}; "tile-type" = "file-tile";}'

# Add App Store
defaults write com.apple.dock persistent-apps -array-add \
    '{"tile-data" = {"file-data" = {"_CFURLString" = "/System/Applications/App Store.app"; "_CFURLStringType" = 0;};}; "tile-type" = "file-tile";}'

# Add System Settings (macOS Ventura and later)
defaults write com.apple.dock persistent-apps -array-add \
    '{"tile-data" = {"file-data" = {"_CFURLString" = "/System/Applications/System Settings.app"; "_CFURLStringType" = 0;};}; "tile-type" = "file-tile";}'

# Kill the Dock to apply changes
killall Dock

echo "Dock configuration complete."