#!/bin/bash

# Set the audit rules
audit_rules=$(cat <<EOF
-w /etc/selinux/ -p wa -k MAC-policy
-a always,exit -F path=/usr/bin/chcon -F perm=x -F auid>=1000 -F auid!=4294967295 -k chcon
-a always,exit -F path=/usr/bin/setfacl -F perm=x -F auid>=1000 -F auid!=4294967295 -k setfacl
-a always,exit -F path=/usr/bin/chacl -F perm=x -F auid>=1000 -F auid!=4294967295 -k chacl
-a always,exit -F path=/usr/sbin/usermod -F perm=x -F auid>=1000 -F auid!=4294967295 -k usermod
-w /usr/lib/modules/ -p wa -k module
-e 2
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

# Ensure the audit configuration is immutable
if [[ "$(grep "^#* *[^#]*[^ ]* *[^#]*$|^ *[^#]*[^ ]* *[^#]*$" /etc/audit/audit.rules)" == *"-e 2"* ]]; then
  echo "Audit configuration is already immutable."
else
  echo "Making audit configuration immutable..."
  echo "-e 2" >> /etc/audit/audit.rules
  echo "Audit configuration has been made immutable."
fi

# Reload audit rules
augenrules --load

# Restart auditd service
service auditd restart

echo "Audit setup completed."
