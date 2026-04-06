#!/bin/bash
# sync.sh - 从 GitHub 拉取最新配置并同步到 ~/.openclaw/
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="$HOME/.openclaw"

echo "=== 同步 OpenClaw 配置 ==="
echo ""

# Agents（需要通过 CLI 注册或手动编辑 openclaw.json）
echo "[1/4] Agents → ~/.openclaw/ (需手动注册)"
echo "  OpenClaw Agent 需要通过 CLI 注册："
for d in "$SCRIPT_DIR/agents/"*/; do
    [ -d "$d" ] || continue
    agent_name=$(basename "$d")
    echo "  $ openclaw agents add $agent_name --global"
done

# Scripts
echo "[2/4] Scripts → ~/.openclaw/scripts/"
mkdir -p "$TARGET/scripts"
for f in "$SCRIPT_DIR/scripts/"*.sh; do
    [ -f "$f" ] && cp "$f" "$TARGET/scripts/" && echo "  $(basename "$f")"
done

# Completions
echo "[3/4] Completions → ~/.openclaw/completions/"
mkdir -p "$TARGET/completions"
for f in "$SCRIPT_DIR/completions/"*; do
    [ -f "$f" ] && cp "$f" "$TARGET/completions/" && echo "  $(basename "$f")"
done

# Main config（谨慎覆盖）
echo "[4/4] 主配置 → ~/.openclaw/"
if [ -f "$SCRIPT_DIR/openclaw.json" ]; then
    echo "  openclaw.json (跳过，避免覆盖本地修改)"
    echo "  如需同步，手动执行: cp $SCRIPT_DIR/openclaw.json ~/.openclaw/"
fi

echo ""
echo "=== 完成 ==="
