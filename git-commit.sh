#!/bin/bash

# 获取当前脚本的所在目录
SCRIPT_DIR=$(dirname "$(realpath "$0")")

cd "$SCRIPT_DIR" || exit 1

# 使用第一个参数作为提交信息，如果未提供参数，则使用默认信息
COMMIT_MESSAGE=${1:-"更新模版"}

# 执行 Git 操作
# 忽略本地修改的文件
git update-index --assume-unchanged README.md
git update-index --assume-unchanged data.json

# 拉取远程最新代码
git pull 

# 添加所有更改（不包括被忽略的文件）
git add .

# 重置被忽略的文件（确保它们不被提交）
git reset README.md
git reset data.json

# 提交更改
git commit -m "$COMMIT_MESSAGE"

# 推送到远程仓库
git push -u origin main