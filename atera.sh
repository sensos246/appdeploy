#!/bin/bash

# Define a writable path for saving the installer
TEMP_DIR="/tmp/atera"
TEMP_PATH="$TEMP_DIR/AgentInstaller.pkg"

# Create a temporary directory if it doesn't exist
echo "Preparing temporary directory..."
if [ ! -d "$TEMP_DIR" ]; then
    mkdir -p "$TEMP_DIR"
fi

# Download the Atera installer to a writable location
echo "Downloading Atera agent..."
sudo curl -L "https://HelpdeskSupport370165517.servicedesk.atera.com/GetAgent/mac/0033z00003EFZZfAAP/341" -o "$TEMP_PATH"

# Check if the file was downloaded successfully
if [ -f "$TEMP_PATH" ]; then
    echo "Installing Atera agent..."
    sudo installer -pkg "$TEMP_PATH" -target /
    if [ $? -eq 0 ]; then
        echo "Atera agent installed successfully."
    else
        echo "Error: Installation failed."
        exit 2
    fi
else
    echo "Error: Download failed. Please check the URL or network connectivity."
    exit 1
fi

# Clean up temporary files
echo "Cleaning up..."
rm -rf "$TEMP_DIR"
echo "Done."
