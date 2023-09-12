#!/bin/bash

# log - Show Git commit log with optional filtering by file path.
#
# Usage: log [<file_path>]
#   - <file_path>: Optional file path to filter commits by.
#
# This function displays the Git commit log with a custom format, including commit hash, author, date,
# commit message, and optional file statistics. It can be used with or without a file path filter.
#
# Options:
#   --help: Show this help message and usage examples.
#
function log {
    local file_path="$1"

    # Check if the current directory is a Git repository
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        echo "Error: Not in a Git repository."
        return 1
    fi

    # Define the Git log format with colorized output
    local log_format="%C(blue)%h%Creset %C(blue)%H%Creset %C(cyan)%ae%Creset(%C(magenta)%an%Creset) %n%C(Yellow)%s%Creset %C(magenta)%ad%Creset"

    if [ "$file_path" == "--help" ]; then
        # Show help message and usage examples
        echo "Usage: log [<file_path>]"
        echo "Options:"
        echo "  --help: Show this help message and usage examples."
        echo "Examples:"
        echo "  log               # Show Git log without file path filter"
        echo "  log some_file.js  # Show Git log with file path filter"
    elif [ -n "$file_path" ]; then
        # Show Git log with file path filter
        git log --pretty=format:"$log_format" --stat --no-merges -- */*"$file_path"*
    else
        # Show Git log without file path filter
        git log --pretty=format:"$log_format" --stat --no-merges
    fi
}

# Example usage:
# log               # Show Git log without file path filter
# log some_file.js  # Show Git log with file path filter
# log --help        # Show help message and usage examples