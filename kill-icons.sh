#!/bin/bash

# Remove all persistent apps from the Dock
defaults write com.apple.dock persistent-apps -array

# Kill the Dock to apply changes
killall Dock

echo "Dock configuration complete."