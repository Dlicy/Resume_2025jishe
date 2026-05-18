<template>
  <div class="form-container">
    <div class="book-form">
      <div class="form-grid">
        <!-- Text Inputs -->
        <div class="form-group">
          <label for="book-title">书籍名称</label>
          <input
            id="book-title"
            v-model="newBook.title"
            type="text"
            placeholder="请输入书籍名称"
            required
            class="form-input"
          />
        </div>

        <div class="form-group">
          <label for="book-author">作者名称</label>
          <input
            id="book-author"
            v-model="newBook.author"
            type="text"
            placeholder="请输入作者名称"
            required
            class="form-input"
          />
        </div>

        <div class="form-group">
          <label for="book-publisher">出版社</label>
          <input
            id="book-publisher"
            v-model="newBook.publisher"
            type="text"
            placeholder="请输入出版社"
            required
            class="form-input"
          />
        </div>

        <div class="form-group">
          <label for="book-language">语言</label>
          <input
            id="book-language"
            v-model="newBook.language"
            type="text"
            placeholder="请输入语言"
            required
            class="form-input"
          />
        </div>

        <!-- File Uploads -->
        <div class="form-group file-upload-group">
          <label for="file-upload">书籍文件</label>
          <div class="file-upload-wrapper">
            <label for="file-upload" class="file-upload-label">
              <span v-if="!bookFile" class="file-placeholder">
                <svg class="upload-icon" viewBox="0 0 24 24">
                  <path
                    d="M19 13a1 1 0 0 0-1 1v.38l-1.48-1.48a2.79 2.79 0 0 0-3.93 0l-.7.7-2.48-2.48a2.85 2.85 0 0 0-3.93 0L4 12.6V7a1 1 0 0 1 1-1h7a1 1 0 1 0 0-2H5a3 3 0 0 0-3 3v12a3 3 0 0 0 3 3h12a3 3 0 0 0 3-3v-5a1 1 0 0 0-1-1zM5 20a1 1 0 0 1-1-1v-3.57l2.9-2.9a.79.79 0 0 1 1.09 0l3.17 3.17 4.3 4.3zm13-1a1 1 0 0 1-.18.53L13.31 15l.7-.7a.77.77 0 0 1 1.1 0L18 17.21z"
                  />
                  <path
                    d="M8 10a1.5 1.5 0 1 0-1.5-1.5A1.5 1.5 0 0 0 8 10zm13-5h-3a1 1 0 1 0 0 2h3a1 1 0 0 1 1 1v3a1 1 0 0 0 2 0V7a3 3 0 0 0-3-3z"
                  />
                </svg>
                <span>选择文件</span>
              </span>
              <span v-else class="file-name">{{ bookFile.name }}</span>
              <input
                type="file"
                id="file-upload"
                @change="handleFileUpload($event, 'book')"
                accept=".pdf,.docx"
                required
              />
            </label>
            <span class="file-hint">支持PDF, DOCX格式，最大500MB</span>
          </div>
        </div>

        <div class="form-group file-upload-group">
          <label for="cover-upload">书籍封面</label>
          <div class="file-upload-wrapper">
            <label for="cover-upload" class="file-upload-label">
              <span v-if="!coverImage" class="file-placeholder">
                <svg class="upload-icon" viewBox="0 0 24 24">
                  <path
                    d="M19 13a1 1 0 0 0-1 1v.38l-1.48-1.48a2.79 2.79 0 0 0-3.93 0l-.7.7-2.48-2.48a2.85 2.85 0 0 0-3.93 0L4 12.6V7a1 1 0 0 1 1-1h7a1 1 0 1 0 0-2H5a3 3 0 0 0-3 3v12a3 3 0 0 0 3 3h12a3 3 0 0 0 3-3v-5a1 1 0 0 0-1-1zM5 20a1 1 0 0 1-1-1v-3.57l2.9-2.9a.79.79 0 0 1 1.09 0l3.17 3.17 4.3 4.3zm13-1a1 1 0 0 1-.18.53L13.31 15l.7-.7a.77.77 0 0 1 1.1 0L18 17.21z"
                  />
                  <path
                    d="M8 10a1.5 1.5 0 1 0-1.5-1.5A1.5 1.5 0 0 0 8 10zm13-5h-3a1 1 0 1 0 0 2h3a1 1 0 0 1 1 1v3a1 1 0 0 0 2 0V7a3 3 0 0 0-3-3z"
                  />
                </svg>
                <span>选择图片</span>
              </span>
              <span v-else class="file-name">{{ coverImage.name }}</span>
              <input
                type="file"
                id="cover-upload"
                @change="handleFileUpload($event, 'cover')"
                accept="image/jpeg,image/png"
                required
              />
            </label>
            <span class="file-hint">支持JPG, PNG格式，最大500MB</span>
          </div>
        </div>
      </div>

      <!-- 按钮容器 -->
      <div class="button-container">
        <button type="button" class="submit-button" @click="addBook">
          <span>添加书籍</span>
          <svg
            class="button-icon"
            xmlns="http://www.w3.org/2000/svg"
            width="16"
            height="16"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          >
            <line x1="12" y1="5" x2="12" y2="19"></line>
            <line x1="5" y1="12" x2="19" y2="12"></line>
          </svg>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Element } from 'chart.js'
import { ref, computed, onMounted, watch } from 'vue'
import { ElMessage } from 'element-plus'
import axios from 'axios'

interface Book {
  id: number
  title: string
  author: string
  publisher: string
  language: string
  fileType?: string
  rating?: number
  fileUrl?: string
  coverUrl?: string
}

// Reactive data
const books = ref<Book[]>([])
const newBook = ref({
  title: '',
  author: '',
  publisher: '',
  language: '',
})
const bookFile = ref<File | null>(null)
const coverImage = ref<File | null>(null)
const searchQuery = ref('')
const currentPage = ref(1)
const itemsPerPage = 10
const isLoading = ref(false)
const errorMessage = ref('')
const isEditModalOpen = ref(false)
const currentEditBook = ref<Book | null>(null)
const editBookFile = ref<File | null>(null)
const editCoverImage = ref<File | null>(null)

// API configuration
const API_BASE = import.meta.env.VITE_API_URL
const API_ENDPOINTS = {
  GET_BOOKS: `/api/books`,
  ADD_BOOK: `/api/books`,
  DELETE_BOOK: (id: number) => `/api/books/${id}`,
  DOWNLOAD_BOOK: (id: number) => `/api/books/${id}/download`,
}

const fetchBooks = async () => {
  isLoading.value = true
  errorMessage.value = ''
  try {
    const response = await axios.get(API_ENDPOINTS.ADD_BOOK)

    // axios 会自动处理响应数据，不需要手动调用 .json()
    const data = response.data
    // 重点修改：提取 content 字段
    books.value = data.content || [] // 确保始终是数组

    console.log('Fetched books:', books.value)
  } catch (error) {
    errorMessage.value = '获取书籍列表失败，请稍后重试'
    console.error('Error fetching books:', error)
    books.value = [] // 失败时重置为空数组
  } finally {
    isLoading.value = false
  }
}

// Add new book to backend
const addBook = async () => {
  if (!validateForm()) return

  isLoading.value = true
  errorMessage.value = ''

  const formData = new FormData()
  formData.append('title', newBook.value.title)
  formData.append('author', newBook.value.author)
  formData.append('publisher', newBook.value.publisher)
  formData.append('language', newBook.value.language)
  if (bookFile.value) formData.append('bookFile', bookFile.value)
  if (coverImage.value) formData.append('coverImage', coverImage.value)

  try {
    // 使用 axios 发送 FormData
    const response = await axios.post('/api/books', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    })

    await fetchBooks() // Refresh the list
    resetForm()
    ElMessage.success('书籍添加成功！')
  } catch (error) {
    errorMessage.value = error.response?.data?.message || '添加书籍失败'
    ElMessage.error('书籍添加失败！')
  } finally {
    isLoading.value = false
  }
}

// 重置页码当搜索条件变化时
watch(searchQuery, () => {
  currentPage.value = 1 // 搜索时回到第一页
})

// Handle file upload
const handleFileUpload = (event: Event, type: 'book' | 'cover') => {
  const input = event.target as HTMLInputElement
  if (!input.files?.length) return

  const file = input.files[0]
  const maxSize = type === 'book' ? 500 * 1024 * 1024 : 500 * 1024 * 1024 // 500MB for book, 500MB for cover

  if (file.size > maxSize) {
    errorMessage.value = `${type === 'book' ? '书籍文件' : '封面图片'}大小不能超过${maxSize / 1024 / 1024}MB`
    input.value = ''
    return
  }

  if (type === 'book') {
    bookFile.value = file
  } else {
    coverImage.value = file
  }
  errorMessage.value = ''
}

// Clear uploaded file
const clearFile = (type: 'book' | 'cover') => {
  if (type === 'book') {
    bookFile.value = null
    const input = document.getElementById('file-upload') as HTMLInputElement
    if (input) input.value = ''
  } else {
    coverImage.value = null
    const input = document.getElementById('cover-upload') as HTMLInputElement
    if (input) input.value = ''
  }
}

// Form validation
const validateForm = (): boolean => {
  if (!newBook.value.title.trim()) {
    errorMessage.value = '请输入书籍名称'
    return false
  }
  if (!newBook.value.author.trim()) {
    errorMessage.value = '请输入作者名称'
    return false
  }
  if (!bookFile.value) {
    errorMessage.value = '请上传书籍文件'
    return false
  }
  return true
}

// Reset form
const resetForm = () => {
  newBook.value = { title: '', author: '', publisher: '', language: '' }
  clearFile('book')
  clearFile('cover')
}

// Initialize component
onMounted(() => {
  fetchBooks()
})
</script>

<style scoped>
/* 基础样式 */
.form-container {
  box-sizing: border-box;
  font-family:
    'Inter',
    -apple-system,
    BlinkMacSystemFont,
    'Segoe UI',
    Roboto,
    Oxygen,
    Ubuntu,
    Cantarell,
    sans-serif;
  color: #2d3748;
  font-size: 1rem;
  line-height: 1.6;
  padding: 2rem;
  background-color: #f8fafc;
  min-height: 100vh;
}

/* 表单容器 */
.book-form {
  max-width: 900px;
  margin: 0 auto;
  padding: 2.5rem;
  background: white;
  border-radius: 16px;
  box-shadow:
    0 10px 25px -5px rgba(0, 0, 0, 0.05),
    0 5px 10px -5px rgba(0, 0, 0, 0.02);
}

/* 表单网格布局 */
.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 1.75rem;
  margin-bottom: 2.5rem;
}

/* 表单组样式 */
.form-group {
  margin-bottom: 0;
  padding: 1.25rem; /* 减少内边距 */
  background: #ffffff;
  border-radius: 12px;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  border: 1px solid #edf2f7;
  box-sizing: border-box; /* 添加box-sizing */
}

.form-group:hover {
  border-color: #e2e8f0;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
}

.form-group label {
  display: block;
  margin-bottom: 0.75rem;
  font-weight: 500;
  color: #4a5568;
  font-size: 0.95rem;
  letter-spacing: 0.02em;
}

/* 输入框样式 */
.form-input {
  width: 100%;
  padding: 0.75rem 1rem; /* 调整padding */
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  font-size: 0.95rem;
  background: white;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  color: #4a5568;
  box-sizing: border-box; /* 关键修复：确保padding包含在宽度内 */
}

.form-input::placeholder {
  color: #a0aec0;
}

.form-input:hover {
  border-color: #cbd5e0;
}

.form-input:focus {
  border-color: #4299e1;
  box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
  outline: none;
}

/* 文件上传组 */
.file-upload-wrapper {
  margin-top: 0.5rem;
  position: relative;
}

.file-upload-label {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 1.5rem 1rem;
  background: #f8fafc;
  border: 2px dashed #e2e8f0;
  border-radius: 8px;
  text-align: center;
  cursor: pointer;
  transition: all 0.25s ease;
  min-height: 120px;
}

.file-upload-label:hover {
  background: #f0f5ff;
  border-color: #cbd5e0;
}

.file-upload-label input[type='file'] {
  display: none;
}

.file-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  color: #718096;
}

.upload-icon {
  width: 36px;
  height: 36px;
  margin-bottom: 0.75rem;
  fill: #cbd5e0;
  transition: fill 0.2s ease;
}

.file-upload-label:hover .upload-icon {
  fill: #a0aec0;
}

.file-name {
  display: block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-size: 0.95rem;
  color: #4a5568;
  padding: 0.5rem;
  background: #edf2f7;
  border-radius: 4px;
  width: 100%;
  text-align: center;
}

.file-hint {
  display: block;
  font-size: 0.85rem;
  color: #718096;
  margin-top: 0.75rem;
  text-align: center;
}

/* 按钮容器 */
.button-container {
  display: flex;
  justify-content: flex-end;
  padding: 1.5rem 0 0;
}

/* 提交按钮 */
.submit-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.9rem 2rem;
  background-color: #4299e1;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  letter-spacing: 0.02em;
  box-shadow: 0 4px 6px rgba(66, 153, 225, 0.15);
  position: relative;
  overflow: hidden;
}

.submit-button:hover {
  background-color: #3182ce;
  transform: translateY(-2px);
  box-shadow: 0 6px 12px rgba(66, 153, 225, 0.2);
}

.submit-button:active {
  transform: translateY(0);
}

.submit-button::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(255, 255, 255, 0.2);
  transform: scaleX(0);
  transform-origin: right;
  transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.submit-button:hover::after {
  transform: scaleX(1);
  transform-origin: left;
}

.button-icon {
  margin-left: 0.75rem;
  width: 18px;
  height: 18px;
  stroke-width: 2.5;
  transition: transform 0.2s ease;
}

.submit-button:hover .button-icon {
  transform: scale(1.1);
}

/* 响应式调整 */
@media (max-width: 768px) {
  .form-container {
    padding: 1.5rem;
  }

  .book-form {
    padding: 2rem;
  }

  .form-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }

  .form-group {
    padding: 1.25rem;
  }
}

@media (max-width: 480px) {
  .form-container {
    padding: 1rem;
  }

  .book-form {
    padding: 1.5rem;
  }

  .form-input,
  .file-upload-label {
    padding: 0.8rem;
  }

  .submit-button {
    width: 100%;
    padding: 0.9rem;
  }
}
</style>
