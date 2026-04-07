# Browser Tool API Reference

Complete API reference for the OpenClaw browser control tool.

## Tool Signature

```
browser(action, profile, target, node, targetUrl, targetId, ...)
```

## Actions

### status
Check browser control service status.

**Parameters:**
- None

**Returns:** Service status and available profiles

**Example:**
```
browser action="status"
```

### start
Start the browser service.

**Parameters:**
- `profile` (optional): "chrome" or "openclaw"
- `target` (optional): "sandbox", "host", or "node"

**Example:**
```
browser action="start" profile="openclaw" target="host"
```

### stop
Stop the browser service.

**Parameters:**
- `profile` (optional): "chrome" or "openclaw"

**Example:**
```
browser action="stop" profile="openclaw"
```

### profiles
List available browser profiles.

**Parameters:** None

**Returns:** Available profiles and their status

**Example:**
```
browser action="profiles"
```

### tabs
List open browser tabs.

**Parameters:**
- `profile` (required): "chrome" or "openclaw"
- `limit` (optional): Maximum number of tabs to return

**Returns:** List of tabs with IDs, URLs, and titles

**Example:**
```
browser action="tabs" profile="chrome"
```

### open
Open a new tab and navigate to URL.

**Parameters:**
- `targetUrl` (required): URL to open
- `profile` (optional): "chrome" or "openclaw" (default: "openclaw")
- `target` (optional): "sandbox", "host", or "node"

**Returns:** Tab ID that can be used in subsequent actions

**Example:**
```
browser action="open" targetUrl="https://example.com" profile="openclaw"
```

### focus
Focus on a specific tab.

**Parameters:**
- `targetId` (required): Tab ID from tabs/open response

**Example:**
```
browser action="focus" targetId="<tab-id>"
```

### close
Close a tab.

**Parameters:**
- `targetId` (required): Tab ID to close

**Example:**
```
browser action="close" targetId="<tab-id>"
```

### snapshot
Capture page structure for automation.

**Parameters:**
- `targetId` (optional): Tab ID (uses active tab if not specified)
- `refs` (optional): "role" (default) or "aria" - reference style
- `snapshotFormat` (optional): "aria" (default) or "ai" - output format
- `depth` (optional): How deep to traverse DOM
- `compact` (optional): Return compact representation

**Returns:** Page structure with element references

**Example:**
```
browser action="snapshot" targetId="<tab-id>" refs="aria"
```

### screenshot
Take a screenshot of a tab.

**Parameters:**
- `targetId` (optional): Tab ID
- `type` (optional): "png" or "jpeg" (default: "png")
- `fullPage` (optional): Capture entire scrollable page (default: false)

**Returns:** Screenshot image data

**Example:**
```
browser action="screenshot" targetId="<tab-id>" fullPage=true
```

### navigate
Navigate to a URL in an existing tab.

**Parameters:**
- `targetUrl` (required): URL to navigate to
- `targetId` (optional): Tab ID (uses active tab if not specified)

**Example:**
```
browser action="navigate" targetUrl="https://example.com" targetId="<tab-id>"
```

### act
Perform an action on the page.

**Parameters:**
- `request` (required): Action specification object
- `targetId` (optional): Tab ID

**Request Kinds:**

#### click
Click an element.

```json
{
  "kind": "click",
  "ref": "<element-ref>",
  "doubleClick": false,
  "button": "left",
  "modifiers": ["Shift"]
}
```

#### type
Type text into an element.

```json
{
  "kind": "type",
  "text": "text to type",
  "ref": "<input-ref>",
  "submit": false,
  "slowly": false
}
```

#### press
Press a keyboard key.

```json
{
  "kind": "press",
  "key": "Enter"
}
```

#### hover
Hover over an element.

```json
{
  "kind": "hover",
  "ref": "<element-ref>"
}
```

#### drag
Drag from one element to another.

```json
{
  "kind": "drag",
  "startRef": "<source-ref>",
  "endRef": "<target-ref>"
}
```

#### select
Select an option from a dropdown.

```json
{
  "kind": "select",
  "ref": "<select-ref>",
  "values": ["option1", "option2"]
}
```

#### fill
Fill multiple form fields at once.

```json
{
  "kind": "fill",
  "fields": [
    {"ref": "name", "value": "John Doe"},
    {"ref": "email", "value": "john@example.com"}
  ]
}
```

#### wait
Wait for a condition or time.

```json
{
  "kind": "wait",
  "timeMs": 5000
}
```

Or wait for text to disappear:

```json
{
  "kind": "wait",
  "textGone": "Loading...",
  "timeMs": 10000
}
```

#### evaluate
Execute JavaScript in the page.

```json
{
  "kind": "evaluate",
  "fn": "document.title"
}
```

#### close
Close a dialog or alert.

```json
{
  "kind": "close",
  "accept": true
}
```

**Examples:**
```
browser action="act" request='{"kind":"click","ref":"button[name=\"Submit\"]"}' targetId="<tab-id>"

browser action="act" request='{"kind":"type","text":"hello","ref":"input[name=\"q\"]"}' targetId="<tab-id>"

browser action="act" request='{"kind":"wait","timeMs":2000}' targetId="<tab-id>"
```

### console
Get browser console logs.

**Parameters:**
- `targetId` (optional): Tab ID

**Returns:** Console log entries

**Example:**
```
browser action="console" targetId="<tab-id>"
```

### pdf
Save page as PDF.

**Parameters:**
- `targetId` (optional): Tab ID
- `landscape` (optional): Landscape orientation (default: false)

**Returns:** PDF data

**Example:**
```
browser action="pdf" targetId="<tab-id>"
```

## Reference Styles

### role (default)
Elements are referenced by their ARIA role and name.
- Format: `<role>[name="<name>"]`
- Example: `button[name="Submit"]`, `input[name="email"]`

**Pros:** Readable, self-documenting
**Cons:** May change if page structure changes

### aria
Elements are referenced by stable ARIA IDs.
- Format: `aria-<id>`
- Example: `aria-123`, `aria-456`

**Pros:** Stable across multiple snapshots
**Cons:** Less readable, requires initial snapshot

**Use aria when:**
- Performing multi-step workflows
- Need stable references across multiple act calls
- Page structure is dynamic

## Response Format

Most actions return a JSON response with:
- `status`: "ok" or "error"
- `data`: Action-specific data
- `error`: Error message (if failed)

Snapshot returns:
- `elements`: Array of page elements with refs
- `targetId`: Current tab ID
- `url`: Current page URL

## Common Workflows

### Simple Navigation
```
1. browser action="open" targetUrl="https://example.com"
2. browser action="screenshot"  → capture page
```

### Form Automation
```
1. browser action="open" targetUrl="https://example.com/form"
2. browser action="snapshot" refs="aria"  → get stable refs
3. browser action="act" request='{"kind":"fill","fields":...}' targetId="<tab-id>"
4. browser action="act" request='{"kind":"click","ref":"..."}' targetId="<tab-id>"
```

### Multi-Page Workflow
```
1. Open page and snapshot
2. Extract data from snapshot
3. Navigate to next page
4. Repeat
```
