#!/usr/bin/env bash

options=" Lock\n󰗽 Logout\n Reboot\n⏻ Shutdown"

selection=$(echo -e "$options" | wofi --dmenu -i -p "Power Menu" -M "fuzzy")

case $selection in
	" Lock")
		hyprlock
		;;
	"󰗽 Logout")
		hyprctl dispatch exit
		;;
	" Reboot")
		systemctl reboot
		;;
	"⏻ Shutdown")
		systemctl poweroff
		;;
esac

