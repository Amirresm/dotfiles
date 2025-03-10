#!/usr/bin/env python3
import subprocess
import json

def shell(cmd):
	return subprocess.check_output(cmd).decode('utf-8')

apps = json.loads(subprocess.check_output(["hyprctl", "-j", "clients"]).decode('utf-8'))

workspaces_string = ""
scratchpad_string = ""
for app in apps:
	line = f"  {app['workspace']['name']} | "
	line += f"{app['class']} -> "
	line += f"{app['title']}"
	line += "\n"
	app["match"] = line

	if app['workspace']['name'].startswith("special"):
		scratchpad_string += line
	else:
		workspaces_string += line

output_string = f'{workspaces_string}{scratchpad_string}'.strip()

selection_cmd = f'pkill wofi || echo "{output_string}" | wofi --dmenu --lines=8 --width=50% -b -M "fuzzy"'
selection = subprocess.check_output(selection_cmd, shell=True, text=True)
selection = [app for app in apps if app["match"] == selection][0]

focus_cmd = f"hyprctl dispatcher focuswindow address:{selection['address']}"
subprocess.run(focus_cmd, shell=True, check=True, text=True)


# BASH REFERENCE
# pkill wofi || hyprctl clients | rg ^Window | wofi --dmenu --width=80% --lines=12 | awk '{print $2}' | xargs -I{} hyprctl dispatcher focuswindow "address:0x{}"

# CLIENT_COLUMNS=$(echo "title class workspace" | sed "s/ /\|/g")

# echo $CLIENT_COLUMNS

# WINDOWS=$(hyprctl clients | rg "^\s*($CLIENT_COLUMNS|$):?\s?(.*)" -or '$2' | sed "s/:$//2;P;D")
# echo "$WINDOWS"

# pkill wofi | hyprctl clients | rg ^Window | wofi --dmenu | awk '{print $2}' | xargs -I{} hyprctl dispatcher focuswindow "address:0x{}"

