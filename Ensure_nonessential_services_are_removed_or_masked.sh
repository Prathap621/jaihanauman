#!/bin/bash

# Run the lsof command to get the list of services
services=$(lsof -i -P -n | grep -v "(ESTABLISHED)")

# Loop through each service in the list
while read -r line; do
    # Extract the service name
    service=$(echo "$line" | awk '{print $1}')

    # Stop and mask the non-essential service
    echo "Stopping and masking service: $service..."
    sudo systemctl stop "$service" --quiet
    sudo systemctl mask "$service" --quiet
done <<< "$services"

echo "Service stopping and masking completed."
