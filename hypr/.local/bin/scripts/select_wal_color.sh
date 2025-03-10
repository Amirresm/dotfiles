#! /usr/bin/env bash

options=$(wal --theme | awk '$1!="-"{n=length();printf "%s\n",substr($0,0,n-1)}')
options=$(echo "$options" | sed -r -e 's/[^a-zA-Z0-9 ]//g' -e 's/[[:digit:]]{3}m(.*)[[:digit:]]{1}m/\1/g')
option=$(echo "$options" | wofi --dmenu -M "fuzzy")
echo "$option"
if [[ -z "$option" ]]; then
	exit 1
fi

themes=$(wal --theme | awk -v opt="${option}" 'BEGIN {catpat="^.*:"; pat=".*" opt ".*"; b=0}; \
{if (match($0,catpat)) {if (match($0,pat)) {b=1} else {if (b==1) {b=0}}}}; {if (!match($0,catpat) && b==1) {printf "%s\n",$2}}')
theme=$(echo "$themes" | wofi --dmenu -M "fuzzy")
if [[ -z "$theme" ]]; then
	exit 1
fi

echo "$theme"
wal --theme "$theme"

# hostname=$(uname -n)
# if [[ $hostname == "voyager" ]]; then
# 	python3 "$HOME/.local/bin/scripts/set_rgb.py"
# fi

killall -SIGUSR2 waybar
swaync-client -rs
