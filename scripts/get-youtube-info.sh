#!/bin/bash
# 获取YouTube视频的字幕或元数据
# 用法: get-youtube-info.sh "YouTube_URL"

URL="$1"

if [ -z "$URL" ]; then
  echo "用法: $0 'YouTube_URL'"
  exit 1
fi

echo "=== 视频信息 ==="
yt-dlp --get-title --get-description --get-duration "$URL" 2>/dev/null

echo ""
echo "=== 字幕 ==="
yt-dlp --write-subs --write-auto-subs --sub-lang zh-Hans,en --skip-download "$URL" 2>/dev/null

# 查找下载的字幕文件
SUB_FILE=$(ls -t *.zh-Hans.*.vtt *.en.*.vtt 2>/dev/null | head -1)

if [ -n "$SUB_FILE" ]; then
  echo ""
  echo "字幕文件: $SUB_FILE"
  echo "内容:"
  cat "$SUB_FILE" | grep -v "^\[" | grep -v "^NOTE" | sed 's/<[^>]*>//g' | tr -s '\n' ' ' | head -500
  rm -f *.vtt 2>/dev/null
else
  echo "没有找到字幕"
fi
