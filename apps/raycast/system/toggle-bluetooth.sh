#!/bin/bash

# @raycast.title Toggle Bluetooth
# @raycast.author Gustavo Santana
# @raycast.authorURL https://github.com/gumadeiras
# @raycast.description Toggle your Bluetooth connection.

# @raycast.icon images/bluetooth.png
# @raycast.mode silent
# @raycast.packageName System
# @raycast.schemaVersion 1

/Users/gumadeiras/git/dotfiles/apps/raycast/system/blueutil/blueutil -p toggle

if [[ $(/Users/gumadeiras/git/dotfiles/apps/raycast/system/blueutil/blueutil -p) -eq 1 ]]
then
    echo "Bluetooth turned on"
else
    echo "Bluetooth turned off"
fi