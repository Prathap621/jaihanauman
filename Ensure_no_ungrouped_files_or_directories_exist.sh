#!/bin/bash

check_ubuntu_unowned_files() {
    unowned_files=$(find / -xdev \( -type f -o -type d \) -nouser 2>/dev/null)

    if [[ -n "$unowned_files" ]]; then
        echo "Unowned files and directories found:"
        echo "$unowned_files"
        echo ""
        echo "To remediate the issue, review the listed files and directories and assign appropriate ownership."
    else
        echo "No unowned files or directories found."
    fi
}

check_alma_unowned_files() {
    unowned_files=$(find / -xdev \( -type f -o -type d \) -nouser 2>/dev/null)

    if [[ -n "$unowned_files" ]]; then
        echo "Unowned files and directories found:"
        echo "$unowned_files"
        echo ""
        echo "To remediate the issue, review the listed files and directories and assign appropriate ownership."
    else
        echo "No unowned files or directories found."
    fi
}

# Check the operating system
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    os_name="${ID,,}"
else
    echo "Unable to determine the operating system."
    exit 1
fi

# Run the appropriate function based on the operating system
if [[ "$os_name" == "ubuntu" ]]; then
    check_ubuntu_unowned_files
elif [[ "$os_name" == "almalinux" ]]; then
    check_alma_unowned_files
else
    echo "Unsupported operating system: $os_name"
    exit 1
fi
