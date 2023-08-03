#!/bin/bash

check_user_dot_file_permissions() {
    os_release_file="/etc/os-release"

    if [ -f "$os_release_file" ]; then
        os_name=$(grep -oP '(?<=^ID=).+' "$os_release_file")

        if [ "$os_name" == "ubuntu" ]; then
            awk -F: '($1!~/(halt|sync|shutdown|nfsnobody)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) { print $6 }' /etc/passwd | while read -r dir; do
                if [ -d "$dir" ]; then
                    for file in "$dir"/.[!.]*; do
                        if [ ! -h "$file" ] && [ -f "$file" ]; then
                            fileperm=$(stat -L -c "%A" "$file")
                            if [ "$(echo "$fileperm" | cut -c6)" != "-" ] || [ "$(echo "$fileperm" | cut -c9)" != "-" ]; then
                                chmod go-w "$file"
                            fi
                        fi
                    done
                fi
            done
        elif [ "$os_name" == "almalinux" ]; then
            awk -F: '($1!~/(halt|sync|shutdown)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) { print $1 " " $6 }' /etc/passwd | while read -r user dir; do
                if [ -d "$dir" ]; then
                    for file in "$dir"/.[!.]*; do
                        if [ ! -h "$file" ] && [ -f "$file" ]; then
                            fileperm=$(stat -L -c "%A" "$file")
                            if [ "$(echo "$fileperm" | cut -c6)" != "-" ] || [ "$(echo "$fileperm" | cut -c9)" != "-" ]; then
                                chmod go-w "$file"
                            fi
                        fi
                    done
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

echo "Checking user dot file permissions..."
check_user_dot_file_permissions
echo "User dot file permissions check complete."
