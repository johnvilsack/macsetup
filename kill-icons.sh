#!/bin/bash

# Reset Dock
defaults write com.apple.dock persistent-apps -array

# Function to add an app to the Dock
add_app_to_dock() {
  app_path="$1"
  if [ -e "$app_path" ]; then
    defaults write com.apple.dock persistent-apps -array-add "{
      tile-data = {
        file-data = {
          _CFURLString = \"file://$app_path\";
          _CFURLStringType = 15;
        };
      };
      tile-type = \"file-tile\";
    }"
  else
    echo "App not found: $app_path"
  fi
}

# Add desired apps (exact paths)
add_app_to_dock "/Applications/Safari.app"
add_app_to_dock "/System/Applications/App Store.app"
add_app_to_dock "/System/Applications/System Settings.app"

# Restart Dock
killall Dock
