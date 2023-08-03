#!/bin/bash

check_duplicate_group_names() {
    os_id=$(grep -oP 'ID=\K\w+' /etc/os-release)

    case "$os_id" in
        ubuntu)
            group_file="/etc/group"
            ;;
        almalinux)
            group_file="/etc/gshadow"
            ;;
        *)
            echo "Unsupported operating system."
            exit 1
            ;;
    esac

    duplicate_groups=$(cut -d: -f1 "$group_file" | sort | uniq -d)
    
    if [[ -z $duplicate_groups ]]; then
        echo "No duplicate group names found."
    else
        echo "Duplicate group names found:"
        echo "$duplicate_groups"
    fi
}

# Execute the function with sudo
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

check_duplicate_group_names
