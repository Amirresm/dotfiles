#!/usr/bin/env bash


hostname=$(uname -n)
if [[ $hostname == "voyager" ]]; then
	# openrgb --server -p from_pywal
	openrgb --server --noautoconnect &
	python3 ~/.local/bin/scripts/set_rgb.py
	sleep 5 && python3 ~/.local/bin/scripts/set_rgb.py
	sleep 5 && python3 ~/.local/bin/scripts/set_rgb.py
fi
