# TOOLS.md - Local Notes

Skills define *how* tools work. This file is for *your* specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:
- Camera names and locations
- SSH hosts and aliases  
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras
- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH
- home-server → 192.168.1.100, user: admin

### TTS
- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.

### GitHub
- **仓库:** https://github.com/ljt-601/openclaw
- **本地路径:** /Users/bryle/gitHub_workplace/openclaw
- **分支:** main
- **用途:** OpenClaw 个人配置统一管理（agents、skills、workspace 等）
- **注意:** 以后推 GitHub 都走这个仓库，不再新建

### 凭证
- **统一管理:** `~/.config/credentials.json`
- **包含:** 微信公众号、GitHub、NVIDIA、Minimax、OpenRouter、CSDN 等
