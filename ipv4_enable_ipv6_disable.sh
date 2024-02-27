#!/bin/bash

# Array of sysctl entries
sysctl_entries=(
  "net.ipv6.conf.all.disable_ipv6 = 1"
  "net.ipv6.conf.default.disable_ipv6 = 1"
  "net.ipv6.conf.lo.disable_ipv6 = 1"
  "net.ipv4.tcp_timestamps = 0"
  "net.ipv4.tcp_tw_reuse = 1"
  "net.ipv4.tcp_max_orphans = 60000"
  "net.ipv4.tcp_synack_retries = 3"
  "net.ipv4.tcp_window_scaling = 1"
  "fs.file-max = 5000000"
  "net.core.netdev_max_backlog = 400000"
  "net.core.optmem_max = 10000000"
  "net.core.rmem_default = 10000000"
  "net.core.rmem_max = 10000000"
  "net.core.somaxconn = 100000"
  "net.core.wmem_default = 10000000"
  "net.core.wmem_max = 10000000"
  "net.ipv4.conf.all.rp_filter = 1"
  "net.ipv4.conf.default.rp_filter = 1"
  "net.ipv4.ip_local_port_range = 10000 61000"
  "net.ipv4.tcp_ecn = 0"
  "net.ipv4.tcp_max_syn_backlog = 12000"
  "net.ipv4.tcp_max_tw_buckets = 2000000"
  "net.ipv4.tcp_mem = 30000000 30000000 30000000"
  "net.ipv4.tcp_rmem = 30000000 30000000 30000000"
  "net.ipv4.tcp_sack = 1"
  "net.ipv4.tcp_syncookies = 1"
  "net.ipv4.tcp_wmem = 30000000 30000000 30000000"
  "kernel.pid_max = 4194303"
  "net.ipv4.tcp_keepalive_time = 1800"
  "net.ipv4.tcp_keepalive_intvl = 10"
  "net.ipv4.tcp_keepalive_probes = 6"
  "vm.overcommit_memory = 0"
  "net.ipv4.ip_forward = 1"
)

# Function to update parameter in the sysctl.conf file
function update_parameter() {
    parameter="$1"
    value="$2"

    # Remove any existing lines containing the parameter
    sudo sed -i "/^$parameter/d" /etc/sysctl.conf

    # Add the new line with the parameter and value
    echo "$parameter = $value" | sudo tee -a /etc/sysctl.conf > /dev/null
}

# Check if /etc/sysctl.conf exists
if [ ! -f "/etc/sysctl.conf" ]; then
  echo "/etc/sysctl.conf does not exist. Please make sure the file is present."
  exit 1
fi

# Check if sysctl entries are present and update if necessary
for entry in "${sysctl_entries[@]}"; do
  parameter=$(echo "$entry" | cut -d' ' -f1)
  value=$(echo "$entry" | cut -d' ' -f3)
  update_parameter "$parameter" "$value"
done

# Apply the changes
sysctl -p

echo "Sysctl entries have been updated."
