#!/bin/bash

# @raycast.title Pronounce (Google)
# @raycast.author Gustavo Santana
# @raycast.authorURL https://github.com/gumadeiras
# @raycast.description Pronounce a word
# @raycast.schemaVersion 1

# @raycast.icon 📣
# @raycast.mode silent
# @raycast.packageName Utils
# @raycast.argument1 { "type": "text", "placeholder": "word" }

cd $TMPDIR
curl -o $1.mp3 "https://ssl.gstatic.com/dictionary/static/sounds/oxford/$1--_us_1.mp3"
afplay $1.mp3
rm $1.mp3