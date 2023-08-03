#!/bin/bash

# Check if the audit=1 parameter is set in the GRUB configuration
if grep -q "^\s*linux" "/boot/grub/grub.cfg" | grep -qv "audit=1"; then
    # Add the audit=1 parameter to GRUB_CMDLINE_LINUX in /etc/default/grub
    sudo sed -i 's/^GRUB_CMDLINE_LINUX="\(.*\)"/GRUB_CMDLINE_LINUX="\1 audit=1"/' /etc/default/grub

    # Update the grub2 configuration
    sudo update-grub

    echo "audit=1 parameter added to GRUB configuration. Auditing for pre-auditd processes is enabled."
else
    echo "audit=1 parameter is already set in the GRUB configuration."
fi
