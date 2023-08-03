#!/bin/bash

check_shadow_group() {
    os_id=$(grep -oP 'ID=\K\w+' /etc/os-release)

    case "$os_id" in
        ubuntu)
            shadow_group_users=$(awk -F: '($1=="shadow") {print $NF}' /etc/group)
            shadow_group_gid=$(awk -F: '($1=="shadow") {print $3}' /etc/group)
            ;;
        almalinux)
            shadow_group_users=$(awk -F: '($1=="shadow") {print $NF}' /etc/group)
            shadow_group_gid=$(awk -F: '($1=="shadow") {print $3}' /etc/group)
            ;;
        *)
            echo "Unsupported operating system."
            exit 1
            ;;
    esac

    if [[ -z $shadow_group_users ]]; then
        echo "No users found in the shadow group."
    else
        echo "Users found in the shadow group:"
        echo "$shadow_group_users"
    fi

    # Remediation
    if [[ -n $shadow_group_users ]]; then
        echo "Performing remediation steps..."
        sed -ri 's/(^shadow:[^:]*:[^:]*:)([^:]+$)/\1/' /etc/group

        # Change primary group for users with shadow as their primary group
        while read -r user; do
            usermod -g <primary_group> "$user"
        done < <(awk -F: -v GID="$shadow_group_gid" '($4==GID) {print $1}' /etc/passwd)

        echo "Remediation steps completed."
    else
        echo "No remediation steps necessary."
    fi
}

# Execute the function
check_shadow_group
