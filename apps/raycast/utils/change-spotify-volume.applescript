#!/usr/bin/osascript

# @raycast.title Change Spotify Volume
# @raycast.author Gustavo Santana
# @raycast.authorURL https://github.com/gumadeiras
# @raycast.description Set the volume in Spotify
# @raycast.schemaVersion 1

# @raycast.icon 🎵
# @raycast.mode silent
# @raycast.packageName Utils
# @raycast.argument1 { "type": "text", "placeholder": "volume (0-100)" }

on run argv
	tell application "Spotify"
		set sound volume to (item 1 of argv as integer)
	end tell
end run
