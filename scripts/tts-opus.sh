#!/bin/bash
# 使用微软免费的Edge TTS生成语音
# 生成飞书音频消息格式（opus）

TEXT="$1"
OUTPUT="${2:-/tmp/tts-output.opus}"
VOICE="${TTS_VOICE:-zh-CN-XiaoxiaoNeural}"  # 默认用温暖的女声

if [ -z "$TEXT" ]; then
  echo "用法: $0 '要说的话' [输出文件.opus]"
  exit 1
fi

# 先生成MP3
TMP_MP3="/tmp/tts-temp-$$-$RANDOM.mp3"
edge-tts -t "$TEXT" -v "$VOICE" --write-media "$TMP_MP3"

# 转换成opus格式（飞书音频消息格式）
ffmpeg -i "$TMP_MP3" -c:a libopus -b:a 24k "$OUTPUT" -y 2>/dev/null

# 清理临时文件
rm -f "$TMP_MP3"

echo "$OUTPUT"
