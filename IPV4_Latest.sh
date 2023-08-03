#!/bin/bash

# Function to update parameter in the sysctl.conf file
function update_parameter() {
    parameter="$1"
    value="$2"

    # Check if parameter is present in the sysctl.conf file
    if grep -q "^$parameter" /etc/sysctl.conf; then
        # Parameter is already present, update the value
        sudo sed -i "s/^$parameter.*/$parameter = $value/" /etc/sysctl.conf
    else
        # Parameter is not present, add a new line with the parameter and value
        echo "$parameter = $value" | sudo tee -a /etc/sysctl.conf > /dev/null
    fi
}

# Update net.ipv4.ip_forward
update_parameter "net.ipv4.ip_forward" "0"

# Update net.ipv4.conf.all.accept_source_route
update_parameter "net.ipv4.conf.all.accept_source_route" "0"

# Update net.ipv4.conf.default.accept_source_route
update_parameter "net.ipv4.conf.default.accept_source_route" "0"

# Update net.ipv4.conf.default.rp_filter
update_parameter "net.ipv4.conf.default.rp_filter" "0"

# Update net.ipv4.route.flush
update_parameter "net.ipv4.route.flush" "1"

# Update net.ipv4.conf.all.rp_filter
update_parameter "net.ipv4.conf.all.rp_filter" "0"

# Update net.ipv4.conf.all.accept_redirects
update_parameter "net.ipv4.conf.all.accept_redirects" "0"

# Update net.ipv4.conf.default.accept_redirects
update_parameter "net.ipv4.conf.default.accept_redirects" "0"

# Update net.ipv6.conf.all.forwarding
update_parameter "net.ipv6.conf.all.forwarding" "0"

# Update net.ipv4.conf.all.secure_redirects
update_parameter "net.ipv4.conf.all.secure_redirects" "0"

# Update net.ipv4.conf.default.secure_redirects
update_parameter "net.ipv4.conf.default.secure_redirects" "0"

# Update net.ipv4.conf.all.log_martians
update_parameter "net.ipv4.conf.all.log_martians" "1"

# Update net.ipv4.conf.default.log_martians
update_parameter "net.ipv4.conf.default.log_martians" "1"

# Update net.ipv4.icmp_echo_ignore_broadcasts
update_parameter "net.ipv4.icmp_echo_ignore_broadcasts" "1"

# Update net.ipv4.icmp_ignore_bogus_error_responses
update_parameter "net.ipv4.icmp_ignore_bogus_error_responses" "1"

# Update net.ipv6.conf.default.accept_ra
update_parameter "net.ipv6.conf.default.accept_ra" "0"

# Update net.ipv6.conf.all.accept_redirects
update_parameter "net.ipv6.conf.all.accept_redirects" "0"

# Update net.ipv4.tcp_syncookies
update_parameter "net.ipv4.tcp_syncookies" "1"

# Apply the changes
sudo sysctl -p
