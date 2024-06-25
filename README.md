# jaihanauman
jaihanauman



#!/bin/bash

SCRIPTS_FOLDER="script"  # Specify the folder path where the scripts are located
LOG_FILE="execution2.log"  # Specify the log file name
COUNTER=0

# Function to log messages with timestamp
log_message() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') $1"
}

# Find all script files in the specified folder
script_files=$(find "$SCRIPTS_FOLDER" -type f -name "*.sh")

# Create or truncate the log file
> "$LOG_FILE"

for script_file in $script_files; do
    COUNTER=$((COUNTER+1))
    
    log_message "Executing script: $script_file"
    
    # Execute the script and capture both stdout and stderr
    output=$(bash "$script_file" 2>&1)
    
    # Append to the log file
    {
        echo "=================================================="
        echo "Script $COUNTER: $script_file"
        echo "=================================================="
        echo "$(date +'%Y-%m-%d %H:%M:%S') Output:"
        echo "$output"
        echo "=================================================="
        echo
    } >> "$LOG_FILE"
done

log_message "Execution completed."

echo "All scripts executed. Logs written to: $LOG_FILE"

