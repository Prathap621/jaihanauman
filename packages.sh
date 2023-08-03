#!/bin/bash

# Check if tcpdump is installed
if ! command -v tcpdump &> /dev/null; then
    echo "tcpdump is not installed. Installing..."
    sudo apt-get install -y tcpdump
else
    echo "tcpdump is already installed."
fi

# Check if sar is installed
if ! command -v sar &> /dev/null; then
    echo "sar is not installed. Installing..."
    sudo apt-get install -y sysstat
else
    echo "sar is already installed."
fi

# Check if telnet is installed
if ! command -v telnet &> /dev/null; then
    echo "telnet is not installed. Installing..."
    sudo apt-get install -y telnet
else
    echo "telnet is already installed."
fi

# Check if nslookup is installed
if ! command -v nslookup &> /dev/null; then
    echo "nslookup is not installed. Installing..."
    sudo apt-get install -y dnsutils
else
    echo "nslookup is already installed."
fi

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Installing..."
    sudo apt-get install -y curl
else
    echo "curl is already installed."
fi

# Check if traceroute is installed
if ! command -v traceroute &> /dev/null; then
    echo "traceroute is not installed. Installing..."
    sudo apt-get install -y traceroute
else
    echo "traceroute is already installed."
fi

# Check if ping is installed
if ! command -v ping &> /dev/null; then
    echo "ping is not installed. Installing..."
    sudo apt-get install -y iputils-ping
else
    echo "ping is already installed."
fi

# Check if mtr is installed
if ! command -v mtr &> /dev/null; then
    echo "mtr is not installed. Installing..."
    sudo apt-get install -y mtr
else
    echo "mtr is already installed."
fi

# Check if iperf is installed
if ! command -v iperf &> /dev/null; then
    echo "iperf is not installed. Installing..."
    sudo apt-get install -y iperf3
else
    echo "iperf is already installed."
fi

# Check if netstat is installed
if ! command -v netstat &> /dev/null; then
    echo "netstat is not installed. Installing..."
    sudo apt-get install -y net-tools
else
    echo "netstat is already installed."
fi

# Check if iftop is installed
if ! command -v iftop &> /dev/null; then
    echo "iftop is not installed. Installing..."
    sudo apt-get install -y iftop
else
    echo "iftop is already installed."
fi

# Check if dig is installed
if ! command -v dig &> /dev/null; then
    echo "dig is not installed. Installing..."
    sudo apt-get install -y dnsutils
else
    echo "dig is already installed."
fi

# Check if nc (netcat) is installed
if ! command -v nc &> /dev/null; then
    echo "nc (netcat) is not installed. Installing..."
    sudo apt-get install -y netcat
else
    echo "nc (netcat) is already installed."
fi

# Check if zabbix-agent2 is installed
if ! command -v zabbix_agent2 &> /dev/null; then
    echo "zabbix-agent2 is not installed. Installing..."
    wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu20.04_all.deb
    sudo dpkg -i zabbix-release_6.0-4+ubuntu20.04_all.deb
    sudo apt update
    sudo apt install -y zabbix-agent2 zabbix-agent2-plugin-*
    sudo systemctl restart zabbix-agent2
    sudo systemctl enable zabbix-agent2
    rm zabbix-release_6.0-4+ubuntu20.04_all.deb
else
    echo "zabbix-agent2 is already installed."
fi

# Check if filebeat is installed
if ! command -v filebeat &> /dev/null; then
    echo "filebeat is not installed. Installing..."
    # Add the installation steps for filebeat here
else
    echo "filebeat is already installed."
fi

# Check if sysctl is installed
if ! command -v sysctl &> /dev/null; then
    echo "sysctl is not installed. Installing..."
    sudo apt-get install -y sysctl
else
    echo "sysctl is already installed."
fi
