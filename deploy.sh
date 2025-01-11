#!/bin/bash

# 获取当前脚本的所在目录
SCRIPT_DIR=$(dirname "$(realpath "$0")")

cd "$SCRIPT_DIR" || exit 1

# 定义本地目录
README_FILE="README.md" # 脚本同级目录下的 public
TAG_FILE="$SCRIPT_DIR/../../source/stars/index.md"

# 读取文件A的内容
contentA=$(cat "$README_FILE")

# 使用sed获取<!-- more -->之前的所有内容
content_before_more=$(sed '/<!-- more -->/q' "$TAG_FILE")

# 拼接内容
combined_content="${content_before_more}\n\n${contentA}"
# 将拼接后的内容写入到TAG_FILE
echo -e "$combined_content" > "$TAG_FILE"

echo "内容已合并到 $TAG_FILE"