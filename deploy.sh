#!/bin/bash

# 获取当前脚本的所在目录
SCRIPT_DIR=$(dirname "$(realpath "$0")")

cd "$SCRIPT_DIR" || exit 1

# 使用第一个参数作为提交信息，如果未提供参数，则使用默认信息
COMMIT_MESSAGE=${1:-"更新"}

# 执行 Git 操作
git update-index --assume-unchanged README.md
git update-index --assume-unchanged data.json
git pull
git checkout README.md

# 定义本地目录
README_FILE="README.md" # 脚本同级目录下的 public
TAG_FILE="$SCRIPT_DIR/../source/stars/index.md"

# 上传文件到远程并覆盖
# echo "正在拷贝 README.md 到 stars 目录"
# cp "$README_FILE" "$TAG_FILE"
# echo "文件拷贝成功！"
