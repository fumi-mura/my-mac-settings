#!/bin/sh

echo "Start setup and reboot script."

# Appearance
echo "Setup Appearance"

## Set to dark mode.
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

## Set sidebar icon size to small.
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Control center
echo "Setup Control Center"

## Battery percentage visible.
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

## Display wifi icon in menu bar.
defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool true

## Display bluetooth icon in menu bar.
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true

# Desktop
echo "Setup Desktop"

## Turn off "Automatically rearrange operating space based on latest usage" setting.
defaults write com.apple.dock mru-spaces -bool false

# Dock
echo "Setup Dock"

## Enable expansion.
defaults write com.apple.dock magnification -bool true

## Default and expansion size.
defaults write com.apple.dock tilesize -int 40
defaults write com.apple.dock largesize -int 70

## Display or not.
defaults write com.apple.dock autohide -bool true

## Show recently used apps.
defaults write com.apple.dock show-recents -bool false

## Speed of displaying dock.
defaults write com.apple.dock autohide-delay -float 0


## Speed of hiding dock.
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Rock screen
echo "Setup Rock Screen"

## Set display sleep time on battery use.
sudo pmset -b displaysleep 10

# Keyboard
echo "Setup Keyboard"

## Repeat speed.
defaults write -g KeyRepeat -int 2

## Time to repeat input recognition.
defaults write -g InitialKeyRepeat -int 15

## Turn off automatic spelling conversion while typing English.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

## Turn off automatic capitalization of sentence beginnings.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Trackpad
echo "Setup Trackpad"

## Tap to allow clicks.
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1

## Change cursor movement speed.
defaults write -g com.apple.trackpad.scaling -float 3

# Finder
echo "Setup Finder"

## Show all file extensions.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

## Default Finder view is column.
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

## Show Library folder.
chflags nohidden ~/Library

## Show Path bar.
defaults write com.apple.finder ShowPathbar -bool true

## Show Quit button(Deletion is only possible from GUI).
defaults write com.apple.Finder QuitMenuItem -bool true

# Screenshot
echo "Setup Screenshot"

## Make screenshots directly.
SCREENSHOT_DIR=$HOME/ScreenShot
mkdir -p $SCREENSHOT_DIR

## Set screenshot save location.
defaults write com.apple.screencapture location $SCREENSHOT_DIR

# Reboot
echo "Setup Reboot"

## Restart affected processes.
killall Dock
killall Finder
killall SystemUIServer

# Reboot is required for this settings to reflect.
read -p "Some changes require a reboot to reflect. Would you like to reboot now? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo reboot
else
  echo "Reboot has been canceled. Please perform it manually later."
fi
