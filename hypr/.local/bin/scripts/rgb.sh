#!/usr/bin/env bash


hostname=$(uname -n)
if [[ $hostname == "Voyager" ]]; then
	# openrgb --server -p from_pywal
	openrgb --server &
	sleep 3 && python3 ~/.local/bin/scripts/set_rgb.py > ~/tmp.txt
fi
