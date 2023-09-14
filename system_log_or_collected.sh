#!/bin/bash

# Ensure rsyslog is not configured to receive logs from a remote client
rsyslog_conf="/etc/rsyslog.conf"
if grep -q "^*.*[^I][^I]*@" "$rsyslog_conf"; then
  echo "Remote logging is already disabled in $rsyslog_conf."
else
  echo "Disabling remote logging in $rsyslog_conf..."
  sed -i '/^\*\.\*\s*[^I][^I]*@/d' "$rsyslog_conf"
  echo "Remote logging has been disabled in $rsyslog_conf."
fi

# Ensure all logfiles have appropriate access configured
log_files=$(find /var/log/ -type f ! -perm 0640)
if [[ -z "$log_files" ]]; then
  echo "Log file permissions are already set to 0640 or more restrictive."
else
  echo "Setting log file permissions to 0640 or more restrictive..."
  find /var/log/ -type f -exec chmod 0640 {} +
  echo "Log file permissions have been set to 0640 or more restrictive."
fi

# Ensure changes to system administration scope (sudoers) are collected
sudoers_audit_conf="/etc/audit/rules.d/sudoers-audit.rules"
if [[ -f "$sudoers_audit_conf" ]]; then
  echo "Audit rules for sudoers are already in place."
else
  echo "Configuring audit rules for sudoers..."
  echo "-w /etc/sudoers -p wa -k scope" >> "$sudoers_audit_conf"
  echo "-w /etc/sudoers.d/ -p wa -k scope" >> "$sudoers_audit_conf"
  echo "Audit rules for sudoers have been configured."
fi

# Ensure actions as another user are always logged
pam_session_conf="/etc/pam.d/su"
if grep -q "session.*required.*pam_log" "$pam_session_conf"; then
  echo "Logging of actions as another user is already enabled in $pam_session_conf."
else
  echo "Enabling logging of actions as another user in $pam_session_conf..."
  sed -i '/^session\s*required\s*pam_unix.so\s*/a session    required     pam_log.so' "$pam_session_conf"
  echo "Logging of actions as another user has been enabled in $pam_session_conf."
fi

# Ensure events that modify the sudo log file are collected
sudo_audit_conf="/etc/audit/rules.d/sudo-audit.rules"
if [[ -f "$sudo_audit_conf" ]]; then
  echo "Audit rules for sudo log file are already in place."
else
  echo "Configuring audit rules for sudo log file..."
  echo "-w /var/log/sudo.log -p wa -k sudo-log" >> "$sudo_audit_conf"
  echo "Audit rules for sudo log file have been configured."
fi

# Ensure events that modify date and time information are collected
time_audit_conf="/etc/audit/rules.d/time-audit.rules"
if [[ -f "$time_audit_conf" ]]; then
  echo "Audit rules for date and time modification are already in place."
else
  echo "Configuring audit rules for date and time modification..."
  echo "-a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=time-change" >> "$time_audit_conf"
  echo "-a always,exit -F arch=b32 -S adjtimex,settimeofday,stime -F key=time-change" >> "$time_audit_conf"
  echo "-w /etc/localtime -p wa -k time-change" >> "$time_audit_conf"
  echo "Audit rules for date and time modification have been configured."
fi
