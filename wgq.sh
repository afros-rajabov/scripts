#!/usr/bin/env bash

# NOTE: Script for switching wireguard inerfaces
# Requirements: wg, wg-quick, fzf

# Already connected interfaces
connected=$(wg show interfaces)

# Turn off prev interface (We are assuming there's just one)
if [[ -n "$connected" ]]; then
	wg-quick down $connected
	printf "\n$connected is disconnected\n\n"
fi

# Existing configs
configs=$(ls /etc/wireguard)
config_list=()
while IFS= read -r line; do
	if [[ $line == *.conf* ]]; then
		config_list+=("${line%.conf}")
	fi
done <<<"$configs"

# Select using fzf
selected=$(printf "%s\n" "${config_list[@]}" | sort | fzf --tmux)

# Connect
wg-quick up "$selected"
printf "\n$selected is connected"
