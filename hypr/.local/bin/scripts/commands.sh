#! /usr/bin/env bash

echo "Commands Menu: Reading commands..."
command_names=$(find ~/.local/bin/scripts/commands/ -iname "*.sh" -type f -printf "%h: %f\n" | sed 's/\/home.*\/commands\///g' | tr '_' ' ' | sed 's/\.sh//g' | sed 's/\// > /g' | sed 's/.*/\u&/')

echo "Commands Menu: Selecting command..."
selection=$(echo "$command_names" | wofi --dmenu --insensitive --width 500 --height 500 --hide-scroll --prompt "Select command" -M "fuzzy")

if [[ -z "$selection" ]]; then
    exit 0
fi

echo "Commands Menu: Processing ${selection}...1"
readarray -d ' ' commands <<< "$(find ~/.local/bin/scripts/commands/ -iname "*.sh" -type f -printf "%h/%f ")"

echo "Commands Menu: Processing ${selection}...2"
readarray -t command_names <<< "$command_names"

echo "Commands Menu: Processing ${selection}...3"
selected_command=""
for i in "${!command_names[@]}"; do
	if [[ "${command_names[$i]}" = "${selection}" ]]; then
		selected_command=$(echo "${commands[$i]}" | xargs)
	fi
done

if [[ -z "$selected_command" ]]; then
	exit 0
fi

echo "Commands Menu: Executing command..."

# exec "$selected_command"
systemd-run --user --scope -- bash -c "exec $selected_command"
