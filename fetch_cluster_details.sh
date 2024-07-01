#!/bin/bash

# Prompt the user for the base URL
read -p "Enter the Loadbalancer URL or CRDB Node URL (e.g., https://loadbalancer-abc.xyz:8080): " BASE_URL

# Trim trailing slash from base URL if present
BASE_URL=$(echo "$BASE_URL" | sed 's:/*$::')

# Prompt the user for the username and password
read -p "Enter the username: " USERNAME
read -p "Enter the password: " PASSWORD
echo

# Generate the API key using the login endpoint
LOGIN_RESPONSE=$(curl --request POST \
  --url "$BASE_URL/api/v2/login/" \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data "username=$USERNAME&password=$PASSWORD" \
  --silent --show-error)

# Extract the API key from the response using sed
API_KEY=$(echo "$LOGIN_RESPONSE" | sed -n 's/.*"session":"\([^"]*\)".*/\1/p')

# Check if the API key was successfully extracted
if [ -z "$API_KEY" ]; then
    echo "---------------------------------------------"
    echo "| Failed to generate API key.               |"
    echo "| Please check the username and password.   |"
    echo "---------------------------------------------"
    exit 1
fi

# Construct the full URL with default limit and offset
FULL_URL="$BASE_URL/api/v2/nodes/"

# Execute the curl command and save the response to a JSON file
curl --request GET \
  --url "$FULL_URL" \
  --header "X-Cockroach-API-Session: $API_KEY" \
  --output crdb_details.json \
  --silent --show-error

# Check if the curl command was successful
if [ $? -eq 0 ]; then
    echo "---------------------------------------------"
    echo "| Response saved to crdb_details.json       |"
    echo "---------------------------------------------"
else
    echo "-----------------------------------------------------------"
    echo "| Failed to fetch data. Please check the URL and API key. |"
    echo "-----------------------------------------------------------"
    # Optionally, remove the crdb_details.json file if it exists and the request failed
    rm -f crdb_details.json
fi