#!/bin/bash

# Check if auditd is enabled
if systemctl is-enabled auditd | grep -q "enabled"; then
    echo "auditd is already enabled."
else
    echo "Enabling auditd..."
    systemctl --now enable auditd
fi

# Verify the status
systemctl is-enabled auditd
