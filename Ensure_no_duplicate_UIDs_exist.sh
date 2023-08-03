#!/bin/bash

check_duplicate_uids() {
    os_id=$(grep -oP 'ID=\K\w+' /etc/os-release)

    case "$os_id" in
        ubuntu)
            duplicate_uids=$(cut -f3 -d":" /etc/passwd | sort -n | uniq -c | while read x ; do
                [ -z "$x" ] && break
                set - $x
                if [ $1 -gt 1 ]; then
                    users=$(awk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | xargs)
                    echo "Duplicate UID ($2): $users"
                fi
            done)
            ;;
        almalinux)
            duplicate_uids=$(cut -f3 -d":" /etc/passwd | sort -n | uniq -c | while read x ; do
                [ -z "$x" ] && break
                set - $x
                if [ $1 -gt 1 ]; then
                    users=$(awk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | xargs)
                    echo "Duplicate UID ($2): $users"
                fi
            done)
            ;;
        *)
            echo "Unsupported operating system."
            exit 1
            ;;
    esac

    if [[ -z $duplicate_uids ]]; then
        echo "No duplicate UIDs found in /etc/passwd."
    else
        echo "Duplicate UIDs found in /etc/passwd:"
        echo "$duplicate_uids"
    fi
}

# Execute the function
check_duplicate_uids
