#!/bin/bash

BASHRC="/etc/bash.bashrc"
RSYSLOG_CONF="/etc/rsyslog.d/bash.conf"
LOGROTATE_CONF="/etc/logrotate.d/rsyslog"

# Check if lines are present in /etc/bash.bashrc
if ! grep -q "export PROMPT_COMMAND='RETRN_VAL=\$?;logger -p local6.debug \"\$(whoami) [\$\$]: \$(history 1 | sed \"s/[ ][0-9]+[ ]//\" ) [\$RETRN_VAL]\"'" "$BASHRC"; then
    echo "Adding line to $BASHRC"
    sudo echo "export PROMPT_COMMAND='RETRN_VAL=\$?;logger -p local6.debug \"\$(whoami) [\$\$]: \$(history 1 | sed \"s/[ ][0-9]+[ ]//\" ) [\$RETRN_VAL]\"'" >> "$BASHRC"
fi

# Check if lines are present in /etc/rsyslog.d/bash.conf
if ! grep -q "local6.*    /var/log/commands.log" "$RSYSLOG_CONF"; then
    echo "Adding line to $RSYSLOG_CONF"
    sudo echo "local6.*    /var/log/commands.log" >> "$RSYSLOG_CONF"
fi

# Check if lines are present in /etc/logrotate.d/rsyslog
if ! grep -q "/var/log/commands.log" "$LOGROTATE_CONF"; then
    echo "Adding line to $LOGROTATE_CONF"
    sudo echo "/var/log/commands.log" >> "$LOGROTATE_CONF"
fi

# Restart rsyslog
sudo /etc/init.d/rsyslog restart

echo "Script execution completed."
