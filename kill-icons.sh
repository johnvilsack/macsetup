#!/usr/bin/env bash

# 1) Clear all persistent apps from the Dock
defaults write com.apple.dock persistent-apps -array

# 2) Add Safari
defaults write com.apple.dock persistent-apps -array-add \
'<dict>
   <key>tile-data</key>
   <dict>
     <key>file-data</key>
     <dict>
       <key>_CFURLString</key>
       <string>file:///System/Applications/Safari.app</string>
       <key>_CFURLStringType</key>
       <integer>0</integer>
     </dict>
   </dict>
   <key>tile-type</key>
   <string>file-tile</string>
 </dict>'

# 3) Add App Store
defaults write com.apple.dock persistent-apps -array-add \
'<dict>
   <key>tile-data</key>
   <dict>
     <key>file-data</key>
     <dict>
       <key>_CFURLString</key>
       <string>file:///System/Applications/App Store.app</string>
       <key>_CFURLStringType</key>
       <integer>0</integer>
     </dict>
   </dict>
   <key>tile-type</key>
   <string>file-tile</string>
 </dict>'

# 4) Add System Settings
defaults write com.apple.dock persistent-apps -array-add \
'<dict>
   <key>tile-data</key>
   <dict>
     <key>file-data</key>
     <dict>
       <key>_CFURLString</key>
       <string>file:///System/Applications/System Settings.app</string>
       <key>_CFURLStringType</key>
       <integer>0</integer>
     </dict>
   </dict>
   <key>tile-type</key>
   <string>file-tile</string>
 </dict>'

# 5) Restart the Dock to apply changes
killall Dock

echo "Dock was reset to: Safari, App Store, System Settings."
