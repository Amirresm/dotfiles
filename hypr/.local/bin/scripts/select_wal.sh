#! /usr/bin/env bash

WAL_DIR="$HOME/Downloads/wall"

WALS=$(ls "$WAL_DIR")

SELECTION=$(echo "$WALS" | sed "s/ /\n/g" | wofi --dmenu -M "fuzzy")

"$HOME/.local/bin/scripts/wal2.sh" "$SELECTION"
