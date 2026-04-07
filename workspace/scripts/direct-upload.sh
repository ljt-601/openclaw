#!/bin/bash

# 直接上传 web.zip 到静态文件管理 - 绕过浏览器，最快！
# 作者: Bryle AI
# 用途: 一键上传文件到 /console/mall

set -e

FILE_PATH="$HOME/Documents/web.zip"
API_BASE="http://10.151.92.33"
API_ENDPOINT="/mall/system/staticFile/importData"
TARGET_PATH="/console/mall"
ROOT_PATH="html"

echo "🚀 直接上传脚本（绕过浏览器）"
echo "================================"
echo ""

# 检查文件
if [ ! -f "$FILE_PATH" ]; then
    echo "❌ 错误: 找不到文件 $FILE_PATH"
    exit 1
fi

echo "✅ 文件存在: $FILE_PATH"
FILE_SIZE=$(ls -lh "$FILE_PATH" | awk '{print $5}')
echo "📦 文件大小: $FILE_SIZE"
echo "📁 目标路径: $TARGET_PATH"
echo "🌐 API 端点: $API_ENDPOINT"
echo ""

# 检查是否提供了 token
if [ -z "$1" ]; then
    echo "❌ 错误: 缺少认证 token"
    echo ""
    echo "📝 获取 token 的方法："
    echo "   1. 打开浏览器开发者工具 (F12)"
    echo "   2. 进入 Network 标签"
    echo "   3. 刷新页面，点击任意请求"
    echo "   4. 在 Request Headers 中找到 Authorization: Bearer <YOUR_TOKEN>"
    echo "   5. 复制 token 部分（不包含 'Bearer '）"
    echo ""
    echo "💡 使用方法:"
    echo "   $0 <YOUR_TOKEN>"
    echo ""
    exit 1
fi

TOKEN="$1"

echo "🔐 使用 token: ${TOKEN:0:20}..."
echo ""
echo "⏳ 开始上传..."

# 执行上传
curl -X POST "$API_BASE$API_ENDPOINT" \
  -H "Authorization: Bearer $TOKEN" \
  -F "rootPath=$ROOT_PATH" \
  -F "filePath=$TARGET_PATH" \
  -F "file=@$FILE_PATH" \
  --progress-bar

echo ""
echo "✅ 上传完成！"
echo ""
echo "🔍 验证: 访问 $API_BASE/console/mall/web/mall/system/staticFile?rootPath=html&filePath=$TARGET_PATH"
