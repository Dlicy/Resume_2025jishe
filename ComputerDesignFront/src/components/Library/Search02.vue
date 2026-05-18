<template>
  <LogoName />
  <div class="Library">
    <div class="Search">
      <div class="choose_Search01">
        <button class="book_survey" @click="goToSearch01">中医书籍</button>
      </div>
      <div class="choose_Search03">
        <button class="Chinese_medicine">中药大全</button>
      </div>
      <div class="choose_Search04">
        <button class="Component_lookup" @click="goToSearch03">中医方剂</button>
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
      <select name="drug_categories" id="drug_categories" v-model="selectedCategories">
        <option value="" disabled selected>请选择药物大类</option>
        <option v-for="category in categories" :key="category" :value="category">
          {{ category }}
        </option>
      </select>
      <select name="drug_category" id="drug_category" v-model="selectedCategory">
        <option value="" disabled selected>请选择药物小类</option>
        <option v-if="subCategories.length === 0" disabled>请先选择药物大类</option>
        <option v-for="subCategory in subCategories" :key="subCategory" :value="subCategory">
          {{ subCategory }}
        </option>
      </select>
      <input
        type="text"
        placeholder="输入想要查询的中药名称..."
        class="search-box"
        id="search-box"
        v-model="inputContent"
      />
      <button type="button" class="search-button" id="search-button" @click="performSearch">
        搜索
      </button>
    </div>
    <div class="Books">
      <ul class="Book_list" id="book-list">
        <li v-for="herb in displayedHerbs" :key="herb.id" @click="showHerbDetail(herb)">
          <div class="herb-image-container">
            <img :src="herb.imageUrl" alt="中药图片" class="Book_covers" />
            <div class="herb-overlay">
              <span>查看详情</span>
            </div>
          </div>
          <div class="herb-info">
            <p class="Book_author">{{ herb.mainName }}</p>
            <p class="Herb_subName">{{ herb.subName }}</p>
            <div class="herb-tags">
              <span class="tag">{{ herb.drugCategories }}</span>
              <span class="tag">{{ herb.drugCategory }}</span>
            </div>
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
const router = useRouter()
const route = useRoute()

interface Herb {
  id: number
  mainName: string
  subName: string
  drugCategories: string
  drugCategory: string
  imageUrl: string
}

function goToSearch01() {
  router.push('/search01')
}

function goToSearch03() {
  router.push('/search03')
}

// 定义类别选项
const categories = ref([])
const selectedCategories = ref('')
const selectedCategory = ref('')
const inputContent = ref('')
const subCategories = ref([])

const herbsPerPage = 8
const allHerbs = ref<Herb[]>([])
const currentPage = ref(Number(route.query.page) || 1)

const displayedHerbs = computed(() => {
  return allHerbs.value.slice(0, 0 + herbsPerPage)
})

const totalpages = ref(1)

const totalPages = computed(() => {
  return Math.ceil(totalpages.value / herbsPerPage)
})

// 计算可见的页码范围
const visiblePages = computed(() => {
  const pages = []
  const maxVisible = 5 // 最多显示5个页码
  let start = Math.max(1, currentPage.value - 2)
  let end = Math.min(totalPages.value, start + maxVisible - 1)

  if (end - start + 1 < maxVisible) {
    start = Math.max(1, end - maxVisible + 1)
  }

  // 添加第一页
  if (start > 1) {
    pages.push(1)
    if (start > 2) {
      pages.push('...')
    }
  }

  // 添加中间页码
  for (let i = start; i <= end; i++) {
    pages.push(i)
  }

  // 添加最后一页
  if (end < totalPages.value) {
    if (end < totalPages.value - 1) {
      pages.push('...')
    }
    pages.push(totalPages.value)
  }

  return pages
})

// 在组件挂载时发送请求
onMounted(async () => {
  try {
    const herbsResponse = await axios.get('/Encyclopedia/getHerbslists', {
      params: { page: currentPage.value },
    })
    console.log(herbsResponse)
    allHerbs.value = herbsResponse.data.data.lists
    totalpages.value = herbsResponse.data.data.total
  } catch (error) {
    console.error('获取书籍列表失败', error)
  }

  try {
    const categoriesResponse = await axios.get('/Encyclopedia/getHerbs_drug_categories')
    categories.value = categoriesResponse.data.data
  } catch (error) {
    console.error('获取药品类别失败', error)
  }
})

// 切换页面的方法
const changePage = async (page: number) => {
  if (page < 1 || page > totalPages.value) return

  currentPage.value = page
  await router.push({ path: '/search02', query: { page } })

  try {
    const response = await axios.get('/Encyclopedia/getHerbslists', {
      params: { page: currentPage.value },
    })
    allHerbs.value = response.data.data.lists
    totalpages.value = response.data.data.total
  } catch (error) {
    console.error('获取书籍列表失败', error)
  }
}

const performSearch = async () => {
  try {
    const response = await axios.get('/Encyclopedia/search', {
      params: {
        categories: selectedCategories.value,
        category: selectedCategory.value,
        input: inputContent.value,
      },
    })
    console.log(response.data.data)
    allHerbs.value = response.data.data.lists
    totalpages.value = response.data.data.total
    currentPage.value = 1 // 搜索后重置到第一页
  } catch (error) {
    console.error('Error during search:', error)
  }
}

// 查看中药详情
const showHerbDetail = (herb: Herb) => {
  router.push({
    path: '/showherb',
    query: {
      herbid: herb.id,
    },
  })
}

// 监听 selectedCategory 的变化
watch(selectedCategories, async (newCategory) => {
  if (newCategory) {
    try {
      const selectedText = newCategory
      const response = await axios.post('/Encyclopedia/getHerbs_drug_category', selectedText, {
        headers: {
          'Content-Type': 'text/plain',
        },
      })

      subCategories.value = response.data.data
      console.log(response.data.data)
    } catch (error) {
      console.error('获取药物小类失败', error)
    }
  } else {
    subCategories.value = []
  }
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
  background-color: #ccc;
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

.Library .Search01 #drug_categories {
  border-top-left-radius: 15px;
  border: 1px solid lightgrey;
  width: 15%;
  font-size: 20px;
  text-align: center;
}

.Library .Search01 #drug_category {
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
  height: 100%;
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
  height: 280px;
  display: flex;
  flex-direction: column;
}

.Library .Books .Book_list li:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
  border-color: #4db8b8;
}

.herb-image-container {
  position: relative;
  width: 100%;
  height: 60%;
  overflow: hidden;
}

.Library .Books .Book_list li .Book_covers {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s;
}

.herb-overlay {
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

.herb-overlay span {
  color: white;
  font-size: 18px;
  font-weight: bold;
}

.Library .Books .Book_list li:hover .Book_covers {
  transform: scale(1.05);
}

.Library .Books .Book_list li:hover .herb-overlay {
  opacity: 1;
}

.herb-info {
  padding: 15px;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.Library .Books .Book_list li .Book_author {
  color: #333;
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 5px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.Library .Books .Book_list li .Herb_subName {
  color: #666;
  font-size: 16px;
  margin-bottom: 10px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.herb-tags {
  margin-top: auto;
  display: flex;
  flex-wrap: wrap;
  gap: 5px;
}

.tag {
  background-color: #f0f7f7;
  color: #4db8b8;
  padding: 3px 8px;
  border-radius: 4px;
  font-size: 12px;
}

/* 美化分页器 */
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
