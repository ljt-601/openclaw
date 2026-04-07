<!-- 复制到你的项目中: /views/mall/system/staticFile/index.vue -->

<!-- 在"导入"按钮旁边添加这个按钮 -->
<el-button
  v-if="isDev"
  type="success"
  plain
  icon="Upload"
  @click="quickUpload"
  v-hasPermi="['mall:system:staticFile:import']"
>
  快捷上传
</el-button>

<!-- 在 script setup 部分添加： -->
<script setup name="StaticFile">
// ... 其他代码 ...

// 添加快捷上传功能
const isDev = import.meta.env.DEV  // 仅开发环境显示

function quickUpload() {
  proxy.$modal.prompt('请输入要上传的 zip 文件路径:', '快捷上传', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    inputValue: '/Users/bryle/Documents/web.zip',
    inputPattern: /.+\.zip$/,
    inputErrorMessage: '请输入 zip 文件路径'
  }).then(({ value }) => {
    const filePath = value

    // 显示确认对话框
    proxy.$modal.confirm(
      `确认上传文件到路径：<br/><strong>${filePath}</strong><br/><br/>目标位置：<strong>/console/mall</strong>`,
      '确认上传',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        dangerouslyUseHTMLString: true,
        type: 'warning'
      }
    ).then(() => {
      // 调用后端接口直接上传（需要后端支持）
      // 或者读取文件后通过 el-upload 上传
      uploadFromPath(filePath)
    }).catch(() => {})
  }).catch(() => {})
}

// 从文件路径上传（需要实现文件读取）
async function uploadFromPath(filePath) {
  try {
    proxy.$modal.loading('正在读取文件...')

    // 方案：使用 File API 读取本地文件
    // 注意：这需要用户通过文件选择器授权

    // 临时方案：弹出文件选择器
    const fileInput = document.createElement('input')
    fileInput.type = 'file'
    fileInput.accept = '.zip'

    fileInput.onchange = async (e) => {
      const file = e.target.files[0]
      if (!file) return

      proxy.$modal.closeLoading()

      // 使用现有的上传逻辑
      const uploadComponent = proxy.$refs.uploadRef

      // 手动触发上传
      const fileList = [{
        name: file.name,
        percentage: 0,
        status: 'ready',
        size: file.size,
        raw: file
      }]

      // 设置到上传组件
      uploadComponent.uploadFiles = fileList
      uploadComponent.handleStart(file)

      // 打开上传对话框
      upload.open = true
      upload.title = '快捷上传'

      proxy.$modal.msgSuccess('文件已添加，请点击"确定"开始上传')
    }

    fileInput.click()

  } catch (error) {
    proxy.$modal.closeLoading()
    proxy.$modal.msgError('操作失败: ' + error.message)
  }
}
</script>
