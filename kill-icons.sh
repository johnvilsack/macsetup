#!/bin/bash

echo "Remove Dock Icons..."
defaults write com.apple.dock persistent-apps -array
killall Dock

