# 静态文件快速上传 - 操作指南

## 🎯 目标
快速上传 `~/Documents/web.zip` 到 `/console/mall` 路径

## 🚀 快速操作步骤

### 方法1：直接 URL（最快）

在浏览器地址栏输入：
```
http://10.151.92.33/console/mall/web/mall/system/staticFile?rootPath=html&filePath=/console/mall
```

然后点击"导入"按钮即可！

### 方法2：自动化脚本

运行快速脚本：
```bash
~/clawd/scripts/quick-upload.sh
```

### 方法3：浏览器自动化

让我执行以下操作序列（快速版）：

```javascript
// 快速操作序列
1. navigate → 静态文件页面
2. click → 文件路径输入框
3. type → /console/mall
4. click → 搜索按钮
5. click → 导入按钮
6. [等待] 你手动选择文件上传
```

## 📋 关键元素引用（快速版本）

| 操作 | 元素引用 |
|------|---------|
| 文件路径输入框 | `textbox[name="文件路径"]` 或动态 ref |
| 搜索按钮 | `button[name="搜索"]` |
| 导入按钮 | `button[name="导入"]` |
| 上传对话框 | 自动识别 |
| 确定按钮 | `button[name="确定"]` |

## ⚡ 性能优化建议

1. **减少拍照次数** - 只在关键时刻确认状态
2. **批量操作** - 连续执行 click/type 操作
3. **使用 URL 参数** - 直接带参数打开页面，跳过输入步骤
4. **缓存元素引用** - 页面结构不变时，复用 ref

## 🔧 故障排查

**浏览器服务超时**：
- 检查 OpenClaw 扩展是否显示 "ON"
- 刷新页面重新连接
- 重启 OpenClaw gateway

**找不到元素**：
- 页面可能跳转或重新加载
- 重新拍 snapshot 获取新的 ref

## 💡 完全自动化方案（未来）

如果需要完全自动化，可以在项目代码中添加：

```javascript
// 开发环境快捷上传（仅开发环境）
if (import.meta.env.DEV) {
  window.devUpload = (filePath) => {
    fetch('/api/upload', {
      method: 'POST',
      body: JSON.stringify({ filePath, targetPath: '/console/mall' })
    })
  }
}
```

然后通过 `evaluate` 直接调用：
```javascript
window.devUpload('/Users/bryle/Documents/web.zip')
```

---

**创建时间**: 2026-02-06
**最后更新**: 2026-02-06
**状态**: ✅ 可用
