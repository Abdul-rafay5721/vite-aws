#!/bin/bash
# Validate service script

echo "Validating Node.js application..."

# Wait a moment for the application to fully start
sleep 5

# Check if the application process is running
if pgrep -f "node.*index.js" > /dev/null || pm2 list | grep -q "vite-aws.*online"; then
    echo "Application process is running."
else
    echo "ERROR: Application process is not running."
    exit 1
fi

# Test the application endpoints
echo "Testing application endpoints..."

# Test root endpoint
if curl -f -s http://localhost:3000/ > /dev/null; then
    echo "Root endpoint (/) is responding."
else
    echo "ERROR: Root endpoint (/) is not responding."
    exit 1
fi

# Test API endpoint
if curl -f -s http://localhost:3000/api/test > /dev/null; then
    echo "API endpoint (/api/test) is responding."
else
    echo "ERROR: API endpoint (/api/test) is not responding."
    exit 1
fi

# Check application logs for any errors
if pm2 logs vite-aws --lines 10 | grep -i error; then
    echo "WARNING: Errors found in application logs."
else
    echo "No errors found in application logs."
fi

echo "Service validation completed successfully."
echo "Application is healthy and responding to requests."
