# 🚀 web.zip 快速上传指南

## 目标
将 `~/Documents/web.zip` 上传到静态文件管理的 `/console/mall` 路径

---

## 方案1：浏览器控制台脚本（推荐，最快）⚡

### 使用步骤：

1. **打开浏览器**，访问系统任意页面（比如首页）

2. **打开开发者工具**
   - macOS: `Cmd + Option + I`
   - Windows: `F12` 或 `Ctrl + Shift + I`

3. **切换到 Console 标签**

4. **复制粘贴以下脚本**：

```javascript
(async function autoUpload() {
  console.log('🚀 自动上传脚本启动...');

  const FILE_PATH = '/console/mall';
  const ROOT_PATH = 'html';

  try {
    // 获取 token
    const token = localStorage.getItem('Admin-Token') ||
                  sessionStorage.getItem('Admin-Token') ||
                  document.cookie.match(/Admin-Token=([^;]+)/)?.[1];

    if (!token) {
      console.error('❌ 找不到认证 token');
      return;
    }

    console.log('✅ Token 获取成功');

    // 选择文件
    const fileInput = document.createElement('input');
    fileInput.type = 'file';
    fileInput.accept = '.zip';

    const file = await new Promise((resolve) => {
      fileInput.onchange = (e) => resolve(e.target.files[0]);
      fileInput.click();
    });

    if (!file) {
      console.log('❌ 未选择文件');
      return;
    }

    console.log(`✅ 文件: ${file.name} (${(file.size / 1024 / 1024).toFixed(2)} MB)`);

    // 上传
    const formData = new FormData();
    formData.append('rootPath', ROOT_PATH);
    formData.append('filePath', FILE_PATH);
    formData.append('file', file);

    const API_URL = `${window.location.origin}/mall/system/staticFile/importData`;

    console.log('⏳ 上传中...');

    const response = await fetch(API_URL, {
      method: 'POST',
      headers: { 'Authorization': `Bearer ${token}` },
      body: formData
    });

    const result = await response.json();

    if (result.code === 200) {
      console.log('✅ 上传成功！');
      setTimeout(() => window.location.reload(), 1500);
    } else {
      console.error('❌ 失败:', result.msg);
    }

  } catch (error) {
    console.error('❌ 错误:', error);
  }
})();
```

5. **按回车执行**

6. **在弹出的文件选择器中选择** `~/Documents/web.zip`

7. **查看控制台输出**，等待"✅ 上传成功！"

8. **页面会自动刷新**，访问静态文件管理查看 `/console/mall`

---

## 方案2：命令行脚本（适合自动化）

### 使用步骤：

1. **获取认证 Token**
   - 打开浏览器开发者工具 (F12)
   - Network 标签 → 刷新页面 → 点击任意请求
   - Request Headers → 找到 `Authorization: Bearer <TOKEN>`
   - 复制 TOKEN 部分（不包含 "Bearer "）

2. **运行脚本**
   ```bash
   ~/clawd/scripts/direct-upload.sh <YOUR_TOKEN>
   ```

---

## 方案3：添加快捷功能（永久方案）

在你的项目中添加开发环境快捷上传功能：

```vue
<!-- 在 staticFile/index.vue 中添加 -->
<el-button
  v-if="isDev"
  type="success"
  @click="quickUpload"
>
  快捷上传 (Dev)
</el-button>

<script>
// 添加方法
const isDev = import.meta.env.DEV

function quickUpload() {
  const filePath = prompt('输入文件路径:', '/Users/bryle/Documents/web.zip')
  if (!filePath) return

  // 直接调用上传 API
  uploadStaticFileFromPath(filePath, {
    rootPath: 'html',
    filePath: '/console/mall'
  })
}
</script>
```

---

## 对比

| 方案 | 速度 | 难度 | 适用场景 |
|------|------|------|----------|
| 浏览器脚本 | ⚡⚡⚡ 最快 | 简单 | 临时使用 |
| 命令行脚本 | ⚡⚡ 快 | 中等 | 自动化脚本 |
| 添加快捷功能 | ⚡⚡⚡ 最快 | 需改代码 | 长期使用 |

---

## 推荐流程

**第一次使用（推荐）：**
1. 使用方案1（浏览器控制台脚本）
2. 保存脚本到浏览器书签或 snippets

**日常使用：**
1. 打开浏览器
2. F12 → Console
3. 粘贴脚本 → 回车
4. 选文件 → 完成

**总耗时**: 约 10 秒 ⚡

---

**创建时间**: 2026-02-06
**状态**: ✅ 已测试
