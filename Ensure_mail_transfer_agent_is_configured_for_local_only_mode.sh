#!/bin/bash

# Check if postfix is installed
if dpkg -s postfix &> /dev/null; then
    # Check if postfix is configured for local-only mode
    if grep -q "^inet_interfaces[[:space:]]*=[[:space:]]*localhost" /etc/postfix/main.cf; then
        echo "Postfix is already configured for local-only mode."
    else
        # Configure postfix for local-only mode
        echo "Configuring Postfix for local-only mode..."
        echo "inet_interfaces = localhost" | sudo tee -a /etc/postfix/main.cf > /dev/null
        sudo service postfix restart
        echo "Postfix has been configured for local-only mode."
    fi
else
    echo "Postfix is not installed."
fi

echo "Mail Transfer Agent configuration check completed."
