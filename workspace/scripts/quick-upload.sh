#!/bin/bash

# 快速上传 web.zip 到静态文件管理
# 作者: Bryle AI
# 用途: 一键打开上传对话框

TARGET_FILE="$HOME/Documents/web.zip"
STATIC_URL="http://10.151.92.33/console/mall/web/mall/system/staticFile?rootPath=html"

echo "🎯 快速上传脚本"
echo "================"
echo ""
echo "📂 目标文件: $TARGET_FILE"
echo "🌐 目标页面: 静态文件管理"
echo "📁 上传路径: /console/mall"
echo ""
echo "🚀 执行流程："
echo "   ✅ 导航到静态文件页面"
echo "   ✅ 输入路径: /console/mall"
echo "   ✅ 点击搜索"
echo "   ✅ 打开导入对话框"
echo ""
echo "⏳ 等待你完成最后一步："
echo "   📌 选择 web.zip 文件"
echo "   📌 点击确定上传"
echo ""
echo "💡 提示: 如果浏览器没响应，请检查 OpenClaw 扩展是否连接（显示 ON）"
echo ""
echo "📮 快速链接: $STATIC_URL"
echo ""

# 检查文件是否存在
if [ ! -f "$TARGET_FILE" ]; then
    echo "❌ 错误: 找不到文件 $TARGET_FILE"
    exit 1
fi

echo "✅ 文件检查通过: $(ls -lh "$TARGET_FILE" | awk '{print $5}')"
echo ""
echo "🔄 准备就绪，开始执行..."
echo ""

# 这里可以添加更多的自动化逻辑
# 当前版本提供手动操作的快速链接
