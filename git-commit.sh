#!/bin/bash

# 获取当前脚本的所在目录
SCRIPT_DIR=$(dirname "$(realpath "$0")")

cd "$SCRIPT_DIR" || exit 1

# 使用第一个参数作为提交信息，如果未提供参数，则使用默认信息
COMMIT_MESSAGE=${1:-"更新页面"}

# 执行 Git 操作
git add . 
git reset README.md
git reset data.sjon
git commit -m "$COMMIT_MESSAGE"
git push -u origin main