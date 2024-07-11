#! /usr/bin/env bash

device="wlp2s0"

connection=$(nmcli device status | grep -e "^$device\s" | awk '{print $4}')

nmcli connection down "$connection"
nmcli connection up "$connection"

