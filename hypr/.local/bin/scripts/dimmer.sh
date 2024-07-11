#! /usr/bin/env bash

state=$(cat /sys/class/power_supply/BAT0/status)

if [ "$state" == "Discharging" ]; then
	brightnessctl -s set 15
fi
