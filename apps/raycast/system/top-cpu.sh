#!/bin/bash

# @raycast.title Top CPU
# @raycast.author Gustavo Santana
# @raycast.authorURL https://github.com/gumadeiras
# @raycast.description Report process with largest system CPU usage.

# @raycast.icon 📈
# @raycast.mode inline
# @raycast.packageName System
# @raycast.refreshTime 3m
# @raycast.schemaVersion 1

set -euo pipefail

output=$(
	top -l 2 -n 1 -o cpu -stats pid,cpu |
	awk '
		/^PID[[:space:]]+%CPU([[:space:]]+|$)/ { capture = 1; next }
		capture && $1 ~ /^[0-9]+$/ { pid = $1; cpu = $2 }
		END {
			if (pid != "" && cpu != "") {
				print pid "\t" cpu
			}
		}
	'
)

if [[ -z "$output" ]]; then
	echo "CPU data unavailable"
	exit 1
fi

pid=${output%%$'\t'*}
percentage=${output#*$'\t'}

if [[ "$pid" == "0" ]]; then
	cmd="kernel_task"
else
	cmd=$(ps -p "$pid" -co comm= | awk '{$1=$1};1')
fi

if [[ -z "$cmd" ]]; then
	echo "CPU data unavailable"
	exit 1
fi

echo "${cmd} - ${percentage}%"
