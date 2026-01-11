#!/usr/bin/env bash

# NOTE: Script for installing all other scripts by creating symlinks

# Query all sh scripts except for current one
scripts=$(find . -name "*.sh" ! -name "install.sh" -type f -printf "%P\n")

# Create a list
files=()
while IFS= read -r line; do
	if [[ $line == *.sh* ]]; then
		files+=("${line}")
	fi
done <<<"$scripts"

# Do the thing
for script in "${files[@]}"; do
	script_name="${script%.sh}"
	chmod +x $script
	ln -s "$(pwd)/$script" ~/.local/bin/"${script_name}"
	printf "${script_name} is installed\n"
done
