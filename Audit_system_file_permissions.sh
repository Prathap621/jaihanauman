#!/bin/bash

audit_system_file_permissions() {
    os_release_file="/etc/os-release"

    if [ -f "$os_release_file" ]; then
        os_name=$(grep -oP '(?<=^ID=).+' "$os_release_file")

        if [ "$os_name" == "ubuntu" ]; then
            system_files=(
                "/etc/passwd"
                "/etc/shadow"
                "/etc/group"
                "/etc/gshadow"
                "/etc/sudoers"
                "/etc/crontab"
                "/etc/cron.allow"
                "/etc/cron.deny"
                "/etc/at.allow"
                "/etc/at.deny"
                "/etc/securetty"
                "/etc/login.defs"
                "/etc/pam.d/"
                "/etc/ssh/sshd_config"
            )
        elif [ "$os_name" == "almalinux" ]; then
            system_files=(
                "/etc/passwd"
                "/etc/shadow"
                "/etc/group"
                "/etc/gshadow"
                "/etc/sudoers"
                "/etc/crontab"
                "/etc/cron.allow"
                "/etc/cron.deny"
                "/etc/at.allow"
                "/etc/at.deny"
                "/etc/securetty"
                "/etc/login.defs"
                "/etc/pam.d/"
                "/etc/ssh/sshd_config"
            )
        else
            echo "Unsupported operating system. Exiting..."
            exit 1
        fi

        echo "Auditing system file permissions..."
        for file in "${system_files[@]}"; do
            if [ -e "$file" ]; then
                permissions=$(stat -c "%a" "$file")
                owner=$(stat -c "%U" "$file")
                group=$(stat -c "%G" "$file")
                printf "File: %s\nPermissions: %s\nOwner: %s\nGroup: %s\n\n" "$file" "$permissions" "$owner" "$group"
            fi
        done
        echo "System file permissions audit complete."
    else
        echo "Unable to determine the operating system. Exiting..."
        exit 1
    fi
}

audit_system_file_permissions
