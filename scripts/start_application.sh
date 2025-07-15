#!/bin/bash
# Start application script

echo "Starting Node.js application..."

# Navigate to application directory
cd /var/www/html/vite-aws

# Check if main application file exists
if [ ! -f "index.js" ]; then
    echo "index.js not found in application directory."
    exit 1
fi

# Install PM2 if not already installed (for process management)
if ! command -v pm2 &> /dev/null; then
    echo "Installing PM2 for process management..."
    npm install -g pm2
fi

# Start the application with PM2
echo "Starting application with PM2..."
pm2 stop vite-aws 2>/dev/null || true  # Stop if already running
pm2 delete vite-aws 2>/dev/null || true  # Delete old process

# Start the application
pm2 start index.js --name "vite-aws" --env production

# Save PM2 configuration
pm2 save

# Setup PM2 to start on boot
pm2 startup

# Start nginx if available (optional reverse proxy)
if command -v nginx &> /dev/null; then
    echo "Starting nginx..."
    systemctl start nginx
    systemctl enable nginx
fi

echo "Application started successfully."
echo "Application should be running on port 3000."
