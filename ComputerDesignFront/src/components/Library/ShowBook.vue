<template>
  <div class="book-detail-page">
    <!-- 主内容区 -->
    <main class="book-main">
      <div class="book-container">
        <!-- 加载状态 -->
        <div v-if="loading" class="loading-state">
          <div class="spinner"></div>
          <p>正在加载书籍信息...</p>
        </div>

        <!-- 错误提示 -->
        <div v-if="error" class="error-state">
          <svg class="error-icon" viewBox="0 0 24 24">
            <path
              d="M11 15h2v2h-2zm0-8h2v6h-2zm.99-5C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"
            />
          </svg>
          <p>{{ error }}</p>
          <button class="btn btn-primary" @click="fetchBook">重新加载</button>
        </div>

        <!-- 书籍详情 -->
        <div v-if="book" class="book-detail-card">
          <!-- 返回按钮 -->
          <button class="back-btn" @click="goBack">
            <svg class="back-icon" viewBox="0 0 24 24">
              <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
            </svg>
            返回书库
          </button>

          <div class="book-content">
            <div class="book-cover">
              <img
                v-if="book.coverUrl"
                :src="book.coverUrl"
                :alt="book.title"
                @error="handleImageError"
                class="cover-image"
              />
              <div v-else class="no-cover">
                <svg class="no-cover-icon" viewBox="0 0 24 24">
                  <path
                    d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"
                  />
                </svg>
                <span>暂无封面</span>
              </div>
            </div>

            <div class="book-info">
              <h1 class="book-title">{{ book.title }}</h1>
              <div class="book-subtitle">中医经典著作</div>

              <div class="info-grid">
                <div class="info-item" v-for="(item, index) in infoItems" :key="index">
                  <span class="info-label">{{ item.label }}</span>
                  <span class="info-value">{{ item.value }}</span>
                </div>
              </div>

              <div class="action-buttons">
                <button
                  class="btn btn-primary btn-large"
                  @click="handleDownload"
                  :disabled="downloadLoading"
                >
                  <svg class="btn-icon" viewBox="0 0 24 24" v-if="!downloadLoading">
                    <path d="M19 9h-4V3H9v6H5l7 7 7-7zM5 18v2h14v-2H5z" />
                  </svg>
                  <svg class="btn-spinner" viewBox="0 0 50 50" v-else>
                    <circle cx="25" cy="25" r="20" fill="none" stroke-width="5"></circle>
                  </svg>
                  {{ downloadLoading ? '下载中...' : '下载书籍' }}
                </button>
                <button class="btn btn-outline btn-large" @click="handleView">
                  <svg class="btn-icon" viewBox="0 0 24 24">
                    <path
                      d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"
                    />
                  </svg>
                  在线查看
                </button>
                <button class="btn btn-tupu btn-large" @click="handleDiagram">
                  <svg class="btn-icon" viewBox="0 0 24 24">
                    <path d="M21,7L9,19L3.5,13.5L4.91,12.09L9,16.17L19.59,5.59L21,7Z" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  </svg>
                  知识图谱
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>

    <!-- 页脚 -->
    <footer class="page-footer">
      <div class="footer-container">
        <p>© 2025 中医针灸学习平台 - 计算机设计大赛参赛作品</p>
        <p>
          联系我们:
          <a href="mailto:2015870900@qq.com">2015870900@qq.com</a>
        </p>
      </div>
    </footer>

    <el-dialog
      title="知识图谱"
      v-model="tupuVisible"
      height="400px"
      :fullscreen="true"
      center
      width="80%">
      <el-image :src="imageUrl" fit="fill"
      style="width: 68%; height: auto;margin-left: 200px;"
      />
      <!-- <template #footer>
        <div class="dialog-footer">
          <el-button @click="tupuVisible = false">关闭</el-button>
        </div>
      </template> -->
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const router = useRouter()

const tupuVisible = ref(false)  
const imageUrl = ref('images/1750921731213.jpg')

// 组件参数
const props = defineProps({
  bookId: {
    type: [Number, String],
    required: true,
  },
})

// 响应式状态
const book = ref(null)
const loading = ref(false)
const downloadLoading = ref(false)
const error = ref(null)
const infoItems = ref([])

// API 配置
const API_BASE = import.meta.env.VITE_API_URL
const getBookUrl = (id) => `/api/books/${id}`

// 返回上一页
const goBack = () => {
  router.go(-1)
}

// 获取书籍详情
const fetchBook = async () => {
  loading.value = true
  error.value = null

  try {
    const response = await axios.get(getBookUrl(props.bookId), {
      headers: {
        Accept: 'application/json',
      },
    })

    // 映射API字段到本地数据结构
    book.value = {
      id: response.data.id,
      title: response.data.title || '无标题',
      author: response.data.author || '未知作者',
      publisher: response.data.publisher || '未知出版社',
      language: response.data.language || '中文',
      fileType:
        response.data.fileType ||
        (response.data.fileUrl ? response.data.fileUrl.split('.').pop() : '未知'),
      fileUrl: response.data.fileUrl || response.data.filePath,
      coverUrl: response.data.coverUrl || response.data.coverPath,
      fileSize: response.data.fileSize || 0,
      createdAt: response.data.createdAt || response.data.uploadTime,
    }

    setInfoItems()
  } catch (err) {
    error.value = `加载失败: ${err.message}`
    console.error('获取书籍错误:', err)
  } finally {
    loading.value = false
  }
}

// 设置展示信息项
const setInfoItems = () => {
  infoItems.value = [
    { label: '作者', value: book.value.author },
    { label: '出版社', value: book.value.publisher },
    { label: '语言', value: book.value.language },
    { label: '文件格式', value: (book.value.fileType || '').toUpperCase() },
    { label: '上传时间', value: formatDate(book.value.createdAt) },
    { label: '文件大小', value: formatFileSize(book.value.fileSize) },
  ].filter((item) => item.value && item.value !== '未知')
}

// 下载书籍
const handleDownload = async () => {
  if (!book.value?.fileUrl) {
    alert('该书籍暂无下载链接')
    return
  }

  downloadLoading.value = true

  try {
    const fileUrl = book.value.fileUrl.startsWith('http')
      ? book.value.fileUrl
      : `${book.value.fileUrl}`

    const response = await axios.get(fileUrl, {
      responseType: 'blob',
    })

    const url = window.URL.createObjectURL(new Blob([response.data]))
    const link = document.createElement('a')
    link.href = url
    link.setAttribute(
      'download',
      `${book.value.title}.${book.value.fileType?.toLowerCase() || 'pdf'}`,
    )
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)
    window.URL.revokeObjectURL(url)
  } catch (err) {
    alert(`下载失败: ${err.message}`)
    console.error('下载错误:', err)
  } finally {
    downloadLoading.value = false
  }
}

// 查看书籍
const handleView = async () => {
  try {
    if (!book.value?.fileUrl) {
      alert('该书籍暂无查看链接')
      return
    }

    const fileUrl = book.value.fileUrl.startsWith('http')
      ? book.value.fileUrl
      : `${book.value.fileUrl}`

    const fileExt = (book.value.fileType || fileUrl.split('.').pop() || '').toLowerCase()

    if (fileExt === 'pdf') {
      const response = await axios.get(fileUrl, {
        responseType: 'blob',
      })
      const blobUrl = URL.createObjectURL(response.data)
      window.open(blobUrl, '_blank')
      setTimeout(() => URL.revokeObjectURL(blobUrl), 1000)
    } else {
      if (confirm(`无法预览 ${fileExt.toUpperCase()} 格式文件，是否下载？`)) {
        handleDownload()
      }
    }
  } catch (err) {
    console.error('查看失败:', err)
    alert('文件预览失败，尝试下载')
    handleDownload()
  }
}
// 生成知识图谱
const handleDiagram = () => {
  tupuVisible.value = true
}

// 图片加载失败处理
const handleImageError = () => {
  if (book.value) {
    book.value.coverUrl = null
  }
}

// 日期格式化
const formatDate = (dateString) => {
  if (!dateString) return '未知'
  try {
    const date = new Date(dateString)
    return date.toLocaleDateString('zh-CN', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
    })
  } catch {
    return '未知'
  }
}

// 文件大小格式化
const formatFileSize = (bytes) => {
  if (!bytes || isNaN(bytes)) return '未知'
  if (bytes < 1024) return `${bytes} B`
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`
  return `${(bytes / (1024 * 1024)).toFixed(1)} MB`
}

// 生命周期钩子
onMounted(() => {
  fetchBook()
})

// 监听bookId变化
watch(
  () => props.bookId,
  (newVal) => {
    if (newVal) {
      fetchBook()
    }
  },
)
</script>

<style scoped>
/* 基础样式 */
.book-detail-page {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f8f9fa;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
  line-height: 1.6;
  color: #213547;
}

/* 主内容区 */
.book-main {
  flex: 1;
  padding: 2rem 0;
}

.book-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1.5rem;
}

/* 返回按钮 */
.back-btn {
  display: inline-flex;
  align-items: center;
  background: none;
  border: none;
  color: #3c8772;
  padding: 0.5rem 1rem;
  margin-bottom: 1.5rem;
  cursor: pointer;
  font-size: 0.9rem;
  transition: color 0.2s;
}

.back-btn:hover {
  color: #2c6e5d;
}

.back-icon {
  width: 1.25rem;
  height: 1.25rem;
  margin-right: 0.5rem;
  fill: currentColor;
}

/* 书籍卡片 */
.book-detail-card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
  padding: 2.5rem;
  margin-top: 1rem;
}

.book-content {
  display: flex;
  gap: 3rem;
}

/* 书籍封面 */
.book-cover {
  flex: 0 0 300px;
}

.cover-image {
  width: 100%;
  height: auto;
  border-radius: 8px;
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
  transition: transform 0.3s ease;
}

.cover-image:hover {
  transform: translateY(-5px) scale(1.02);
}

.no-cover {
  height: 400px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: #f5f5f5;
  border-radius: 8px;
  color: #666;
}

.no-cover-icon {
  width: 4rem;
  height: 4rem;
  margin-bottom: 1rem;
  fill: #ccc;
}

/* 书籍信息 */
.book-info {
  flex: 1;
}

.book-title {
  font-size: 2rem;
  margin: 0 0 0.5rem;
  color: #2c3e50;
  font-weight: 600;
  line-height: 1.2;
}

.book-subtitle {
  font-size: 1rem;
  color: #666;
  margin-bottom: 2rem;
  font-style: italic;
}

/* 信息网格 */
.info-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.info-item {
  padding-bottom: 1rem;
  border-bottom: 1px solid #eee;
}

.info-label {
  display: block;
  font-size: 0.85rem;
  color: #666;
  margin-bottom: 0.5rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.info-value {
  display: block;
  font-size: 1.1rem;
  color: #2c3e50;
  font-weight: 500;
}

/* 按钮样式 */
.action-buttons {
  display: flex;
  gap: 1rem;
  margin-top: 2rem;
}

.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.75rem 1.5rem;
  border-radius: 6px;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
  border: 1px solid transparent;
}

.btn-primary {
  background-color: #3c8772;
  color: white;
}

.btn-primary:hover {
  background-color: #2c6e5d;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(60, 135, 114, 0.3);
}

.btn-outline {
  background-color: transparent;
  border-color: #3c8772;
  color: #3c8772;
}

.btn-outline:hover {
  background-color: rgba(60, 135, 114, 0.08);
  transform: translateY(-2px);
}

.btn-tupu{
  background-color: #9cac76;
  border-color: #859c96;
  color: white;
}
.btn-tupu:hover{
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(60, 135, 114, 0.3);
}

.btn-large {
  padding: 0.875rem 1.75rem;
  font-size: 1.05rem;
}

.btn-icon {
  width: 1.25rem;
  height: 1.25rem;
  margin-right: 0.5rem;
  fill: currentColor;
}

.btn-spinner {
  width: 1.25rem;
  height: 1.25rem;
  margin-right: 0.5rem;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

/* 加载状态 */
.loading-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 3rem 0;
}

.spinner {
  width: 3rem;
  height: 3rem;
  border: 4px solid rgba(60, 135, 114, 0.1);
  border-top-color: #3c8772;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 1rem;
}

/* 错误提示 */
.error-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 3rem 0;
  text-align: center;
}

.error-icon {
  width: 3rem;
  height: 3rem;
  fill: #f44336;
  margin-bottom: 1rem;
}

/* 页脚 */
.page-footer {
  padding: 2rem 0;
  border-top: 1px solid rgba(60, 60, 67, 0.12);
  text-align: center;
  font-size: 14px;
  color: rgba(60, 60, 67, 0.7);
  margin-top: auto;
}

.footer-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1.5rem;
}

.page-footer a {
  color: #3c8772;
  text-decoration: none;
}

.page-footer a:hover {
  text-decoration: underline;
}

/* 响应式设计 */
@media (max-width: 960px) {
  .book-content {
    flex-direction: column;
    gap: 2rem;
  }

  .book-cover {
    flex: none;
    margin: 0 auto;
    max-width: 300px;
  }

  .book-detail-card {
    padding: 1.5rem;
  }
}

@media (max-width: 640px) {
  .info-grid {
    grid-template-columns: 1fr;
  }

  .action-buttons {
    flex-direction: column;
  }

  .book-title {
    font-size: 1.5rem;
  }
}
</style>
