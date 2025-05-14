#!/bin/bash

echo "Removing all icons from the Dock..."
defaults delete com.apple.dock persistent-apps
defaults write com.apple.dock persistent-apps -array

# Add Safari to the Dock
defaults write com.apple.dock persistent-apps -array-add \
'{"tile-data"={"file-data"={"_CFURLString"="file:///System/Applications/Safari.app";"_CFURLStringType"=15;};};"tile-type"="file-tile";}'

killall Dock

