#!/usr/bin/env bash

for file in ./*.service; do
	service=$(basename "$file")
	echo "Syncing $service"
	ln -sf "$(pwd)/$service" "/etc/systemd/system/$service"
done

