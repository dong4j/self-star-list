#!/bin/bash

# 获取当前脚本的所在目录
SCRIPT_DIR=$(dirname "$(realpath "$0")")

cd "$SCRIPT_DIR" || exit 1

# 使用第一个参数作为提交信息，如果未提供参数，则使用默认信息
COMMIT_MESSAGE=${1:-"更新模版"}

# 强制覆盖本地的 README.md 和 data.json 文件
git fetch origin
git checkout origin/main -- README.md data.json

# 拉取远程分支最新更新，仅影响其他文件的版本控制信息（不会覆盖本地工作区文件）
git pull --rebase --no-commit

# 添加所有更改（不包括 README.md 和 data.json）
git add .

# 重置被覆盖的文件（确保 README.md 和 data.json 不被提交）
git reset README.md
git reset data.json

# 提交更改
if git diff --cached --quiet; then
  echo "没有需要提交的更改。"
else
  git commit -m "$COMMIT_MESSAGE"
fi

# 推送到远程仓库
git push -u origin main