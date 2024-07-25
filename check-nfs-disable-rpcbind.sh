#!/bin/bash

# Function to check if a package is installed
is_installed() {
    dpkg -l | grep -q "$1"
}

# Check if nfs-common is installed
if is_installed "nfs-common"; then
    echo "nfs-common is already installed."
else
    echo "Installing nfs-common..."
    apt update
    apt install -y nfs-common
fi

# Function to disable rpcbind if it's running
disable_rpcbind() {
    if systemctl is-active --quiet rpcbind; then
        echo "Disabling rpcbind..."
        systemctl stop rpcbind
        systemctl disable rpcbind
        systemctl stop rpcbind.socket
        systemctl disable rpcbind.socket
    else
        echo "rpcbind is not running."
    fi
}

# Create the script and systemd service to ensure it runs on startup
create_disable_rpcbind_service() {
    cat << 'EOF' > /usr/local/bin/disable-rpcbind.sh
#!/bin/bash
systemctl stop rpcbind
systemctl disable rpcbind
systemctl stop rpcbind.socket
systemctl disable rpcbind.socket
EOF

    chmod +x /usr/local/bin/disable-rpcbind.sh

    cat << 'EOF' > /etc/systemd/system/disable-rpcbind.service
[Unit]
Description=Disable RPCBind Service
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/disable-rpcbind.sh

[Install]
WantedBy=multi-user.target
EOF

    systemctl enable disable-rpcbind.service
}

# Disable rpcbind if necessary
disable_rpcbind
create_disable_rpcbind_service

echo "Setup complete."
