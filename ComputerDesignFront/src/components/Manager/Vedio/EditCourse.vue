<template>
  <div class="course-admin-container">
    <div class="header">
      <h2>课程管理</h2>
      <router-link to="/admin/courses/create" class="create-btn"> 创建新课程 </router-link>
    </div>

    <div class="filter-bar">
      <el-input
        v-model="searchQuery"
        placeholder="搜索课程标题"
        clearable
        @clear="handleSearchClear"
        @keyup.enter="handleSearch"
        class="search-input"
      >
        <template #append>
          <el-button :icon="Search" @click="handleSearch" />
        </template>
      </el-input>
    </div>

    <el-table :data="courses" v-loading="loading" border stripe style="width: 100%">
      <el-table-column prop="id" label="ID" width="80" sortable />
      <el-table-column prop="title" label="课程标题" min-width="200" />
      <el-table-column prop="creatorId" label="创建者ID" width="120" />
      <el-table-column prop="createTime" label="创建时间" width="180">
        <template #default="{ row }">
          {{ formatDate(row.createTime) }}
        </template>
      </el-table-column>
      <el-table-column label="操作" width="180" fixed="right">
        <template #default="{ row }">
          <el-button size="small" @click="handleEdit(row.id)" type="primary" plain>
            编辑
          </el-button>
          <el-button size="small" @click="handleDelete(row.id)" type="danger" plain>
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <div class="pagination">
      <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :total="total"
        :page-sizes="[10, 20, 50, 100]"
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="fetchCourses"
        @current-change="fetchCourses"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Search } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import axios from 'axios'

const router = useRouter()

// 定义课程类型
interface Course {
  id: number
  title: string
  creatorId: number
  createTime: string
  description?: string
  coverImage?: string
}

// 分页响应类型
interface PaginationResponse<T> {
  content: T[]
  totalElements: number
  totalPages: number
  number: number
  size: number
}

// 数据状态
const courses = ref<Course[]>([])
const loading = ref(false)
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(10)
const searchQuery = ref('')

// 日期格式化函数
const formatDate = (dateString: string): string => {
  const date = new Date(dateString)
  return date.toLocaleString()
}

// 获取课程列表
const fetchCourses = async () => {
  try {
    loading.value = true

    const params = {
      page: currentPage.value - 1, // 后端页码从0开始
      size: pageSize.value,
      title: searchQuery.value,
    }

    const response = await axios.get<PaginationResponse<Course>>('/api/courses', { params })
    console.log(response.data)

    courses.value = response.data.content
    total.value = response.data.totalElements
  } catch (error) {
    ElMessage.error('获取课程列表失败')
    console.error('获取课程列表失败:', error)
  } finally {
    loading.value = false
  }
}

// 删除课程
const deleteCourse = async (id: number) => {
  try {
    await axios.delete(`/api/courses/${id}`)
    ElMessage.success('删除成功')
    fetchCourses() // 刷新列表
  } catch (error) {
    ElMessage.error('删除失败')
    console.error('删除课程失败:', error)
    throw error
  }
}

// 搜索处理
const handleSearch = () => {
  currentPage.value = 1
  fetchCourses()
}

const handleSearchClear = () => {
  searchQuery.value = ''
  handleSearch()
}

// 编辑课程
const handleEdit = (id: number) => {
  router.push(`/admin/courses/edit/${id}`)
}

// 删除确认
const handleDelete = async (id: number) => {
  try {
    await ElMessageBox.confirm('确定要删除此课程吗？', '警告', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    })
    await deleteCourse(id)
  } catch (error) {
    if (error !== 'cancel') {
      console.error('删除取消或失败:', error)
    }
  }
}

// 初始化加载
onMounted(() => {
  fetchCourses()
})
</script>

<style scoped>
.course-admin-container {
  padding: 20px;
  background-color: #fff;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.header h2 {
  margin: 0;
  font-size: 20px;
  color: #333;
}

.create-btn {
  padding: 8px 16px;
  background-color: #409eff;
  color: white;
  border-radius: 4px;
  text-decoration: none;
  transition: background-color 0.3s;
}

.create-btn:hover {
  background-color: #66b1ff;
}

.filter-bar {
  display: flex;
  gap: 15px;
  margin-bottom: 20px;
}

.search-input {
  width: 300px;
}

.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}
</style>
