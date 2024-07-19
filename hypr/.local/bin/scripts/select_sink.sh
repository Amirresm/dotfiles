#!/usr/bin/env bash

sinks=$(wpctl status)

sinks=${sinks#*Sinks:
}
sinks=${sinks%%
 │  
 ├─ Sources*}

sinks=$(echo "$sinks" | sed -e 's/\s│[ *]*//' | tac)

echo "Options are:"
echo "$sinks"

selection=$(echo -e "$sinks" | tac | wofi --dmenu -i -p "Sinks" -M "fuzzy")
selection=$(echo "$selection" | sed -e 's/^\([0-9]*\).*/\1/')

if [ -n "$selection" ];
then
	echo "Sink: $selection"
	wpctl set-default "$selection"
fi


