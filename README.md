# OpenClaw 配置仓库

个人 OpenClaw 全局配置，包含 agents、scripts、completions 等。

## 目录结构

```
├── openclaw.json          # OpenClaw 主配置
├── agents/                # 全局 Agents（OpenClaw 格式）
│   └── <agent-name>/
│       ├── config.json
│       └── agent.md
├── scripts/               # 辅助脚本
│   ├── cleanup-media.sh
│   ├── get-youtube-info.sh
│   ├── tts-opus.sh
│   └── tts-speak.sh
├── completions/           # Shell 补全
│   ├── bash
│   ├── fish
│   ├── ps1
│   └── zsh
├── skills/                # Skills
└── extensions/            # 扩展
```

## 同步到本地

```bash
cd ~/gitHub_workplace/openclaw
bash scripts/sync.sh
```

## 更新流程

1. 修改本仓库中的文件
2. `git add . && git commit && git push`
3. `bash scripts/sync.sh` 同步到 `~/.openclaw/`
