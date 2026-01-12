#!/usr/bin/env bash

# NOTE: Script for cleaning tmux resurrect

WHERE=~/.local/share/tmux/resurrect
last="$WHERE/last"

if [[ ! -f $last ]]; then
	printf "nothing to do...\n"
	exit 0
fi

last_symlink=$(readlink $last)

resurrect_files=$(ls $WHERE)
while IFS= read -r line; do
	if [[ $line == *.txt* && $line != $last_symlink ]]; then
		rm "$WHERE/$line"
		printf "$line is deleted\n"
	fi
done <<<"$resurrect_files"
