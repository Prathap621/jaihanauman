#!/bin/bash

check_shadow_permissions() {
    shadow_file="/etc/shadow"
    expected_owner="root"
    expected_group="root"

    if [ -f "$shadow_file" ]; then
        owner=$(stat -c "%U" "$shadow_file")
        group=$(stat -c "%G" "$shadow_file")
        permissions=$(stat -c "%a" "$shadow_file")

        if [[ "$owner" != "$expected_owner" || "$group" != "$expected_group" || "$permissions" != "640" ]]; then
            echo "Incorrect permissions or ownership set on $shadow_file."
            echo "Expected owner: $expected_owner"
            echo "Expected group: $expected_group"
            echo "Expected permissions: 640"
            echo ""
            echo "To remediate the issue, run one of the following commands:"
            echo "chown $expected_owner:$expected_group $shadow_file"
            echo "chmod 640 $shadow_file"
        else
            echo "Permissions and ownership on $shadow_file are configured correctly."
        fi
    else
        echo "File $shadow_file not found."
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
if [[ "$os_name" == "ubuntu" || "$os_name" == "almalinux" ]]; then
    check_shadow_permissions
else
    echo "Unsupported operating system: $os_name"
    exit 1
fi
