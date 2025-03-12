#!/usr/bin/env bash

echo "Custom BT: Listing devices..."
devices=$(bluetoothctl devices)

echo "Custom BT: Opening selection menu..."
selection=$(echo -e "$devices" | wofi --dmenu -i -p "Bluetooth" -M "fuzzy")

if [ -z "$selection" ]; then
    echo "Custom BT: No selection made, done."
    exit 1
fi

echo "Custom BT: Obtaining mac addr..."
mac=$(echo "$selection" | cut -d ' ' -f 2)

echo "Custom BT: Selection is ${mac}"
bluetoothctl connect "$mac"

echo "Custom BT: done."
