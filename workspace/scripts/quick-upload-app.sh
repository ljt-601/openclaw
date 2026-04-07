#!/bin/bash

# web.zip 快捷上传 - 桌面脚本
# 双击运行，自动上传

echo "🚀 web.zip 快捷上传"
echo "==================="
echo ""

# 检查文件
FILE="$HOME/Documents/web.zip"
if [ ! -f "$FILE" ]; then
    echo "❌ 找不到文件: $FILE"
    echo ""
    read -p "按回车键退出..."
    exit 1
fi

echo "✅ 找到文件: $FILE"
echo "📦 大小: $(ls -lh "$FILE" | awk '{print $5}')"
echo ""

# 打开浏览器并执行脚本
osascript << 'EOF'
tell application "Google Chrome"
    activate
    set theURL to "http://10.151.92.33/console/mall/web/mall/system/staticFile?rootPath=html"
    
    # 检查是否有打开的标签
    if (count of windows) is 0 then
        make new window
    end if
    
    set newTab to make new tab at end of tabs of window 1 with properties {URL:theURL}
    set active tab of window 1 to newTab
    
    -- 等待页面加载
    delay 2
    
    -- 在页面加载后，可以在这里注入 JavaScript
    -- 但需要手动选择文件，所以直接告诉用户
end tell

display dialog "✅ 页面已打开！

接下来请在浏览器中：
1. 点击'导入'按钮
2. 选择 web.zip 文件
3. 点击确定

或者：
按 Cmd+Option+J 打开控制台，粘贴上传脚本" buttons {"OK"} default button 1
EOF

echo ""
echo "✅ 浏览器已打开上传页面"
echo ""
echo "📋 接下来："
echo "   1. 点击'导入'按钮"
echo "   2. 选择 web.zip 文件"
echo "   3. 点击确定"
echo ""
read -p "完成后按回车键退出..."
