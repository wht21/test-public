
#!/bin/bash

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <COMMIT_ID> <SECURITY>"
    exit 1
fi

# Read the two parameters
COMMIT_ID=$1
SECURITY=$2

# Get current timestamp
timestamp=$(date +%s)

# Concatenate the parameters with timestamp
combined="${COMMIT_ID}${SECURITY}${timestamp}"

# Calculate the MD5 hash
base64_hash=$(echo -n "${combined}" | base64)

# Output the MD5 hash
echo "MD5 hash of '${COMMIT_ID}' and '${SECURITY}' combined with timestamp is: ${md5_hash}"

# Return the MD5 hash as the script's exit code
echo "${base64_hash}"

curl -v -H "Content-Type: application/json" -H "Authorization: Basic Z2l0aHViLWNpLXRyaWdnZXI6QWRtaW5AZ2FsMTIz"  -d '{"message": "Hello"}' "https://triggerid-to-mq-wjrdhcgbie.cn-hangzhou.fcapp.run"
