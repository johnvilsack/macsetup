#!/bin/bash

echo "Trying to Remove Icons..."
defaults write com.apple.dock persistent-apps -array
killall Dock

defaults write com.apple.dock persistent-apps -array-add '
<dict>
  <key>tile-data</key>
  <dict>
    <key>bundle-identifier</key>
    <string>com.apple.Safari</string>
    <key>file-label</key>
    <string>Safari</string>
    <key>file-data</key>
    <dict>
      <key>_CFURLString</key>
      <string>file:///Applications/Safari.app/</string>
      <key>_CFURLStringType</key>
      <integer>15</integer>
    </dict>
  </dict>
  <key>tile-type</key>
  <string>file-tile</string>
</dict>'

killall Dock
echo "Safari added"

