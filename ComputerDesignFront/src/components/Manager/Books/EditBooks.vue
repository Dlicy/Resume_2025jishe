<template>
  <div class="book-management-container">
    <!-- 修改后的标题和搜索框部分 -->
    <div class="list-header">
      <h2 class="page-title">书籍管理</h2>
      <div class="search-box">
        <input
          v-model.trim="searchQuery"
          type="search"
          placeholder="输入书名、作者、出版社等..."
          @input="handleSearchInput"
          class="search-input"
        />
        <button @click="handleSearch" class="refresh-btn">
          <span class="search-icon">🔍</span> 搜索
        </button>
        <button @click="refreshList" class="refresh-btn">
          <span class="refresh-icon">↻</span> 刷新
        </button>
      </div>
    </div>
    <div v-if="searchQuery" class="search-status">
      <span class="search-results"
        >找到 {{ filteredBooks.length }} 条匹配 "{{ searchQuery }}" 的结果</span
      >
      <button v-if="filteredBooks.length === 0" @click="clearSearch" class="clear-search-link">
        清除搜索
      </button>
    </div>

    <div class="table-container">
      <table class="book-table">
        <thead>
          <tr>
            <th>书籍名称</th>
            <th>书籍类型</th>
            <th>作者</th>
            <th>出版社</th>
            <th>语言</th>
            <th>评分</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(book, index) in paginatedBooks"
            :key="book.id"
            :class="{ 'even-row': index % 2 === 0 }"
          >
            <td>{{ book.title }}</td>
            <td>{{ book.fileType || '未知' }}</td>
            <td>{{ book.author }}</td>
            <td>{{ book.publisher }}</td>
            <td>{{ book.language }}</td>
            <td>
              <span v-if="book.rating" class="rating-badge">{{ book.rating }}</span>
              <span v-else>-</span>
            </td>
            <td class="actions-cell">
              <button @click="openEditModal(book.id)" class="action-btn edit">
                <svg viewBox="0 0 24 24">
                  <path
                    d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"
                  />
                </svg>
                编辑
              </button>
              <button @click="deleteBook(book.id)" class="action-btn delete">
                <svg viewBox="0 0 24 24">
                  <path
                    d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"
                  />
                </svg>
                删除
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="pagination-container" v-if="totalPages > 1">
      <button
        v-for="page in totalPages"
        :key="page"
        @click="currentPage = page"
        :class="{ 'active-page': currentPage === page, 'page-btn': true }"
      >
        {{ page }}
      </button>
    </div>

    <!-- 编辑模态框 -->
    <div v-if="isEditModalOpen" class="modal-overlay" @click.self="closeEditModal">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title">编辑书籍</h3>
          <button @click="closeEditModal" class="modal-close-btn">
            <svg viewBox="0 0 24 24">
              <path
                d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"
              />
            </svg>
          </button>
        </div>

        <div class="form-grid">
          <div class="form-group">
            <label>书籍名称</label>
            <input
              v-model="currentEditBook.title"
              type="text"
              class="form-input"
              placeholder="请输入书籍名称"
            />
          </div>

          <div class="form-group">
            <label>作者</label>
            <input
              v-model="currentEditBook.author"
              type="text"
              class="form-input"
              placeholder="请输入作者"
            />
          </div>

          <div class="form-group">
            <label>出版社</label>
            <input
              v-model="currentEditBook.publisher"
              type="text"
              class="form-input"
              placeholder="请输入出版社"
            />
          </div>

          <div class="form-group">
            <label>语言</label>
            <input
              v-model="currentEditBook.language"
              type="text"
              class="form-input"
              placeholder="请输入语言"
            />
          </div>

          <div class="form-group file-upload-group">
            <label>更新书籍文件</label>
            <div class="file-upload-wrapper">
              <label class="file-upload-label">
                <span v-if="!editBookFile" class="file-placeholder">
                  <svg class="upload-icon" viewBox="0 0 24 24">
                    <path
                      d="M19 13v5c0 .55-.45 1-1 1H6c-.55 0-1-.45-1-1v-5c0-.55-.45-1-1-1s-1 .45-1 1v6c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2v-6c0-.55-.45-1-1-1s-1 .45-1 1zm-5-.33l1.88-1.88c.39-.39 1.02-.39 1.41 0 .39.39.39 1.02 0 1.41l-3.59 3.59c-.39.39-1.02.39-1.41 0L7.7 12.2c-.39-.39-.39-1.02 0-1.41.39-.39 1.02-.39 1.41 0L11 12.67V4c0-.55.45-1 1-1s1 .45 1 1v8.67z"
                    />
                  </svg>
                  <span>选择新文件</span>
                </span>
                <span v-else class="file-name">{{ editBookFile.name }}</span>
                <input
                  type="file"
                  @change="handleEditFileUpload($event, 'book')"
                  accept=".pdf,.docx"
                />
              </label>
              <small class="current-file" v-if="currentEditBook?.fileType"
                >当前: {{ currentEditBook.fileType }}</small
              >
            </div>
          </div>

          <div class="form-group file-upload-group">
            <label>更新封面图片</label>
            <div class="file-upload-wrapper">
              <label class="file-upload-label">
                <span v-if="!editCoverImage" class="file-placeholder">
                  <svg class="upload-icon" viewBox="0 0 24 24">
                    <path
                      d="M19 13v5c0 .55-.45 1-1 1H6c-.55 0-1-.45-1-1v-5c0-.55-.45-1-1-1s-1 .45-1 1v6c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2v-6c0-.55-.45-1-1-1s-1 .45-1 1zm-5-.33l1.88-1.88c.39-.39 1.02-.39 1.41 0 .39.39.39 1.02 0 1.41l-3.59 3.59c-.39.39-1.02.39-1.41 0L7.7 12.2c-.39-.39-.39-1.02 0-1.41.39-.39 1.02-.39 1.41 0L11 12.67V4c0-.55.45-1 1-1s1 .45 1 1v8.67z"
                    />
                  </svg>
                  <span>选择新封面</span>
                </span>
                <span v-else class="file-name">{{ editCoverImage.name }}</span>
                <input
                  type="file"
                  @change="handleEditFileUpload($event, 'cover')"
                  accept="image/*"
                />
              </label>
            </div>
          </div>
        </div>

        <div class="modal-footer">
          <button @click="closeEditModal" class="modal-btn cancel-btn">取消</button>
          <button @click="updateBook" class="modal-btn confirm-btn" :disabled="isLoading">
            <span v-if="isLoading" class="loading-spinner"></span>
            {{ isLoading ? '保存中...' : '保存更改' }}
          </button>
        </div>

        <div v-if="errorMessage" class="error-message">
          {{ errorMessage }}
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue'
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
    const response = await axios.get('/api/books')
    // 重点修改：提取 content 字段
    books.value = response.data.content || [] // 确保始终是数组
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
    await axios.post('/api/books', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    })
    await fetchBooks() // Refresh the list
    resetForm()
  } catch (error) {
    if (axios.isAxiosError(error)) {
      errorMessage.value = error.response?.data?.message || '添加书籍失败'
    } else {
      errorMessage.value = '添加书籍失败'
    }
    console.error('Error adding book:', error)
  } finally {
    isLoading.value = false
  }
}

// Delete book from backend
const deleteBook = async (id: number) => {
  if (!confirm('确定要删除这本书吗？此操作不可恢复。')) return

  isLoading.value = true
  try {
    await axios.delete(`/api/books/${id}`)
    await fetchBooks() // Refresh the list
  } catch (error) {
    errorMessage.value = '删除书籍失败'
    console.error('Error deleting book:', error)
  } finally {
    isLoading.value = false
  }
}

// 增强的模糊搜索函数
const fuzzySearch = (query: string, items: Book[]): Book[] => {
  if (!query.trim()) return items

  const searchTerm = query.toLowerCase()
  return items.filter((book) => {
    // 搜索所有可能字段（根据需要调整）
    const fieldsToSearch = [
      book.title,
      book.author,
      book.publisher,
      book.language,
      book.fileType || '',
    ]

    return fieldsToSearch.some((field) => field.toLowerCase().includes(searchTerm))
  })
}

const filteredBooks = computed(() => {
  const query = searchQuery.value.toLowerCase().trim()

  // 无搜索内容时返回全部书籍
  if (!query) return books.value

  // 有搜索内容时返回过滤结果
  return books.value.filter(
    (book) =>
      book.title.toLowerCase().includes(query) ||
      book.author.toLowerCase().includes(query) ||
      book.publisher.toLowerCase().includes(query) ||
      (book.language && book.language.toLowerCase().includes(query)),
  )
})

const paginatedBooks = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage
  return filteredBooks.value.slice(start, start + itemsPerPage)
})

const clearSearch = () => {
  searchQuery.value = '' // 清空搜索框会自动触发 filteredBooks 重新计算
  currentPage.value = 1 // 重置到第一页
}

// 计算属性：总页数
const totalPages = computed(() => {
  return Math.ceil(filteredBooks.value.length / itemsPerPage)
})

// 重置页码当搜索条件变化时
watch(searchQuery, () => {
  currentPage.value = 1 // 搜索时回到第一页
})

// Download book file
const downloadBook = (id: number) => {
  window.open(API_ENDPOINTS.DOWNLOAD_BOOK(id), '_blank')
}

// Edit book (placeholder - would open edit modal in real implementation)
const editBook = (id: number) => {
  const book = books.value.find((b) => b.id === id)
  if (book) {
    console.log('Editing book:', book)
    // In a real app, you would set up edit mode here
  }
}

// Handle file upload
const handleFileUpload = (event: Event, type: 'book' | 'cover') => {
  const input = event.target as HTMLInputElement
  if (!input.files?.length) return

  const file = input.files[0]
  const maxSize = type === 'book' ? 10 * 1024 * 1024 : 5 * 1024 * 1024 // 10MB for book, 5MB for cover

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

// 编辑方法
const openEditModal = (id: number) => {
  const book = books.value.find((b) => b.id === id)
  if (book) {
    currentEditBook.value = { ...book }
    isEditModalOpen.value = true
  }
}

const handleEditFileUpload = (event: Event, type: 'book' | 'cover') => {
  const input = event.target as HTMLInputElement
  if (input.files?.length) {
    const file = input.files[0]
    if (type === 'book') {
      editBookFile.value = file
    } else {
      editCoverImage.value = file
    }
  }
}
const updateBook = async () => {
  if (!currentEditBook.value) return

  isLoading.value = true
  errorMessage.value = ''

  const formData = new FormData()
  formData.append('title', currentEditBook.value.title)
  formData.append('author', currentEditBook.value.author)
  formData.append('publisher', currentEditBook.value.publisher)
  formData.append('language', currentEditBook.value.language)
  if (editBookFile.value) formData.append('bookFile', editBookFile.value)
  if (editCoverImage.value) formData.append('coverImage', editCoverImage.value)

  try {
    await axios.put(`/api/books/${currentEditBook.value.id}`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    })
    await fetchBooks() // 刷新列表
    closeEditModal()
  } catch (error) {
    if (axios.isAxiosError(error)) {
      errorMessage.value = error.response?.data?.message || '更新书籍失败'
    } else {
      errorMessage.value = '更新书籍失败'
    }
    console.error('Error updating book:', error)
  } finally {
    isLoading.value = false
  }
}

const closeEditModal = () => {
  isEditModalOpen.value = false
  currentEditBook.value = null
  editBookFile.value = null
  editCoverImage.value = null
}

// Initialize component
onMounted(() => {
  fetchBooks()
})
</script>

<style scoped>
/* 基础样式 */
.book-management-container {
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
  /* padding: 2rem; */
  padding: 24px;
  max-width: 1200px;
  margin: 0 auto;
}

.list-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  flex-wrap: wrap;
  gap: 16px;
}

/* 头部区域 */
.header-section {
  margin-bottom: 2rem;
}

/* 搜索区域 */
.search-container {
  margin-bottom: 1.5rem;
}

.search-wrapper {
  position: relative;
  max-width: 500px;
}

.search-icon,
.refresh-icon {
  font-size: 16px;
  position: absolute;
  left: 12px;
  top: 50%;
  transform: translateY(-50%);
  width: 18px;
  height: 18px;
  fill: #a0aec0;
}

.search-box {
  display: flex;
  gap: 12px;
}

.search-box:focus {
  outline: none;
  border-color: #4299e1;
  box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
  background-color: white;
}

.search-input {
  padding: 10px 16px;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  font-size: 14px;
  width: 300px;
  transition: all 0.2s;
}

.search-input:focus {
  border-color: #4299e1;
  box-shadow: 0 0 0 2px rgba(66, 153, 225, 0.2);
  outline: none;
}

.refresh-btn {
  padding: 10px 16px;
  background-color: #f8fafc;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
  display: flex;
  align-items: center;
  gap: 6px;
}

.refresh-btn:hover {
  background-color: #edf2f7;
}

.clear-search-btn {
  position: absolute;
  right: 12px;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  padding: 0;
  cursor: pointer;
}

.clear-search-btn svg {
  width: 18px;
  height: 18px;
  fill: #a0aec0;
  transition: fill 0.2s ease;
}

.clear-search-btn:hover svg {
  fill: #718096;
}

.search-status {
  display: flex;
  align-items: center;
  font-size: 0.9rem;
  color: #4a5568;
  margin-top: 1.5rem;
}

.search-results {
  font-weight: 500;
}

.clear-search-link {
  background: none;
  border: none;
  color: #4299e1;
  text-decoration: underline;
  cursor: pointer;
  margin-left: 0.5rem;
  font-size: 0.9rem;
  padding: 0;
}

.clear-search-link:hover {
  color: #3182ce;
}

/* 表格样式 */
.table-container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
  overflow: hidden;
}

.book-table {
  width: 100%;
  border-collapse: collapse;
}

.book-table th {
  background-color: #f7fafc;
  color: #4a5568;
  font-weight: 600;
  text-align: left;
  padding: 1rem 1.5rem;
  border-bottom: 1px solid #e2e8f0;
}

.book-table td {
  padding: 1rem 1.5rem;
  border-bottom: 1px solid #edf2f7;
  color: #4a5568;
}

.book-table tr:last-child td {
  border-bottom: none;
}

.book-table tr.even-row {
  background-color: #f8fafc;
}

.book-table tr:hover {
  background-color: #f0f5ff;
}

.rating-badge {
  display: inline-block;
  padding: 0.25rem 0.5rem;
  background-color: #e6fffa;
  color: #38b2ac;
  border-radius: 9999px;
  font-weight: 500;
  font-size: 0.85rem;
}

.actions-cell {
  display: flex;
  gap: 0.5rem;
}

.action-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.35rem;
  padding: 0.5rem 0.75rem;
  border-radius: 6px;
  font-size: 0.85rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
  border: none;
}

.action-btn svg {
  width: 16px;
  height: 16px;
}

.action-btn.edit {
  background-color: rgba(236, 201, 75, 0.1);
  color: #d69e2e;
}

.action-btn.edit:hover {
  background-color: rgba(236, 201, 75, 0.2);
}

.action-btn.delete {
  background-color: rgba(245, 101, 101, 0.1);
  color: #e53e3e;
}

.action-btn.delete:hover {
  background-color: rgba(245, 101, 101, 0.2);
}

/* 分页样式 */
.pagination-container {
  display: flex;
  justify-content: center;
  gap: 0.5rem;
  margin-top: 2rem;
}

.page-btn {
  padding: 0.5rem 0.9rem;
  border: 1px solid #e2e8f0;
  background-color: white;
  border-radius: 6px;
  color: #4a5568;
  cursor: pointer;
  transition: all 0.2s ease;
  font-size: 0.9rem;
}

.page-btn:hover {
  background-color: #f7fafc;
  border-color: #cbd5e0;
}

.active-page {
  background-color: #4299e1;
  border-color: #4299e1;
  color: white;
}

.active-page:hover {
  background-color: #3182ce;
  border-color: #3182ce;
}

/* 模态框样式 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
  backdrop-filter: blur(2px);
}

.modal-content {
  background: white;
  border-radius: 12px;
  width: 90%;
  max-width: 700px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem;
  border-bottom: 1px solid #edf2f7;
}

.modal-title {
  font-size: 1.25rem;
  font-weight: 600;
  color: #1a202c;
  margin: 0;
}

.modal-close-btn {
  background: none;
  border: none;
  padding: 0.5rem;
  cursor: pointer;
  border-radius: 50%;
  transition: background-color 0.2s ease;
}

.modal-close-btn:hover {
  background-color: #f7fafc;
}

.modal-close-btn svg {
  width: 20px;
  height: 20px;
  fill: #a0aec0;
}

.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  padding: 1.5rem;
}

.form-group {
  margin-bottom: 0;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  font-size: 0.9rem;
  font-weight: 500;
  color: #4a5568;
}

.form-input {
  width: 100%;
  padding: 0.75rem 1rem;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  font-size: 0.95rem;
  transition: all 0.2s ease;
}

.form-input:focus {
  outline: none;
  border-color: #4299e1;
  box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
}

.file-upload-wrapper {
  margin-top: 0.5rem;
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
  cursor: pointer;
  transition: all 0.2s ease;
  text-align: center;
}

.file-upload-label:hover {
  border-color: #cbd5e0;
  background: #f0f5ff;
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
  margin-bottom: 0.5rem;
  fill: #cbd5e0;
}

.file-name {
  font-size: 0.9rem;
  color: #4a5568;
  word-break: break-all;
  text-align: center;
}

.current-file {
  display: block;
  font-size: 0.8rem;
  color: #718096;
  margin-top: 0.5rem;
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 1rem;
  padding: 1.5rem;
  border-top: 1px solid #edf2f7;
}

.modal-btn {
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
  border: none;
}

.cancel-btn {
  background-color: #f7fafc;
  color: #4a5568;
}

.cancel-btn:hover {
  background-color: #edf2f7;
}

.confirm-btn {
  background-color: #4299e1;
  color: white;
}

.confirm-btn:hover:not(:disabled) {
  background-color: #3182ce;
}

.confirm-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.loading-spinner {
  display: inline-block;
  width: 12px;
  height: 12px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  border-top-color: white;
  animation: spin 1s ease-in-out infinite;
  margin-right: 6px;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.error-message {
  color: #e53e3e;
  font-size: 0.9rem;
  margin-top: 1rem;
  padding: 0 1.5rem 1.5rem;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .list-header {
    flex-direction: column;
    align-items: stretch;
  }

  .search-box {
    width: 100%;
  }

  .search-input {
    width: 100%;
  }
  .book-management-container {
    padding: 1.5rem;
  }

  .form-grid {
    grid-template-columns: 1fr;
  }

  .actions-cell {
    flex-direction: column;
  }

  .action-btn {
    width: 100%;
    justify-content: center;
  }

  .modal-footer {
    flex-direction: column;
  }

  .modal-btn {
    width: 100%;
  }
}
</style>
