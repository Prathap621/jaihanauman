#!/bin/bash

# Define the new content for the /etc/issue file
new_content="Authorized uses only. All activity may be monitored and reported."

# Remove any instances of \m, \r, \s, \v, or references to the OS platform from the new content
new_content=$(echo "$new_content" | sed -e 's/\\[mrsSv]//g' -e 's/\\[osOS]//g')

# Update the /etc/issue file with the new content
echo "$new_content" | sudo tee /etc/issue > /dev/null

# Inform the user that the /etc/issue file has been updated
echo "The /etc/issue file has been updated with the appropriate contents."
