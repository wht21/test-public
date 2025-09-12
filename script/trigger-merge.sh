#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <COMMIT_ID> <SECURITY>"
    exit 1
fi

COMMIT_ID=$1
SECURITY=$2
REPO_URL="https://github.com/${GITHUB_REPOSITORY}.git"
AONE_PROJECT_ID="${AONE_PROJECT_ID}"
SRC_BRANCH="open_merge_${COMMIT_ID}"
DEST_BRANCH="main"

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


JSON_BODY=$(cat <<EOF
{
  \"type\": \"MERGE-TASK\",
  \"repositoryUrl\": \"${REPO_URL}\",
  \"commitId\": \"${COMMIT_ID}\",
  \"aone\": \"{
    \"projectId\": \"${AONE_PROJECT_ID}\"
  }\",
  \"srcBranch\": \"${SRC_BRANCH}\",
  \"destBranch\": \"${DEST_BRANCH}\"
}
EOF
)

echo "Sending MERGE-TASK for commitId: ${COMMIT_ID}"

# 调用 HTTP 函数发送消息
curl -v -H "Content-Type: application/json" \
     -H "Authorization: Basic ${SECURITY}" \
     -d "${JSON_BODY}" \
     "https://triggerid-to-mq-wjrdhcgbie.cn-hangzhou.fcapp.run"