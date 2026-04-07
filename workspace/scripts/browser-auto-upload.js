// 在浏览器控制台运行此脚本 - 自动上传 web.zip
// 使用方法:
// 1. 打开浏览器开发者工具 (F12)
// 2. 切换到 Console 标签
// 3. 复制粘贴整个脚本并回车

(async function autoUpload() {
  console.log('🚀 自动上传脚本启动...');
  console.log('================================');

  // 配置
  const FILE_PATH = '/console/mall';
  const ROOT_PATH = 'html';

  try {
    // 1. 获取 token
    const token = localStorage.getItem('Admin-Token') ||
                  sessionStorage.getItem('Admin-Token') ||
                  document.cookie.match(/Admin-Token=([^;]+)/)?.[1];

    if (!token) {
      console.error('❌ 错误: 找不到认证 token');
      console.log('💡 请确保已登录系统');
      return;
    }

    console.log('✅ Token 获取成功');

    // 2. 读取文件（需要用户选择）
    console.log('📂 请选择 web.zip 文件...');
    const fileInput = document.createElement('input');
    fileInput.type = 'file';
    fileInput.accept = '.zip';

    const file = await new Promise((resolve) => {
      fileInput.onchange = (e) => resolve(e.target.files[0]);
      fileInput.click();
    });

    if (!file) {
      console.log('❌ 未选择文件，取消上传');
      return;
    }

    console.log(`✅ 文件已选择: ${file.name} (${(file.size / 1024 / 1024).toFixed(2)} MB)`);

    // 3. 准备上传
    const formData = new FormData();
    formData.append('rootPath', ROOT_PATH);
    formData.append('filePath', FILE_PATH);
    formData.append('file', file);

    const API_BASE = window.location.origin;
    const API_URL = `${API_BASE}/mall/system/staticFile/importData`;

    console.log('⏳ 开始上传...');

    // 4. 执行上传
    const response = await fetch(API_URL, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${token}`
      },
      body: formData
    });

    const result = await response.json();

    if (result.code === 200) {
      console.log('✅ 上传成功！');
      console.log('📄 结果:', result);
      console.log('🔄 刷新页面查看...');
      setTimeout(() => window.location.reload(), 1500);
    } else {
      console.error('❌ 上传失败:', result.msg);
    }

  } catch (error) {
    console.error('❌ 错误:', error);
  }

  console.log('================================');
  console.log('💡 提示: 刷新页面后访问 静态文件管理 查看 /console/mall');
})();
