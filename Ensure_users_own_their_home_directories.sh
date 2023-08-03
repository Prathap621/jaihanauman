#!/bin/bash

check_user_home_ownership() {
    os_release_file="/etc/os-release"

    if [ -f "$os_release_file" ]; then
        os_name=$(grep -oP '(?<=^ID=).+' "$os_release_file")

        if [ "$os_name" == "ubuntu" ]; then
            awk -F: '($1!~/(halt|sync|shutdown|nfsnobody)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) { print $1 " " $6 }' /etc/passwd | while read -r user dir; do
                if [ -d "$dir" ]; then
                    dir_owner=$(stat -c "%U" "$dir")
                    if [ "$dir_owner" != "$user" ]; then
                        chown "$user:$user" "$dir"
                    fi
                fi
            done
        elif [ "$os_name" == "almalinux" ]; then
            awk -F: '($1!~/(halt|sync|shutdown)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) { print $1 " " $6 }' /etc/passwd | while read -r user dir; do
                if [ -d "$dir" ]; then
                    dir_owner=$(stat -c "%U" "$dir")
                    if [ "$dir_owner" != "$user" ]; then
                        chown "$user:$user" "$dir"
                    fi
                fi
            done
        else
            echo "Unsupported operating system. Exiting..."
            exit 1
        fi
    else
        echo "Unable to determine the operating system. Exiting..."
        exit 1
    fi
}

echo "Checking user home directory ownership..."
check_user_home_ownership
echo "User home directory ownership check complete."
