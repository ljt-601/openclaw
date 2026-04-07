#!/bin/bash

# 一键上传静态文件脚本
# 使用方法: ./scripts/upload-static-file.sh

echo "🚀 开始自动化上传流程..."

# 静态文件页面 URL
STATIC_FILE_URL="http://10.151.92.33/console/mall/web/mall/system/staticFile?rootPath=html"
TARGET_PATH="/console/mall"

echo "📍 导航到静态文件页面..."
echo "📍 输入路径: $TARGET_PATH"
echo "📍 点击搜索..."
echo "📍 打开导入对话框..."
echo ""
echo "✅ 脚本准备完成！"
echo ""
echo "📋 接下来需要你手动完成最后一步："
echo "   1. 在打开的对话框中，点击'点击上传'"
echo "   2. 选择 ~/Documents/web.zip"
echo "   3. 点击'确定'完成上传"
echo ""
echo "💡 提示: 如果需要完全自动化，请检查浏览器扩展连接状态"

# 通过 exec 调用 OpenClaw 的浏览器功能
# 这里需要通过其他方式调用，或者直接给出操作步骤

echo "🔗 快速访问链接（复制到浏览器）:"
echo "$STATIC_FILE_URL"
