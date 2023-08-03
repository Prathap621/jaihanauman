#!/bin/bash

check_ubuntu_group_permissions() {
    group_file="/etc/group"
    expected_owner="root"
    expected_group="root"
    expected_permissions="644"

    owner=$(stat -c "%U" "$group_file")
    group=$(stat -c "%G" "$group_file")
    permissions=$(stat -c "%a" "$group_file")

    if [[ "$owner" != "$expected_owner" || "$group" != "$expected_group" || "$permissions" != "$expected_permissions" ]]; then
        echo "Incorrect permissions or ownership set on $group_file."
        echo "Expected owner: $expected_owner"
        echo "Expected group: $expected_group"
        echo "Expected permissions: $expected_permissions"
        echo ""
        echo "To remediate the issue, run one of the following commands:"
        echo "chown $expected_owner:$expected_group $group_file"
        echo "chmod $expected_permissions $group_file"
    else
        echo "Permissions and ownership on $group_file are configured correctly."
    fi
}

check_alma_group_permissions() {
    group_file="/etc/group"
    expected_owner="root"
    expected_group="root"
    expected_permissions="644"

    owner=$(stat -c "%U" "$group_file")
    group=$(stat -c "%G" "$group_file")
    permissions=$(stat -c "%a" "$group_file")

    if [[ "$owner" != "$expected_owner" || "$group" != "$expected_group" || "$permissions" != "$expected_permissions" ]]; then
        echo "Incorrect permissions or ownership set on $group_file."
        echo "Expected owner: $expected_owner"
        echo "Expected group: $expected_group"
        echo "Expected permissions: $expected_permissions"
        echo ""
        echo "To remediate the issue, run one of the following commands:"
        echo "chown $expected_owner:$expected_group $group_file"
        echo "chmod $expected_permissions $group_file"
    else
        echo "Permissions and ownership on $group_file are configured correctly."
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
    check_ubuntu_group_permissions
elif [[ "$os_name" == "almalinux" ]]; then
    check_alma_group_permissions
else
    echo "Unsupported operating system: $os_name"
    exit 1
fi
