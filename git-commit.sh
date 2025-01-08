#!/bin/bash

# 获取当前脚本的所在目录
SCRIPT_DIR=$(dirname "$(realpath "$0")")

cd "$SCRIPT_DIR" || exit 1

# 使用第一个参数作为提交信息，如果未提供参数，则使用默认信息
COMMIT_MESSAGE=${1:-"更新模版"}

# 忽略本地修改的文件（这些文件会被远程版本覆盖）
git update-index --assume-unchanged README.md
git update-index --assume-unchanged data.json

# 强制使用远程版本覆盖本地的 README.md 和 data.json
git fetch origin
git checkout origin/main -- README.md data.json

# 拉取远程分支的最新更新（不会覆盖当前工作区的其他更改）
git pull --rebase

# 添加所有更改（不包括被忽略的文件）
git add .

# 重置忽略的文件，确保不会被提交
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