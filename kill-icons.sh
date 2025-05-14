
#!/bin/bash

echo "Removing all icons from the Dock..."
defaults write com.apple.dock persistent-apps -array

echo "Adding Safari to the Dock..."
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="file-tile";"tile-data"={"file-label"="Safari";"bundle-identifier"="com.apple.Safari";"file-data"={"_CFURLString"="/Applications/Safari.app";"_CFURLStringType"=0;};};}' 

echo "Adding App Store to the Dock..."
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="file-tile";"tile-data"={"file-label"="App Store";"bundle-identifier"="com.apple.AppStore";"file-data"={"_CFURLString"="/System/Applications/App Store.app";"_CFURLStringType"=0;};};}' 

echo "Adding System Settings to the Dock..."
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="file-tile";"tile-data"={"file-label"="System Settings";"bundle-identifier"="com.apple.systempreferences";"file-data"={"_CFURLString"="/System/Applications/System Settings.app";"_CFURLStringType"=0;};};}' 

echo "Restarting the Dock to apply changes..."
killall Dock

echo "Done! Your Dock now has only Safari, App Store, and System Settings."