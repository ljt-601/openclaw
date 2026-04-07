# TOOLS.md - 本地环境备忘录

### GitHub
- **仓库:** https://github.com/ljt-601/openclaw
- **本地路径:** /Users/bryle/gitHub_workplace/openclaw
- **分支:** main
- **用途:** OpenClaw 个人配置统一管理（agents、skills、workspace 等）
- **注意:** 以后推 GitHub 都走这个仓库，不再新建

### 凭证
- **统一管理:** `~/.config/credentials.json`
- **包含:** 微信公众号、GitHub、NVIDIA、Minimax、OpenRouter、CSDN 等

### 聊天渠道
- **微信:** openclaw-weixin（Bot: 9d996d5178ec-im-bot），主要沟通渠道
- **飞书:** 已配置启用，支持文档/知识库/多维表格操作

### Get 笔记
- **CLI:** `getnote`（/opt/homebrew/bin/getnote）
- **凭证:** `~/.getnote/config.json`（API Key + Client ID）
- **Skill:** clawd/skills/getnote/（已安装，支持存/搜/知识库/标签）
- **知识库:** 生活散知(4)、学习(18)、工作(3)

### 微信公众号
- **名称:** AI研学进阶社
- **用途:** AI 相关文章发布
- **凭证:** 见 `~/.config/credentials.json` → wechat
- **发布方式:** 浏览器自动化推送草稿箱

### CLI 工具
- `getnote` — Get 笔记命令行
- `gh` — GitHub CLI
- `clawhub` — ClawHub 技能市场
- `whisper` — 本地语音转文字（/Users/bryle/.local/bin/whisper）
