#!/bin/bash

check_ubuntu_gshadow_permissions() {
    gshadow_file="/etc/gshadow"
    expected_owner="root"
    expected_group="shadow"
    expected_permissions="640"

    owner=$(stat -c "%U" "$gshadow_file")
    group=$(stat -c "%G" "$gshadow_file")
    permissions=$(stat -c "%a" "$gshadow_file")

    if [[ "$owner" != "$expected_owner" || "$group" != "$expected_group" || "$permissions" != "$expected_permissions" ]]; then
        echo "Incorrect permissions or ownership set on $gshadow_file."
        echo "Expected owner: $expected_owner"
        echo "Expected group: $expected_group"
        echo "Expected permissions: $expected_permissions"
        echo ""
        echo "To remediate the issue, run one of the following commands:"
        echo "chown $expected_owner:$expected_group $gshadow_file"
        echo "chmod $expected_permissions $gshadow_file"
    else
        echo "Permissions and ownership on $gshadow_file are configured correctly."
    fi
}

check_alma_gshadow_permissions() {
    gshadow_file="/etc/gshadow"
    expected_owner="root"
    expected_group="shadow"
    expected_permissions="640"

    owner=$(stat -c "%U" "$gshadow_file")
    group=$(stat -c "%G" "$gshadow_file")
    permissions=$(stat -c "%a" "$gshadow_file")

    if [[ "$owner" != "$expected_owner" || "$group" != "$expected_group" || "$permissions" != "$expected_permissions" ]]; then
        echo "Incorrect permissions or ownership set on $gshadow_file."
        echo "Expected owner: $expected_owner"
        echo "Expected group: $expected_group"
        echo "Expected permissions: $expected_permissions"
        echo ""
        echo "To remediate the issue, run one of the following commands:"
        echo "chown $expected_owner:$expected_group $gshadow_file"
        echo "chmod $expected_permissions $gshadow_file"
    else
        echo "Permissions and ownership on $gshadow_file are configured correctly."
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
    check_ubuntu_gshadow_permissions
elif [[ "$os_name" == "almalinux" ]]; then
    check_alma_gshadow_permissions
else
    echo "Unsupported operating system: $os_name"
    exit 1
fi
