#!/bin/sh
set -e

echo "[exec] setting up iterm"

cp ./apps/iterm/Meslo\ LG\ M\ Regular\ for\ Powerline.ttf /Library/Fonts/

defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/dotfiles/apps/iterm/"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -int 1

# echo "[exec] link iterm profile dir"

# mkdir -p "$HOME/Library/Application Support/iTerm2/"
# rm -rf "$HOME/Library/Application Support/iTerm2/DynamicProfiles"

# ln -sfhF "$HOME/dotfiles/apps/iterm/profiles" "$HOME/Library/Application Support/iTerm2/DynamicProfiles"