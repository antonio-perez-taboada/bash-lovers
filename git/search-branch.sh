#!/bin/bash

# search_branch - Search for branches in the local and remote Git repository.
#
# Usage: search_branch <branch_name>
#   - <branch_name>: The name or fragment of the branch you want to search for.
#
# This function searches and displays matches in both local and remote branches of the Git repository.
# It prints the found local and remote branches.
#
function search_branch {
    if [ $# -eq 0 ]; then
        echo "Usage: searchBranch <branch_name>"
        return 1
    fi

    local branch_pattern="$1"

    # Search and display local branches
    local local_branches="$(git branch | grep "$branch_pattern" | sed 's/\* //')"
    echo -e '\nLOCAL BRANCHES:'
    for local_branch in ${local_branches[@]}; do
        echo "$local_branch"
    done

    # Search and display remote branches
    local remote_branches="$(git branch -r | grep "$branch_pattern" | grep -v 'origin/HEAD')"
    echo -e '\nREMOTE BRANCHES:'
    for remote_branch in ${remote_branches[@]}; do
        echo "$remote_branch"
    done
}

# Example usage:
# search_branch "feature"