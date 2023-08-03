#!/bin/bash

check_duplicate_gids() {
    os_id=$(grep -oP 'ID=\K\w+' /etc/os-release)

    case "$os_id" in
        ubuntu)
            group_file="/etc/group"
            ;;
        almalinux)
            group_file="/etc/group"
            ;;
        *)
            echo "Unsupported operating system."
            exit 1
            ;;
    esac

    duplicate_gids=$(cut -d: -f3 "$group_file" | sort | uniq -d)
    
    if [[ -z $duplicate_gids ]]; then
        echo "No duplicate Group IDs (GIDs) found in $group_file."
    else
        echo "Duplicate Group IDs (GIDs) found in $group_file:"
        echo "$duplicate_gids"
    fi
}

# Execute the function
check_duplicate_gids

