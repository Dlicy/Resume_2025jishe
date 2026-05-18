<template>
  <LogoName />
  <div class="Library">
    <div class="Search">
      <div class="choose_Search01">
        <button class="book_survey" @click="goToSearch01">中医书籍</button>
      </div>
      <div class="choose_Search03">
        <button class="Chinese_medicine" @click="goToSearch02">中药大全</button>
      </div>
      <div class="choose_Search04">
        <button class="Component_lookup active">中医方剂</button>
      </div>
      <!-- Prescription -->
      <!-- <div class="choose_Search05">
        <button class="Diet">中医食疗</button>
      </div>
      <div class="choose_Search02">
        <button class="Component_lookup">组件查阅</button>
      </div> -->
    </div>
    <div class="Search01">
      <select name="formula_categories" id="formula_categories" v-model="selectedMainCategory">
        <option value="" disabled selected>请选择方剂大类</option>
        <option v-for="category in mainCategories" :key="category" :value="category">
          {{ category }}
        </option>
      </select>
      <select name="formula_category" id="formula_category" v-model="selectedSubCategory">
        <option value="" disabled selected>请选择方剂小类</option>
        <option v-if="subCategories.length === 0" disabled>请先选择方剂大类</option>
        <option v-for="subCategory in subCategories" :key="subCategory" :value="subCategory">
          {{ subCategory }}
        </option>
      </select>
      <input
        type="text"
        placeholder="输入想要查询的方剂名称..."
        class="search-box"
        id="search-box"
        v-model="searchKeyword"
      />
      <button type="button" class="search-button" id="search-button" @click="performSearch">
        搜索
      </button>
    </div>
    <div class="Books">
      <ul class="Book_list" id="book-list">
        <li
          v-for="formula in displayedFormulas"
          :key="formula.id"
          @click="showFormulaDetail(formula)"
          class="formula-card"
        >
          <div class="formula-header">
            <h3 class="formula-name">{{ formula.name }}</h3>
            <div class="formula-categories">
              <span class="main-category">{{ formula.mainCategory }}</span>
              <span class="sub-category">{{ formula.subCategory }}</span>
            </div>
          </div>
          <div class="formula-content">
            <p class="formula-composition">
              <span class="label">组成：</span>{{ formula.composition }}
            </p>
            <p class="formula-functions" v-if="formula.functions">
              <span class="label">功效：</span>{{ formula.functions }}
            </p>
          </div>
          <div class="formula-footer">
            <button class="detail-button">查看详情</button>
          </div>
        </li>
      </ul>
      <div class="pagination-container">
        <button
          class="pagination-arrow"
          :disabled="currentPage === 1"
          @click="changePage(currentPage - 1)"
        >
          &lt;
        </button>
        <ul class="Paginator" id="paginator1">
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
import LogoName from './LogoName.vue'
import { useRoute, useRouter } from 'vue-router'
import { ref, onMounted, watch, computed } from 'vue'
import axios from 'axios'
import axio from '../../api/axio.ts'

const router = useRouter()
const route = useRoute()

interface Formula {
  id: number
  name: string
  mainCategory: string
  subCategory: string
  composition: string
  functions: string
  indications: string
}

// 数据部分 - 将分类数据写死在组件中
const mainCategories = ref([
  '补益剂',
  '解表剂',
  '清热剂',
  '祛湿剂',
  '理气剂',
  '和解剂',
  '泻下剂',
  '温里剂',
  '治风剂',
  '治燥剂',
  '祛痰剂',
  '消食剂',
  '驱虫剂',
  '治痈剂',
])

const subCategoryMap = {
  补益剂: ['补气剂', '补血剂', '气血双补剂', '补阴剂', '补阳剂', '阴阳双补剂'],
  解表剂: ['辛温解表剂', '辛凉解表剂', '扶正解表剂'],
  清热剂: ['清气分热剂', '清营凉血剂', '清热解毒剂', '清脏腑热剂', '清虚热剂'],
  祛湿剂: ['燥湿和胃剂', '清热祛湿剂', '利水渗湿剂', '温化水湿剂', '祛风胜湿剂'],
  // 其他分类的子类...
}

function goToSearch01() {
  router.push('/search01')
}

function goToSearch02() {
  router.push('/search02')
}

// 定义类别选项
const selectedMainCategory = ref('')
const selectedSubCategory = ref('')
const searchKeyword = ref('')
const subCategories = ref<string[]>([])

const formulasPerPage = 8
const allFormulas = ref<Formula[]>([])
const currentPage = ref(Number(route.query.page) || 1)

const displayedFormulas = computed(() => {
  return allFormulas.value.slice(0, 0 + formulasPerPage)
})

const totalItems = ref(0)

const totalPages = computed(() => {
  return Math.ceil(totalItems.value / formulasPerPage)
})

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

// 获取方剂列表
const fetchFormulas = async () => {
  try {
    const response = await axios.get('/encyclopedia/formulas/searchFormulas', {
      params: {
        page: currentPage.value - 1,
        size: formulasPerPage,
        main_category: selectedMainCategory.value,
        sub_category: selectedSubCategory.value,
        input: searchKeyword.value,
      },
    })
    if (response.data.success) {
      allFormulas.value = response.data.data.content
      totalItems.value = response.data.data.totalElements
    }
  } catch (error) {
    console.error('获取方剂列表失败', error)
  }
}

// 切换页面的方法
const changePage = async (page: number) => {
  if (page < 1 || page > totalPages.value) return

  currentPage.value = page
  await router.push({ path: '/formulas', query: { page } })
  await fetchFormulas()
}

// 执行搜索
const performSearch = async () => {
  currentPage.value = 1
  await fetchFormulas()
}

// 查看方剂详情
const showFormulaDetail = (formula: Formula) => {
  router.push({
    path: '/showformula',
    query: {
      formulaid: formula.id,
    },
  })
}

// 监听大类变化
watch(selectedMainCategory, (newVal) => {
  if (newVal) {
    subCategories.value = subCategoryMap[newVal] || []
    selectedSubCategory.value = ''
  } else {
    subCategories.value = []
  }
})

// 初始化数据
onMounted(async () => {
  await fetchFormulas()
})
</script>

<style scoped>
/* 基础样式保持不变 */
.Library {
  width: 100%;
  font-family: 'Microsoft YaHei', sans-serif;
  /* max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px; */
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
  background-color: #ccc;
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
  background-color: white;
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
  background-color: #fff;
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

.Search_active {
  background: #ccc;
}

.Search_unactive {
  background: white;
}

.Library .Search01 #formula_categories {
  border-top-left-radius: 15px;
  border: 1px solid lightgrey;
  width: 15%;
  font-size: 20px;
  text-align: center;
}

.Library .Search01 #formula_category {
  width: 15%;
  border: 1px solid lightgrey;
  font-size: 20px;
  text-align: center;
}

.Library .Search01 .search-box {
  display: inline-block;
  padding: 5px;
  width: 50%;
  margin: 0;
  font-size: 20px;
  border: 1px solid lightgrey;
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

/* 美化内容展示区域 */
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
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 25px;
  margin-bottom: 50px;
}

.formula-card {
  background-color: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  border: 1px solid #eaeaea;
  cursor: pointer;
}

.formula-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
  border-color: #3c8772;
}

.formula-header {
  padding: 20px;
  background-color: #f8f9fa;
  border-bottom: 1px solid #eaeaea;
}

.formula-name {
  margin: 0;
  font-size: 20px;
  font-weight: 600;
  color: #2d3748;
}

.formula-categories {
  display: flex;
  gap: 8px;
  margin-top: 8px;
}

.main-category,
.sub-category {
  padding: 4px 10px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 500;
}

.main-category {
  background-color: #e6f2ef;
  color: #3c8772;
}

.sub-category {
  background-color: #f0f5ff;
  color: #4a6bdf;
}

.formula-content {
  padding: 20px;
  flex-grow: 1;
}

.formula-composition,
.formula-functions {
  margin: 0 0 12px 0;
  font-size: 15px;
  line-height: 1.5;
  color: #4a5568;
}

.label {
  font-weight: 600;
  color: #2d3748;
}

.formula-footer {
  padding: 0 20px 20px;
  text-align: right;
}

.detail-button {
  padding: 8px 16px;
  background-color: transparent;
  border: 1px solid #3c8772;
  border-radius: 6px;
  color: #3c8772;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s;
}

.detail-button:hover {
  background-color: #3c8772;
  color: white;
}

/* 分页样式优化 */
.pagination-container {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 40px 0;
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
  color: #4a5568;
}

.pagination-arrow:hover:not(:disabled) {
  background-color: #f8f9fa;
  border-color: #3c8772;
  color: #3c8772;
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
  color: #4a5568;
  text-decoration: none;
  transition: all 0.3s;
  font-size: 16px;
}

.Library .Books .Paginator a:hover:not(.active, .page-dots) {
  background-color: #f8f9fa;
  border-color: #3c8772;
  color: #3c8772;
}

.Library .Books .Paginator .active {
  background-color: #3c8772;
  border-color: #3c8772;
  color: white;
}

.Library .Books .Paginator .page-dots {
  border: none;
  cursor: default;
  pointer-events: none;
  width: 20px;
}

/* 页脚样式优化 */
.footer {
  padding: 40px 0;
  margin-top: 60px;
  background-color: #f8f9fa;
  text-align: center;
  font-size: 14px;
  color: #4a5568;
}

.footer a {
  color: #3c8772;
  text-decoration: none;
  transition: color 0.3s;
}

.footer a:hover {
  color: #2c6656;
  text-decoration: underline;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .Library .Search01 {
    flex-direction: column;
    height: auto;
    gap: 10px;
  }

  .Library .Books .Book_list {
    grid-template-columns: 1fr;
  }
}

.active {
  background-color: #ccc;
}
</style>
