#!/bin/bash
# Stop application script

echo "Stopping Node.js application..."

# Find and kill any running Node.js processes for this application
if pgrep -f "node.*index.js" > /dev/null; then
    echo "Found running Node.js application, stopping it..."
    pkill -f "node.*index.js"
    sleep 2
    
    # Force kill if still running
    if pgrep -f "node.*index.js" > /dev/null; then
        echo "Force killing Node.js application..."
        pkill -9 -f "node.*index.js"
    fi
    
    echo "Node.js application stopped successfully."
else
    echo "No running Node.js application found."
fi

# Stop nginx if it's running (optional, if you're using nginx as reverse proxy)
if systemctl is-active --quiet nginx; then
    echo "Stopping nginx..."
    systemctl stop nginx
fi

echo "Stop application script completed."
