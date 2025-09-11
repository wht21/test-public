#!/bin/bash

# 检查参数
if [ $# -ne 2 ]; then
    echo "Usage: $0 <COMMIT_ID> <SECURITY>"
    exit 1
fi

COMMIT_ID=$1
SECURITY=$2


while true; do
    echo "Querying CI status for commitId: ${COMMIT_ID} ..."

    response=$(curl -s  -H "Content-Type: application/json" \
                        -H "Authorization: Basic ${SECURITY}" \
                        -d "{\"type\": \"RETRIEVE-TASK-STATUS\", \"commitId\": \"${COMMIT_ID}\"}" "https://get-tasend-back-twkvcdsbpj.cn-hangzhou.fcapp.run")
    status=$(echo "$response" | grep -o '"status":"[^"]*"' | cut -d':' -f2 | tr -d '"')

    echo "Current status: $status"

    if [[ "$status" == "DONE" || "$status" == "FAILED" || "$status" == "UNKNOWN" ]]; then
        echo "CI running with status: $status"
        if [[ "$status" == "DONE" ]]; then
            echo "CI completed successfully"
            return 0
        fi
        else then
            echo "CI failed or status unknown"
            return -1
        fi
        break
    fi

    sleep 5
done