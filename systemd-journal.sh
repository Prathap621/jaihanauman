#!/bin/bash

# Ensure sudo authentication timeout is configured correctly
sudo_timeout_conf="/etc/sudoers.d/timeout"
if [[ -f "$sudo_timeout_conf" ]]; then
  echo "Sudo authentication timeout is already configured."
else
  echo "Configuring sudo authentication timeout..."
  echo "Defaults timestamp_timeout=300" >> "$sudo_timeout_conf"
  echo "Sudo authentication timeout has been configured."
fi

# Ensure systemd-journal-remote is installed
if command -v systemd-journal-remote &>/dev/null; then
  echo "systemd-journal-remote is already installed."
else
  echo "Installing systemd-journal-remote..."
  apt-get update
  apt-get install -y systemd-journal-remote
  echo "systemd-journal-remote has been installed."
fi

# Ensure journald is not configured to receive logs from a remote client
journald_conf="/etc/systemd/journald.conf"
if grep -q "^ForwardToSyslog" "$journald_conf"; then
  echo "Remote logging is already disabled in $journald_conf."
else
  echo "Disabling remote logging in $journald_conf..."
  sed -i 's/^ForwardToSyslog=yes/ForwardToSyslog=no/' "$journald_conf"
  echo "Remote logging has been disabled in $journald_conf."
fi

# Restart systemd-journald service
systemctl restart systemd-journald

echo "Configuration checks and changes completed."
