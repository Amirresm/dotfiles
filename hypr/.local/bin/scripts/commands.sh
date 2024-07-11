#! /usr/bin/env bash

command_names=$(find ~/.local/bin/scripts/commands/ -iname "*.sh" -type f -printf "%h: %f\n" | sed 's/\/home.*\/commands\///g' | tr '_' ' ' | sed 's/\.sh//g' | sed 's/\// > /g' | sed 's/.*/\u&/')

selection=$(echo "$command_names" | wofi --dmenu --insensitive --width 500 --height 500 --hide-scroll --prompt "Select command" -M "fuzzy")

readarray -d ' ' commands <<< "$(find ~/.local/bin/scripts/commands/ -iname "*.sh" -type f -printf "%h/%f ")"

readarray -t command_names <<< "$command_names"

# echo "${command_names}"
selected_command=""
for i in "${!command_names[@]}"; do
	# echo "${i}: ${command_names[$i]}"
	if [[ "${command_names[$i]}" = "${selection}" ]]; then
		selected_command=$(echo "${commands[$i]}" | xargs)
	fi
done

if [[ -z "$selected_command" ]]; then
	exit 0
fi

"$selected_command"
