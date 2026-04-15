#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disk Usage
# @raycast.mode inline
# @raycast.refreshTime 1m

# Optional parameters:
# @raycast.icon 💿
# @raycast.packageName System

# Documentation:
# @raycast.description Show disk usage for / (root)
# @raycast.author Jesse Claven
# @raycast.authorURL https://github.com/jesse-c

# Example:
#
# Filesystem       Size   Used  Avail Capacity iused      ifree %iused  Mounted on
# /dev/disk1s6s1  113Gi   15Gi  3.4Gi    82%  563983 1182278497    0%   /

set -euo pipefail

humanize_bytes() {
	awk -v bytes="$1" '
		BEGIN {
			split("B KiB MiB GiB TiB PiB", units, " ")
			i = 1
			value = bytes + 0

			while (value >= 1024 && i < 6) {
				value /= 1024
				i++
			}

			if (i == 1) {
				printf "%.0f%s", value, units[i]
			} else {
				printf "%.1f%s", value, units[i]
			}
		}
	'
}

if disk_info=$(diskutil info -plist / 2>/dev/null); then
	free_bytes=$(printf '%s' "$disk_info" | plutil -extract APFSContainerFree raw - 2>/dev/null || true)
	total_bytes=$(printf '%s' "$disk_info" | plutil -extract APFSContainerSize raw - 2>/dev/null || true)

	if [[ -n "${free_bytes:-}" && -n "${total_bytes:-}" ]]; then
		free_human=$(humanize_bytes "$free_bytes")
		total_human=$(humanize_bytes "$total_bytes")
		echo "APFS: ${free_human} free of ${total_human}"
		exit 0
	fi
fi

df -h / | awk 'FNR == 2 {printf "Root: %s available of %s", $4, $2}'
