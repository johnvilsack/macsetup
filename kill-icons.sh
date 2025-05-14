#!/bin/bash

echo "Trying to Remove Icons..."
defaults write com.apple.dock persistent-apps -array
killall Dock

osascript <<EOF
tell application "System Events" to tell dock preferences to set properties to {autohide:false}
tell application "Finder" to open POSIX file "/Applications/Safari.app"
delay 1
tell application "System Events"
    tell process "Finder"
        set frontmost to true
        set safariApp to POSIX file "/Applications/Safari.app" as alias
        set dockItem to safariApp
        click menu item "Keep in Dock" of menu 1 of menu bar item "File" of menu bar 1
    end tell
end tell
EOF

killall Dock
echo "Safari added"

