#!/bin/bash
# Validate service script

echo "Validating Node.js application..."

# Wait a moment for the application to fully start
sleep 10

# Test the API endpoint and check for plain text response
echo "Testing /api/test endpoint..."

# Make request to /api/test and capture response
response=$(curl -f -s http://localhost:3000/api/test 2>/dev/null)
curl_exit_code=$?

if [ $curl_exit_code -eq 0 ] && [ -n "$response" ]; then
    echo "API endpoint (/api/test) is responding."
    echo "Response received: $response"
    
    # Check if response contains expected plain text
    if echo "$response" | grep -q "test API endpoint"; then
        echo "✓ Plain text response validated successfully."
        echo "✓ Service validation completed successfully."
        echo "✓ Application is healthy and responding correctly."
        exit 0
    else
        echo "ERROR: Response does not contain expected plain text content."
        echo "Expected text containing 'test API endpoint', got: $response"
        exit 1
    fi
else
    echo "ERROR: API endpoint (/api/test) is not responding or returned empty response."
    echo "Curl exit code: $curl_exit_code"
    exit 1
fi
