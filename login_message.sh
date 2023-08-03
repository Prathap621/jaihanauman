#!/bin/bash

# Check if the script is being run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or with sudo."
  exit 1
fi

# Create /etc/ssh/login_message file with custom content
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                 ____                 _
                / ___|_   _ _ __  ___| |__  _   _ _ __
               | |  _| | | | '_ \/ __| '_ \| | | | '_
               | |_| | |_| | |_) \__ \ | | | |_| | |_) |
                \____|\__,_| .__/|___/_| |_|\__,_| .__/
                           |_|                   |_|

========================================-{:systems@gupshup.io:}-======

             All connections are monitored and recorded.
        Disconnect IMMEDIATELY if you are not an authorized user.

  This system is for the use of authorised users only.individuals
using this computer system without authority, or in excess of their
authority, are subject to having all of their activities on this
system monitored and recorded by system personnel.

   In the course of monitoring individuals improperly using this
system, or in the course of system maintenance, the activities of
authorised users may also be monitored.

    Anyone using this system expressly consents to such monitoring
and is advised that if such monitoring reveals possible evidence of
criminal activity, system personnel may provide the evidence of such
monitoring to law enforcement officials.
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=" > /etc/ssh/login_message

# Set permissions for the login_message file
chmod 777 /etc/ssh/login_message

# Restart SSH service
/etc/init.d/ssh restart

# Change ownership of directories
chown -R deploy:automation /home/deploy
chown -R deploy:automation /backup

echo "The /etc/ssh/login_message file has been created and permissions have been set."
echo "SSH service has been restarted."
echo "Ownership of /home/deploy and /backup directories has been changed."
