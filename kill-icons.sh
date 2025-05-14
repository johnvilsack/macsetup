#!/bin/bash

echo "Removing all icons from the Dock..."
defaults delete com.apple.dock persistent-apps
defaults write com.apple.dock persistent-apps -array

echo "Adding Safari to the Dock..."
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Safari.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

echo "Adding App Store to the Dock..."
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/App Store.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

echo "Adding System Settings to the Dock..."
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/System Settings.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

echo "Restarting the Dock to apply changes..."
killall Dock

echo "Done! Your Dock now has only Safari, App Store, and System Settings."
