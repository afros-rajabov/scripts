#!/bin/bash

# NOTE: Script for activating python venv

# Set default target if none provided
target="${1:-.venv}"

# Check if venv directory exists
if [[ ! -d "$target" ]]; then
	printf "Virtual environment directory '$target' not found\n"
	exit 1
fi

# Check if we're already in a virtual environment
if [[ -n "$VIRTUAL_ENV" ]]; then
	printf "Already in a virtual environment: $VIRTUAL_ENV\n"
	exit 0
fi

if [[ -f "$target/bin/activate.fish" ]]; then
	source $target/bin/activate.fish
	printf "Activated virtual environment: $target\n"
else
	printf "Could not find appropriate activation script for '$target'\n"
	exit 1
fi
