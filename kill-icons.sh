#!/bin/bash

# Get the current dock preferences
dock_settings=$(defaults read com.apple.dock persistent-apps)

# Function to extract the bundle identifier from a dock item
get_bundle_id() {
  local item="$1"
  echo "$item" | grep -oP '"file-data" = \{[^}]*\};' | grep -oP '"bundle-identifier" = "[^"]*"' | cut -d '"' -f 4
}

# Function to remove an app from the dock settings
remove_dock_item() {
  local bundle_id_to_remove="$1"
  local new_dock_items=""
  local found=0

  while IFS= read -r line; do
    if [[ "$line" == *"{"* ]]; then
      current_item="$line"
      while IFS= read -r next_line; do
        current_item="$current_item"$'\n'"$next_line"
        if [[ "$next_line" == *"}"* ]]; then
          item_bundle_id=$(get_bundle_id "$current_item")
          if [[ "$item_bundle_id" != "$bundle_id_to_remove" ]]; then
            if [[ -n "$new_dock_items" ]]; then
              new_dock_items="$new_dock_items,"
            fi
            new_dock_items="$new_dock_items"$'\n'"$current_item"
          else
            found=1
          fi
          break
        fi
      done
    fi
  done <<< "$dock_settings"

  if [[ "$found" -gt 0 ]]; then
    defaults write com.apple.dock persistent-apps "<array>$new_dock_items</array>"
  fi
}

# --- Main Script ---

echo "Removing all icons from the dock..."

# Get all current app bundle identifiers in the dock
all_dock_bundle_ids=$(echo "$dock_settings" |
                        grep -oP '"file-data" = \{[^}]*\};' |
                        grep -oP '"bundle-identifier" = "[^"]*"' |
                        cut -d '"' -f 4)

# Remove each one
while IFS= read -r bundle_id; do
  remove_dock_item "$bundle_id"
done <<< "$all_dock_bundle_ids"

echo "Adding Safari, App Store, and System Settings to the dock..."

# Function to add an app to the dock
add_dock_app() {
  local app_path="$1"
  osascript -e "tell application \"System Events\" to tell application \"Dock\" to create dock tile at end with properties {file path:\"$app_path\"}"
}

# Add the desired applications
add_dock_app "/Applications/Safari.app"
add_dock_app "/Applications/App Store.app"
add_dock_app "/System/Applications/System Settings.app"

# Kill the Dock to apply changes
killall Dock

echo "Dock configuration complete."