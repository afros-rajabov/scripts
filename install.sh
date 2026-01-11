#!/usr/bin/env bash

# NOTE: Script for installing all other scripts by creating symlinks

WHERE=~/.local/bin

# Query all sh scripts except for current one
scripts=$(find . -name "*.sh" ! -name "*install.sh" -type f -printf "%P\n")

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
	target="$(pwd)/$script"
	destination="${WHERE}/${script_name}"

	if [[ -f $destination ]]; then
		printf "$script_name already exists. Skipping...\n"
		continue
	fi

	chmod +x $script
	ln -s $target $destination
	printf "${script_name} is installed\n"
done
