#!/bin/bash

check_groups_existence() {
    os_id=$(grep -oP 'ID=\K\w+' /etc/os-release)

    case "$os_id" in
        ubuntu)
            check_groups_existence_ubuntu
            ;;
        almalinux)
            check_groups_existence_almalinux
            ;;
        *)
            echo "Unsupported operating system."
            exit 1
            ;;
    esac
}

check_groups_existence_ubuntu() {
    for group_id in $(cut -s -d: -f4 /etc/passwd | sort -u); do
        if ! grep -q -P "^.*?:[^:]*:$group_id:" /etc/group; then
            echo "Group $group_id is referenced by /etc/passwd but does not exist in /etc/group"
        fi
    done
}

check_groups_existence_almalinux() {
    for group_id in $(cut -s -d: -f4 /etc/passwd | sort -u); do
        if ! grep -q -P "^.*?:[^:]*:$group_id:" /etc/group && ! grep -q -P "^.*?:[^:]*:[^:]*:$group_id:" /etc/group; then
            echo "Group $group_id is referenced by /etc/passwd but does not exist in /etc/group"
        fi
    done
}

# Execute the function
check_groups_existence
