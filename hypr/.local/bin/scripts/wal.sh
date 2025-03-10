#!/bin/bash

# wall=w$1.jpg

# wall_path=/home/amirreza/Downloads/wall/$wall
wall_path=/home/amirreza/.cache/custom/wallpaper

echo $(date) >> paper.txt

hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$wall_path"
hyprctl hyprpaper wallpaper "eDP-1,$wall_path"
hyprctl hyprpaper wallpaper "DP-1,$wall_path"
hyprctl hyprpaper wallpaper ",$wall_path"

