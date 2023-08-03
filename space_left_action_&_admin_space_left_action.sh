#!/bin/bash

# Check if the values are already set
if grep -q "^\s*space_left_action\s*=\s*SYSLOG" /etc/audit/auditd.conf && grep -q "^\s*admin_space_left_action\s*=\s*SINGLE" /etc/audit/auditd.conf; then
    echo "Values are already set. No change needed."
else
    # Update auditd.conf
    sed -i 's/^\s*space_left_action.*/space_left_action = SYSLOG/' /etc/audit/auditd.conf
    sed -i 's/^\s*admin_space_left_action.*/admin_space_left_action = SINGLE/' /etc/audit/auditd.conf
    echo "Values updated."
fi
