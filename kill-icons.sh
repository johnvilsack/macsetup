#!/bin/bash

echo "Removing all icons from the Dock..."
defaults delete com.apple.dock persistent-apps
defaults write com.apple.dock persistent-apps -array


defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Stocks.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

killall Dock