#!/usr/bin/env bash

options="   Lock\n󰗽   Logout\n   Reboot\n   Reboot-Windows\n⏻   Shutdown"

selection=$(echo -e "$options" | wofi --dmenu -i -p "Power Menu" -M "fuzzy")

case $selection in
	"   Lock")
		hyprlock
		;;
	"󰗽   Logout")
		uwsm stop
		# hyprctl dispatch exit
		;;
	"   Reboot")
		reboot
		;;
	"   Reboot-Windows")
		pkexec grub-editenv - set boot_once_timeout=0
		pkexec grub-reboot 2
		reboot
		;;
	"⏻   Shutdown")
		shutdown now
		;;
esac

