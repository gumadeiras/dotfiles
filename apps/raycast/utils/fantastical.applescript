#!/usr/bin/osascript

# @raycast.title Create event in Fantastical
# @raycast.author Gustavo Santana
# @raycast.authorURL https://github.com/gumadeiras
# @raycast.description Create event in Fantastical
# @raycast.schemaVersion 1

# @raycast.icon ./images/fantastical.png
# @raycast.mode silent
# @raycast.packageName Utils
# @raycast.argument1 { "type": "text", "placeholder": "event..." }

on run argv 
  tell application "Fantastical"
    parse sentence of (item 1 of argv)
  end tell
end run