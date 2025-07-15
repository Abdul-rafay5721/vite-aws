#!/bin/bash
# Install dependencies script

echo "Installing Node.js dependencies..."

# Navigate to application directory
cd /var/www/html/vite-aws

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "Node.js not found. Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    apt-get install -y nodejs
fi

# Check if npm is available
if ! command -v npm &> /dev/null; then
    echo "npm not found. Installing npm..."
    apt-get install -y npm
fi

# Install application dependencies
if [ -f "package.json" ]; then
    echo "Installing npm dependencies..."
    npm install --production
    
    if [ $? -eq 0 ]; then
        echo "Dependencies installed successfully."
    else
        echo "Failed to install dependencies."
        exit 1
    fi
else
    echo "package.json not found in application directory."
    exit 1
fi

# Set proper permissions for the application files
chown -R www-data:www-data /var/www/html/vite-aws
chmod -R 755 /var/www/html/vite-aws

echo "Install dependencies script completed."
