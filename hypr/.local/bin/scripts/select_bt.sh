#!/usr/bin/env bash

devices=$(bluetoothctl devices)

selection=$(echo -e "$devices" | wofi --dmenu -i -p "Bluetooth" -M "fuzzy")

mac=$(echo "$selection" | cut -d ' ' -f 2)

echo "Selection is ${mac}"
bluetoothctl connect "$mac" & disown
