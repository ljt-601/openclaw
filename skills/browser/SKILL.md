---
name: browser
description: Browser automation and control for OpenClaw. Use when you need to automate web interactions, take screenshots, navigate websites, fill forms, or control Chrome/OpenClaw browser profiles. This skill provides natural browser control via the browser tool for tasks like opening and navigating web pages, taking screenshots or snapshots of pages, clicking elements and filling forms, managing tabs and browser profiles, web scraping and content extraction, or any browser automation tasks.
---

# Browser Automation

## Overview

This skill enables human-like browser automation using OpenClaw's built-in browser control capabilities. You can navigate websites, interact with pages, take screenshots, and automate web workflows just like a human would.

## Quick Start

### Check Browser Status

Always start by checking if the browser service is running:

```bash
openclaw gateway status
```

If not running, start it:

```bash
openclaw gateway start
```

### Browser Profiles

OpenClaw supports two browser modes:

- **`chrome`** - Take over your existing Chrome browser via extension relay (click the OpenClaw toolbar icon on tabs you want to control)
- **`openclaw`** - Use an isolated, OpenClaw-managed browser (no extension needed)

Choose based on your needs:
- Need to work with existing logged-in sessions? → Use `profile="chrome"`
- Want clean isolation? → Use `profile="openclaw"`

### Common Operations

#### 1. Open a URL

```
browser action="open" targetUrl="https://example.com" profile="openclaw"
```

#### 2. Take a Snapshot (get page structure)

```
browser action="snapshot" targetId="<tab-id>" refs="aria"
```

This returns the page structure with accessible references for interaction.

#### 3. Click an Element

```
browser action="act" request={"kind":"click","ref":"<element-ref>"} targetId="<tab-id>"
```

#### 4. Type into a Field

```
browser action="act" request={"kind":"type","text":"Hello world","ref":"<input-ref>"} targetId="<tab-id>"
```

#### 5. Take a Screenshot

```
browser action="screenshot" targetId="<tab-id>"
```

#### 6. Navigate to URL

```
browser action="navigate" targetUrl="https://example.com" targetId="<tab-id>"
```

## Workflow Decision Tree

```
Need to automate a browser task?
│
├─ Is browser service running?
│  └─ No → Start it: openclaw gateway start
│
├─ What kind of task?
│  ├─ Just view a page? → action="open" or action="navigate"
│  ├─ Need to interact? → Snapshot first, then act
│  ├─ Take screenshot? → action="screenshot"
│  └─ Extract content? → action="snapshot" or use web_fetch for lightweight cases
│
└─ Which profile?
   ├─ Need existing cookies/login? → profile="chrome" (attach tab first)
   └─ Fresh session? → profile="openclaw"
```

## Best Practices

### 1. Always Snapshot Before Acting

Before clicking or typing, take a snapshot to get element references:

```
1. browser action="open" targetUrl="..." profile="openclaw"
2. browser action="snapshot" refs="aria"  → get targetId and element refs
3. browser action="act" request={...} targetId="<tab-id>"
```

### 2. Use Stable References

- **`refs="role"`** (default): role+name based (e.g., `button[name="Submit"]`)
- **`refs="aria"`**: aria-ref IDs (stable across calls, prefer for multi-step workflows)

For complex workflows, use `refs="aria"` in snapshot to get stable element IDs that work across multiple `act` calls.

### 3. Handle Dynamic Content

If pages load content dynamically:

- Use `request={"kind":"wait","textGone":"Loading...","timeMs":5000}` to wait for elements
- Take multiple snapshots if page structure changes
- Use `snapshotFormat="ai"` for AI-optimized page structure (experimental)

### 4. Error Handling

- If browser service is unreachable: `openclaw gateway restart`
- If element not found: Take a fresh snapshot (page may have changed)
- If using chrome profile: Ensure tab is attached (click OpenClaw extension icon)

## Common Patterns

### Form Filling

```
1. Open URL and get targetId
2. Snapshot with refs="aria"
3. Fill fields: act with kind="fill" or multiple kind="type" actions
4. Submit: act with kind="click" on submit button
```

Example:
```
browser action="act" request={"kind":"fill","fields":[{"ref":"name","value":"John"},{"ref":"email","value":"john@example.com"}]} targetId="<tab-id>"
```

### Navigation and Extraction

```
1. Open page: action="open" targetUrl="..."
2. Snapshot: action="snapshot" refs="aria"
3. Extract info from snapshot response
4. Navigate to next page: action="navigate" targetUrl="..."
```

### Screenshot Workflow

```
1. action="open" targetUrl="..." profile="openclaw"
2. Wait for page load (optional: act with kind="wait")
3. action="screenshot" fullPage=true (for entire page)
```

## Advanced Usage

### Managing Tabs

- **List tabs**: `browser action="tabs" profile="chrome"`
- **Focus tab**: `browser action="focus" targetId="<tab-id>"`
- **Close tab**: `browser action="close" targetId="<tab-id>"`

### Browser Control

- **Stop browser**: `browser action="stop" profile="openclaw"`
- **Check status**: `browser action="status"`

### Evaluate JavaScript

```
browser action="act" request={"kind":"evaluate","fn":"document.title"} targetId="<tab-id>"
```

## Resources

### references/
- `api-reference.md` - Complete browser tool API documentation (create if needed for advanced use)

### scripts/
- Helper scripts can be added for common workflows (e.g., form-filling templates)

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "Can't reach browser control service" | Run `openclaw gateway restart` |
| Chrome profile can't control tab | Click OpenClaw extension icon on the tab |
| Element not found in act | Take a fresh snapshot - page may have changed |
| Actions too fast | Add `request={"kind":"wait","timeMs":1000}` between actions |
| Snapshot returns wrong page | Ensure correct targetId from open/tabs response |
