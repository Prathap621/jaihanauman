#!/bin/bash

# Set the audit rules
audit_rules=$(cat <<EOF
-w /etc/hosts -p wa -k system-locale
-w /etc/network/ -p wa -k network-environment
-w /sbin/insmod -p x -k modules
-w /sbin/rmmod -p x -k modules
-w /sbin/modprobe -p x -k modules
-w /bin/su -p x -k privileged-commands
-w /usr/bin/sudo -p x -k privileged-commands
-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts
-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts
-w /etc/passwd -p wa -k identity
-w /etc/group -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-a always,exit -F arch=b64 -S chmod -F auid>=1000 -F auid!=4294967295 -k permission-modification
-a always,exit -F arch=b32 -S chmod -F auid>=1000 -F auid!=4294967295 -k permission-modification
-w /etc/fstab -p wa -k fs-mounts
-w /var/log/wtmp -p wa -k session
-w /var/run/utmp -p wa -k session
-w /var/log/faillog -p wa -k logins
-w /var/log/lastlog -p wa -k logins
-w /var/log/tallylog -p wa -k logins
-a always,exit -F arch=b64 -S unlink -F auid>=1000 -F auid!=4294967295 -k file-deletion
-a always,exit -F arch=b32 -S unlink -F auid>=1000 -F auid!=4294967295 -k file-deletion
EOF
)

# Check if audit rules are already set
existing_rules=$(auditctl -l)
if [[ "$existing_rules" == *"$audit_rules"* ]]; then
  echo "Audit rules are already set."
else
  echo "Setting audit rules..."
  echo "$audit_rules" > /etc/audit/rules.d/custom.rules
  echo "Audit rules have been set."
fi

# Reload audit rules
augenrules --load

# Restart auditd service
service auditd restart

echo "Audit setup completed."
