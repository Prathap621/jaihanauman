#!/bin/bash

# Check if the authentication is already required for single user mode
if grep -q "^auth required pam_securetty.so$" /etc/sulogin; then
    # Inform the user that authentication is already required
    echo "Authentication is already required for single user mode."
else
    # Add the authentication requirement to the sulogin file
    echo "auth required pam_securetty.so" | sudo tee -a /etc/sulogin > /dev/null

    # Inform the user that authentication is now required
    echo "Authentication is now required for single user mode."
fi
