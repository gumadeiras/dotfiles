#!/bin/bash

# @raycast.title Top RAM
# @raycast.author Gustavo Santana
# @raycast.authorURL https://github.com/gumadeiras
# @raycast.description Show process with largest RAM usage.

# @raycast.icon 📈
# @raycast.mode inline
# @raycast.packageName System
# @raycast.refreshTime 3m
# @raycast.schemaVersion 1

set -euo pipefail

output=$(
	top -l 1 -n 1 -o mem -stats pid,mem |
	awk '
		/^PID[[:space:]]+MEM([[:space:]]+|$)/ {
			getline
			if ($1 ~ /^[0-9]+$/ && $2 != "") {
				print $1 "\t" $2
			}
			exit
		}
	'
)

if [[ -z "$output" ]]; then
	echo "Memory data unavailable"
	exit 1
fi

pid=${output%%$'\t'*}
memory=${output#*$'\t'}

if [[ "$pid" == "0" ]]; then
	cmd="kernel_task"
else
	cmd=$(ps -p "$pid" -co comm= | awk '{$1=$1};1')
fi

if [[ -z "$cmd" ]]; then
	echo "Memory data unavailable"
	exit 1
fi

echo "${cmd} - ${memory}"
