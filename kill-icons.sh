#!/usr/bin/env bash

# 1) Clear all icons
defaults write com.apple.dock persistent-apps -array

# 2) Add Safari
defaults write com.apple.dock persistent-apps -array-add \
'{"tile-data"={"file-data"={"_CFURLString"="file:///System/Applications/Safari.app";"_CFURLStringType"=15;};};"tile-type"="file-tile";}'

# 3) Add App Store
defaults write com.apple.dock persistent-apps -array-add \
'{"tile-data"={"file-data"={"_CFURLString"="file:///System/Applications/App%20Store.app";"_CFURLStringType"=15;};};"tile-type"="file-tile";}'

# 4) Add System Settings
defaults write com.apple.dock persistent-apps -array-add \
'{"tile-data"={"file-data"={"_CFURLString"="file:///System/Applications/System%20Settings.app";"_CFURLStringType"=15;};};"tile-type"="file-tile";}'

# 5) Restart Dock
killall Dock

echo "Dock reset to: Safari, App Store, System Settings."
