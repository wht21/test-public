#!/bin/bash

# 检查参数
if [ $# -ne 2 ]; then
    echo "Usage: $0 <COMMIT_ID> <SECURITY>"
    exit 1
fi

COMMIT_ID=$1
SECURITY=$2

QUERY_URL="https://triggerid-to-mq-wjrdhcgbie.cn-hangzhou.fcapp.run/query?commitId=${COMMIT_ID}"

while true; do
    echo "Querying CI status for commitId: ${COMMIT_ID} ..."

    response=$(curl -s  -H "Content-Type: application/json" \
                        -H "Authorization: Basic ${SECURITY}" \
                        -d "{\"commitId\": \"${COMMIT_ID}\"}" "https://get-tasend-back-twkvcdsbpj.cn-hangzhou.fcapp.run")
    status=$(echo "$response" | grep -o '"status":"[^"]*"' | cut -d':' -f2 | tr -d '"')

    echo "Current status: $status"

    if [[ "$status" == "DONE" || "$status" == "FAILED" || "$status" == "UNKNOWN" ]]; then
        echo "CI finished with status: $status"
        break
    fi

    sleep 5
done