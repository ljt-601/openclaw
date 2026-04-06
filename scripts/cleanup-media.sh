#!/bin/bash
# 清理超过1天的音频文件

MEDIA_DIR="/Users/bryle/.openclaw/media/inbound"

# 删除超过1天的 .ogg 和 .wav 文件
find "$MEDIA_DIR" -type f \( -name "*.ogg" -o -name "*.wav" -o -name "*.m4a" -o -name "*.mp3" -o -name "*.mp4" \) -mtime +1 -delete

# 记录清理日志
echo "[$(date)] Cleaned media files older than 1 day" >> /Users/bryle/.openclaw/media/cleanup.log
