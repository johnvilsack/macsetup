#!/bin/bash

echo "Removing Icons..."
defaults write com.apple.dock persistent-apps -array
killall Dock

defaults write com.apple.dock persistent-apps -array-add \
'<dict>
  <key>tile-data</key>
  <dict>
    <key>file-data</key>
    <dict>
      <key>_CFURLString</key>
      <string>/Applications/Safari.app</string>
      <key>_CFURLStringType</key>
      <integer>0</integer>
    </dict>
  </dict>
  <key>tile-type</key>
  <string>file-tile</string>
</dict>'

killall Dock
echo "Safari added"

