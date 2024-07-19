#!/bin/bash

# wall=w$1.jpg
wall=$1

wall_path=/home/amirreza/Downloads/wall/$wall

config_path="$HOME/.cache/custom"
mkdir -p "$config_path"
config_path="$config_path/wallpaper"
# echo "$wall_path" > "$config_path"
unlink "$config_path"
ln -s "$wall_path" "$config_path"

wal --backend colorz -i "$wall_path" -n

hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$wall_path"
for monitor in $(hyprctl monitors | grep 'Monitor' | awk '{ print $2 }'); do
	echo "Setting wallpaper for: $monitor"
	hyprctl hyprpaper wallpaper "$monitor,$wall_path"
done

killall -SIGUSR2 waybar
swaync-client -rs
