#!/bin/bash

# Check if SNMP server is installed
if dpkg -s snmpd &> /dev/null; then
    echo "Uninstalling SNMP Server..."
    sudo apt-get purge snmpd -y
    echo "SNMP Server has been uninstalled."
else
    echo "SNMP Server is not installed."
fi

echo "SNMP Server check completed."
