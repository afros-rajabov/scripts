#!/usr/bin/env bash

# NOTE: Script for uninstalling all the scripts

WHERE=~/.local/bin

# Query all sh scripts except for current one
scripts=$(find . -name "*.sh" ! -name "*install.sh" -type f -printf "%P\n")

# Create a list
script_names=()
while IFS= read -r line; do
	if [[ $line == *.sh* ]]; then
		script_name="${line%.sh}"
		target="${WHERE}/${script_name}"

		if [[ ! -f $target ]]; then
			printf "$script_name doesn't exists. Skipping...\n"
			continue
		fi

		rm $target
	fi
done <<<"$scripts"
