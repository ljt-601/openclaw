#!/bin/bash
# 使用微软免费的Edge TTS生成语音
# 用法: tts-speak.sh "要说的话" [输出文件]

TEXT="$1"
OUTPUT="${2:-/tmp/tts-output.mp3}"
VOICE="${TTS_VOICE:-zh-CN-XiaoxiaoNeural}"  # 默认用温暖的女声

if [ -z "$TEXT" ]; then
  echo "用法: $0 '要说的话' [输出文件]"
  exit 1
fi

edge-tts -t "$TEXT" -v "$VOICE" --write-media "$OUTPUT"
echo "$OUTPUT"
