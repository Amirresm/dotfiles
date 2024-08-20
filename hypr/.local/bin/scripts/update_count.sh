#!/usr/bin/env bash

echo " "

count=$(yay -Qu | wc -l)

if [[ $count == "0" ]]; then
	echo ""
else
	echo "  $count"
fi
