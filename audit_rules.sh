#!/bin/bash

# Set the audit rules
audit_rules=$(cat <<EOF
-a always,exit -F arch=b64 -S adjtimex,settimeofday,time,clock_settime -F key=time-change
-a always,exit -F arch=b64 -S clock_settime -F key=time-change
-a always,exit -F arch=b32 -S clock_settime -F key=audit_time_rules
-a always,exit -F arch=b64 -S clock_settime -F key=audit_time_rules
-w /etc/security/opasswd -p wa -k identity
-w /etc/issue -p wa -k system-locale
-w /etc/group -p wa -k audit_account_changes
-w /etc/passwd -p wa -k audit_account_changes
-w /etc/gshadow -p wa -k audit_account_changes
-w /etc/shadow -p wa -k audit_account_changes
-w /etc/security/opasswd -p wa -k audit_account_changes
-a always,exit -F arch=b64 -S sethostname -F key=system-locale
-a always,exit -F arch=b64 -S setdomainname -F key=system-locale
-w /etc/issue.net -p wa -k system-locale
-w /etc/issue -p wa -k audit_network_modifications
-w /etc/apparmor -p wa -k MAC-policy
-w /var/log/btmp -p wa -k session
-a always,exit -F arch=b32 -S chown -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b32 -S lchown -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b32 -S fchmodat -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S setxattr -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S lsetxattr -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S removexattr -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S lremovexattr -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S fremovexattr -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S fchmod -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S fchmod -F auid=0 -F key=perm_mod
-a always,exit -F arch=b64 -S fchmodat -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S fchmodat -F auid=0 -F key=perm_mod
-a always,exit -F arch=b64 -S chown -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S chown -F auid=0 -F key=perm_mod
-a always,exit -F arch=b64 -S fchown -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S fchown -F auid=0 -F key=perm_mod
-a always,exit -F arch=b64 -S fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S fchownat -F auid=0 -F key=perm_mod
-a always,exit -F arch=b64 -S lsetxattr -F auid=0 -F key=perm_mod
-a always,exit -F arch=b64 -S fsetxattr -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S fsetxattr -F auid=0 -F key=perm_mod
-a always,exit -S all -F path=/bin/ping6 -F perm=x -F auid>=1000 -F auid!=-1 -F key=privileged
-a always,exit -S all -F path=/bin/fusermount -F perm=x -F auid>=1000 -F auid!=-1 -F key=privileged
-a always,exit -S all -F path=/bin/mount -F perm=x -F auid>=1000 -F auid!=-1 -F key=privileged
-a always,exit -F arch=b64 -S rename,unlink,unlinkat,renameat -F auid>=1000 -F auid!=-1 -F key=delete
-a always,exit -F arch=b32 -S unlink,rename,unlinkat,renameat -F auid>=1000 -F auid!=-1 -F key=delete
-a always,exit -F arch=b64 -S creat -F exit=-EACCES -F auid>=1000 -F auid!=-1 -F key=access
-a always,exit -F arch=b32 -S creat -F exit=-EACCES -F auid>=1000 -F auid!=-1 -F key=access
-a always,exit -F arch=b64 -S removexattr -F auid=1000 -F key=perm_mod
-a always,exit -F arch=b64 -S lremovexattr -F auid=1000 -F key=perm_mod
-a always,exit -F arch=b64 -S fremovexattr -F auid=1000 -F key=perm_mod
-a always,exit -F arch=b64 -S open -F exit=-EACCES -F auid>=1000 -F auid!=-1 -F key=access
-a always,exit -F arch=b32 -S open -F exit=-EACCES -F auid>=1000 -F auid!=-1 -F key=access
-a always,exit -F arch=b64 -S open,truncate,ftruncate,creat,openat -F exit=-EACCES -F auid>=1000 -F auid!=-1 -F key=access
-a always,exit -F arch=b32 -S open,creat,truncate,ftruncate,openat -F exit=-EACCES -F auid>=1000 -F auid!=-1 -F key=access
-a always,exit -F arch=b64 -S open,truncate,ftruncate,creat,openat -F exit=-EPERM -F auid>=1000 -F auid!=-1 -F key=access
-a always,exit -F arch=b32 -S open,creat,truncate,ftruncate,openat -F exit=-EPERM -F auid>=1000 -F auid!=-1 -F key=access
-w /bin/sudo -p a -k privileged
-w /var/log/lastlog -p wa -k logins
-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=-1 -F key=perm_mod
-a always,exit -F arch=b64 -S init_module,delete_module -F key=modules
-w /etc/localtime -p wa -k time-change
-w /etc/localtime -p wa -k audit_time_rules
-w /etc/hosts -p wa -k system-locale
-w /etc/apparmor.d -p wa -k MAC-policy
-w /var/log/faillog -p wa -k logins
-w /var/log/tallylog -p wa -k logins
-w /var/run/utmp -p wa -k session
-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=-1 -F key=mounts
-a always,exit -F arch=b64 -S mount -F auid=0 -F key=mounts
-w /etc/sudoers -p wa -k scope
-w /etc/sudoers -p wa -k actions
-w /var/log/sudo.log -p wa -k actions
-w /sbin/modprobe -p x -k modules
-w /sbin/insmod -p x -k modules
-w /sbin/rmmod -p x -k modules
-w /etc/hosts -p wa -k audit_network_modifications
-w /etc/issue.net -p wa -k audit_network_modifications
-w /etc/sudoers.d -p wa -k scope
-w /var/log/wtmp -p wa -k session
-w /etc/network -p wa -k system-locale
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
