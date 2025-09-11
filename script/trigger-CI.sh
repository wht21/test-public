#!/bin/bash

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <COMMIT_ID> <SECURITY>"
    exit 1
fi

# Read commitId, repositoryUrl, and security from parameters or environment variables
COMMIT_ID=$1
SECURITY=$2
REPO_URL="https://github.com/${GITHUB_REPOSITORY}.git"

# Get current timestamp
timestamp=$(date +%s)

# Concatenate the parameters with timestamp
combined="${COMMIT_ID}${SECURITY}${timestamp}"

# Calculate the MD5 hash
base64_hash=$(echo -n "${combined}" | base64)

# Output the MD5 hash
echo "MD5 hash of '${COMMIT_ID}' and '${SECURITY}' combined with timestamp is: ${md5_hash}"

# Return the MD5 hash as the script's exit code
echo "${SECURITY}"

# curl -v -H "Content-Type: application/json" -H "Authorization: Basic '${SECURITY}'"  -d '{"Type": "CREATE-TASK", "commitId":"5c8dd25af56304cdcd358eccbf5778dcd442c5e0","repositoryUrl": "https://github.com/alibaba/rtp-llm.git"}' "https://triggerid-to-mq-wjrdhcgbie.cn-hangzhou.fcapp.run"

# 发送 CREATE-TASK 请求
curl -v -H "Content-Type: application/json" \
     -H "Authorization: Basic ${SECURITY}" \
     -d "{\"type\": \"CREATE-TASK\", \"commitId\": \"${COMMIT_ID}\", \"repositoryUrl\": \"${REPO_URL}\"}" \
     "https://triggerid-to-mq-wjrdhcgbie.cn-hangzhou.fcapp.run"