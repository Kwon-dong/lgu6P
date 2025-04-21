#!/bin/bash

# 사용자로부터 커밋 메시지 입력받기
read -p "커밋 메시지를 입력하세요: " user_message

# 현재 KST 시간 구하기 (UTC+9)
current_time=$(TZ=Asia/Seoul date '+%Y-%m-%d %H:%M:%S (KST)')

# 메시지 조합
full_message="$user_message | $current_time"

# Git 커밋 및 푸시
git add .
git commit -m "$full_message"
git push
