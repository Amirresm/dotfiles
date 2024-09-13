#!/usr/bin/env bash

options=" Lock\n󰗽 Logout\n Reboot\n⏻ Shutdown"

selection=$(echo -e "$options" | wofi --dmenu -i -p "Power Menu" -M "fuzzy")

case $selection in
	" Lock")
		hyprlock
		;;
	"󰗽 Logout")
		uwsm stop
		# hyprctl dispatch exit
		;;
	" Reboot")
		reboot
		;;
	"⏻ Shutdown")
		shutdown now
		;;
esac

