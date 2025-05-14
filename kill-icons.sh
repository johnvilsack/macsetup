#!/bin/bash

echo "Removing all icons from the Dock..."
defaults delete com.apple.dock persistent-apps
defaults write com.apple.dock persistent-apps -array

# Function to add app to dock with proper format
add_app_to_dock() {
    local app_path="$1"
    local app_name=$(basename "$app_path" .app)
    
    echo "Adding $app_name to the Dock..."
    defaults write com.apple.dock persistent-apps -array-add "<dict>
        <key>tile-data</key>
        <dict>
            <key>file-data</key>
            <dict>
                <key>_CFURLString</key>
                <string>$app_path</string>
                <key>_CFURLStringType</key>
                <integer>0</integer>
            </dict>
            <key>file-label</key>
            <string>$app_name</string>
        </dict>
        <key>tile-type</key>
        <string>file-tile</string>
    </dict>"
}

# Safari - Find the actual path
if [ -d "/Applications/Safari.app" ]; then
    add_app_to_dock "/Applications/Safari.app"
elif [ -d "/System/Applications/Safari.app" ]; then
    add_app_to_dock "/System/Applications/Safari.app"
elif [ -d "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app" ]; then
    add_app_to_dock "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
else
    echo "Safari not found at expected locations"
fi

# App Store - Find the actual path
if [ -d "/System/Applications/App Store.app" ]; then
    add_app_to_dock "/System/Applications/App Store.app"
elif [ -d "/Applications/App Store.app" ]; then
    add_app_to_dock "/Applications/App Store.app"
else
    echo "App Store not found at expected locations"
fi

# System Settings/Preferences - Find the actual path
if [ -d "/System/Applications/System Settings.app" ]; then
    add_app_to_dock "/System/Applications/System Settings.app"
elif [ -d "/System/Applications/System Preferences.app" ]; then
    add_app_to_dock "/System/Applications/System Preferences.app"
else
    echo "System Settings/Preferences not found at expected locations"
fi

echo "Restarting the Dock to apply changes..."
killall Dock

echo "Done! Your Dock has been reset with the requested applications."