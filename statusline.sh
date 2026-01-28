#!/bin/bash
input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name')
email=$(git config user.email 2>/dev/null)
echo "[$model] $email"
