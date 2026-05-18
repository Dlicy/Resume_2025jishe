<template>
  <LogoName />
  <div class="Library">
    <div class="Search">
      <div class="choose_Search01">
        <button class="book_survey Search_active">中医书籍</button>
      </div>
      <div class="choose_Search03">
        <button class="Chinese_medicine Search_unactive" @click="goToSearch02">中药大全</button>
      </div>
      <div class="choose_Search04">
        <button class="Component_lookup Search_unactive" @click="goToSearch03">中医方剂</button>
      </div>
      <!-- Prescription -->
      <!-- <div class="choose_Search05">
        <button class="Diet Search_unactive">中医食疗</button>
      </div>
      <div class="choose_Search02">
        <button class="Component_lookup Search_unactive">组件查阅</button>
      </div> -->
    </div>
    <div class="Search01">
      <input
        type="text"
        v-model="searchQuery"
        placeholder="输入书籍的名字/作者名字..."
        class="search-box"
        id="search-box"
        @keyup.enter="fetchBooks"
      />
      <button type="button" class="search-button" id="search-button" @click="fetchBooks">
        搜索
      </button>
    </div>

    <!-- 书籍展示区域 -->
    <div class="Books" v-if="!loading">
      <div v-if="books.length === 0" class="empty-state">
        <p>暂无书籍数据</p>
      </div>
      <ul v-else class="Book_list">
        <li v-for="book in books" :key="book.id" @click="goToBookDetail(book.id)">
          <div class="book-image-container">
            <img v-if="book.coverUrl" :src="book.coverUrl" :alt="book.title" class="Book_covers" />
            <div v-else class="image-placeholder">
              <span>无封面</span>
            </div>
            <div class="book-overlay">
              <span>查看详情</span>
            </div>
          </div>
          <div class="book-info">
            <p class="Book_title">{{ book.title }}</p>
            <p class="Book_author">{{ book.author || '未知作者' }}</p>
            <div class="book-meta">
              <span class="publisher">{{ book.publisher || '未知出版社' }}</span>
              <span class="rating" v-if="book.rating">
                <i class="star">★</i>{{ book.rating }}
              </span>
            </div>
          </div>
        </li>
      </ul>

      <!-- 分页器 -->
      <div class="pagination-container">
        <button
          class="pagination-arrow"
          :disabled="currentPage === 1"
          @click="changePage(currentPage - 1)"
        >
          &lt;
        </button>
        <ul class="Paginator">
          <li v-for="page in visiblePages" :key="page">
            <a
              href="#"
              :class="{ active: page === currentPage, 'page-dots': page === '...' }"
              @click.prevent="page !== '...' && changePage(page)"
            >
              {{ page }}
            </a>
          </li>
        </ul>
        <button
          class="pagination-arrow"
          :disabled="currentPage === totalPages"
          @click="changePage(currentPage + 1)"
        >
          &gt;
        </button>
      </div>
    </div>

    <div v-if="loading" class="loading-indicator">
      <div class="spinner"></div>
      加载中...
    </div>
  </div>
  <footer class="footer">
    <div class="container">
      <p>© 2025 中医针灸学习平台 - 计算机设计大赛参赛作品</p>
      <p>
        联系我们:
        <a href="mailto:2015870900@qq.com">2015870900@qq.com</a>
      </p>
    </div>
  </footer>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import LogoName from './LogoName.vue'
import axio from '../../api/axio.ts'

const router = useRouter()

// 路由跳转
function goToSearch02() {
  router.push('/search02')
}

function goToSearch03() {
  router.push('/search03')
}

// 跳转到书籍详情页
function goToBookDetail(bookId: number) {
  router.push(`/showbook?bookid=${bookId}`)
}

// 数据状态
const books = ref<any[]>([])
const loading = ref(false)
const currentPage = ref(1)
const itemsPerPage = 8
const totalPages = ref(0)
const totalItems = ref(0)
const searchQuery = ref('')

// API配置
const API_BASE = import.meta.env.VITE_API_URL
const API_ENDPOINTS = {
  GET_BOOKS: `/api/books`,
  GET_COVER: (id: number) => `/api/books/${id}/cover`,
}

// 获取书籍列表
const fetchBooks = async () => {
  try {
    loading.value = true
    const response = await axios.get(API_ENDPOINTS.GET_BOOKS, {
      params: {
        page: currentPage.value - 1,
        size: itemsPerPage,
        search: searchQuery.value,
      },
    })

    books.value = response.data.content.map((book: any) => ({
      ...book,
      coverUrl: book.coverUrl || API_ENDPOINTS.GET_COVER(book.id),
    }))

    totalPages.value = response.data.totalPages
    totalItems.value = response.data.totalElements
  } catch (error) {
    console.error('获取书籍列表失败:', error)
  } finally {
    loading.value = false
  }
}

// 计算可见的页码范围
const visiblePages = computed(() => {
  const pages = []
  const maxVisible = 5
  let start = Math.max(1, currentPage.value - 2)
  let end = Math.min(totalPages.value, start + maxVisible - 1)

  if (end - start + 1 < maxVisible) {
    start = Math.max(1, end - maxVisible + 1)
  }

  if (start > 1) {
    pages.push(1)
    if (start > 2) {
      pages.push('...')
    }
  }

  for (let i = start; i <= end; i++) {
    pages.push(i)
  }

  if (end < totalPages.value) {
    if (end < totalPages.value - 1) {
      pages.push('...')
    }
    pages.push(totalPages.value)
  }

  return pages
})

// 切换页面
const changePage = (page: number) => {
  if (page < 1 || page > totalPages.value || page === '...') return

  currentPage.value = page
  fetchBooks()
}

// 初始化加载
onMounted(() => {
  fetchBooks()
})
</script>

<style scoped>
/* 基础样式保持不变 */
.Library {
  width: 100%;
  font-family: 'Microsoft YaHei', sans-serif;
}

.Library .Search {
  width: 500px;
  height: 40px;
  margin-left: 15%;
  display: flex;
  /* justify-content: space-between; */
  align-items: center;
}

.Library .Search .choose_Search01,
.Library .Search .choose_Search02,
.Library .Search .choose_Search03,
.Library .Search .choose_Search04,
.Library .Search .choose_Search05 {
  width: 20%;
  height: 40px;
  background-color: #fff;
  border: 2px solid lightgray;
  text-align: center;
  line-height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0;
  box-sizing: border-box;
}

.Library .Search .choose_Search01 {
  border-right: none;
  border-bottom: none;
  border-top-left-radius: 15px;
  border: none;
  background-color: #ccc;
}

.Library .Search .choose_Search02 {
  margin-left: -2px;
  border-bottom: none;
  border: none;
  border-top-right-radius: 15px;
}

.Library .Search .choose_Search03 {
  margin-left: -2px;
  border-bottom: none;
  border: none;
}

.Library .Search .choose_Search04 {
  margin-left: -2px;
  border-bottom: none;
  border: none;
}

.Library .Search .choose_Search05 {
  margin-left: -2px;
  border-bottom: none;
  border: none;
}

.book_survey {
  width: 100%;
  height: 100%;
  border: none;
  border-top-left-radius: 15px;
  background-color: #ccc;
  cursor: pointer;
  transition: all 0.5s;
  border: 1px solid lightgray;
  border-bottom: none;
}

.book_survey:hover {
  background-color: #ccc;
}

.Chinese_medicine {
  width: 100%;
  height: 100%;
  border: none;
  background-color: white;
  cursor: pointer;
  transition: all 0.5s;
  border: 1px solid lightgray;
  border-bottom: none;
}

.Chinese_medicine:hover {
  background-color: #ccc;
}

.Prescription {
  width: 100%;
  height: 100%;
  border: none;
  background-color: white;
  cursor: pointer;
  transition: all 0.5s;
  border: 1px solid lightgray;
  border-bottom: none;
}

.Prescription:hover {
  background-color: #ccc;
}

.Diet {
  width: 100%;
  height: 100%;
  border: none;
  background-color: white;
  cursor: pointer;
  transition: all 0.5s;
  border: 1px solid lightgray;
  border-bottom: none;
}

.Diet:hover {
  background-color: #ccc;
}

.Component_lookup {
  width: 100%;
  height: 100%;
  border: none;
  border-top-right-radius: 15px;
  background-color: white;
  cursor: pointer;
  transition: all 0.5s;
  border: 1px solid lightgray;
  border-bottom: none;
}

.Component_lookup:hover {
  background-color: #ccc;
}

/* 搜索框样式保持不变 */
.Library .Search01 {
  height: 50px;
  width: 75%;
  display: flex;
  margin: auto;
  transition: all 0.5s;
}

.Library .Search01 .search-box {
  display: inline-block;
  padding: 5px;
  width: 80%;
  margin: 0;
  font-size: 20px;
  border: 1px solid lightgrey;
  border-top-left-radius: 15px;
  outline: none;
}

.Library .Search01 .search-button {
  display: inline-block;
  width: 20%;
  font-size: 20px;
  margin: 0;
  border: 1px solid lightgrey;
  border-bottom-right-radius: 15px;
  background-color: #f8f8f8;
  cursor: pointer;
  transition: background-color 0.3s;
}

.Library .Search01 .search-button:hover {
  background-color: #e0e0e0;
}

/* 书籍展示区域美化 */
.Library .Books {
  margin: auto;
  margin-top: 40px;
  width: 80%;
}

.Library .Books .Book_list {
  width: 100%;
  list-style-type: none;
  padding: 0;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 25px;
  margin-bottom: 50px;
}

.Library .Books .Book_list li {
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
  background-color: #fff;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
  cursor: pointer;
  height: 380px;
  display: flex;
  flex-direction: column;
}

.Library .Books .Book_list li:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
  border-color: #4db8b8;
}

.book-image-container {
  position: relative;
  width: 100%;
  height: 60%;
  overflow: hidden;
  background-color: #f5f5f5;
}

.Library .Books .Book_list li .Book_covers {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s;
}

.image-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999;
  font-size: 16px;
  background-color: #f0f0f0;
}

.book-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s;
}

.book-overlay span {
  color: white;
  font-size: 18px;
  font-weight: bold;
}

.Library .Books .Book_list li:hover .Book_covers {
  transform: scale(1.05);
}

.Library .Books .Book_list li:hover .book-overlay {
  opacity: 1;
}

.book-info {
  padding: 15px;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.Book_title {
  color: #333;
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 8px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  min-height: 44px;
}

.Book_author {
  color: #666;
  font-size: 14px;
  margin-bottom: 10px;
}

.book-meta {
  display: flex;
  justify-content: space-between;
  margin-top: auto;
  font-size: 13px;
  color: #888;
}

.publisher {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  max-width: 70%;
}

.rating {
  color: #ffb800;
  font-weight: bold;
}

.star {
  margin-right: 3px;
}

/* 加载指示器 */
.loading-indicator {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px;
  color: #666;
}

.spinner {
  width: 40px;
  height: 40px;
  border: 4px solid rgba(0, 0, 0, 0.1);
  border-left-color: #4299e1;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 10px;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

/* 分页器样式 */
.pagination-container {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 30px 0;
  gap: 10px;
}

.pagination-arrow {
  width: 40px;
  height: 40px;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  background-color: white;
  cursor: pointer;
  font-size: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s;
}

.pagination-arrow:hover:not(:disabled) {
  background-color: #f0f7f7;
  border-color: #4db8b8;
  color: #4db8b8;
}

.pagination-arrow:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.Library .Books .Paginator {
  display: flex;
  list-style-type: none;
  padding: 0;
  margin: 0;
  gap: 5px;
}

.Library .Books .Paginator li {
  display: inline-block;
}

.Library .Books .Paginator a {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border-radius: 8px;
  border: 1px solid #e0e0e0;
  color: #333;
  text-decoration: none;
  transition: all 0.3s;
  font-size: 16px;
}

.Library .Books .Paginator a:hover:not(.active, .page-dots) {
  background-color: #f0f7f7;
  border-color: #4db8b8;
  color: #4db8b8;
}

.Library .Books .Paginator .active {
  background-color: #4db8b8;
  border-color: #4db8b8;
  color: white;
}

.Library .Books .Paginator .page-dots {
  border: none;
  cursor: default;
  pointer-events: none;
  width: 20px;
}

.empty-state {
  text-align: center;
  padding: 40px;
  color: #999;
  font-size: 16px;
}

@media (max-width: 768px) {
  .Library .Books .Book_list {
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  }
}

@media (max-width: 576px) {
  .Library .Books .Book_list {
    grid-template-columns: 1fr;
  }

  .Library .Search {
    width: 90%;
    margin-left: 5%;
  }

  .Library .Search01 {
    width: 90%;
  }
}

/* 页脚 */
.footer {
  padding: 40px 0;
  border-top: 1px solid rgba(60, 60, 67, 0.12);
  text-align: center;
  font-size: 14px;
  color: rgba(60, 60, 67, 0.7);
}

.footer a {
  color: #3c8772;
  text-decoration: none;
}

.footer a:hover {
  text-decoration: underline;
}
</style>
