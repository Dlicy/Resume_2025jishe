<template>
  <div class="video-admin-container">
    <div class="header">
      <h2>视频管理</h2>
      <router-link to="/admin/videos/upload" class="create-btn">
        <el-button type="primary">上传视频</el-button>
      </router-link>
    </div>

    <div class="filter-bar">
      <el-input
        v-model="searchQuery"
        placeholder="搜索视频标题"
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

    <el-table :data="videos" v-loading="loading" border stripe style="width: 100%">
      <el-table-column prop="id" label="ID" width="80" sortable />
      <el-table-column prop="title" label="视频标题" min-width="200" />
      <el-table-column label="封面" width="120">
        <template #default="{ row }">
          <el-image
            v-if="row.coverImage"
            :src="getImageUrl(row.coverImage)"
            :preview-src-list="[getImageUrl(row.coverImage)]"
            fit="cover"
            style="width: 80px; height: 45px"
          />
          <span v-else>无封面</span>
        </template>
      </el-table-column>
      <el-table-column prop="author.username" label="上传者" width="120" />
      <el-table-column prop="duration" label="时长" width="100">
        <template #default="{ row }">
          {{ formatDuration(row.duration) }}
        </template>
      </el-table-column>
      <el-table-column prop="views" label="观看数" width="100" sortable />
      <el-table-column prop="uploadTime" label="上传时间" width="180" sortable>
        <template #default="{ row }">
          {{ formatDate(row.uploadTime) }}
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
        @size-change="fetchVideos"
        @current-change="fetchVideos"
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

// 定义视频类型
interface Video {
  id: number
  title: string
  description?: string
  videoPath: string
  coverImage?: string
  duration: number // 秒数
  views: number
  uploadTime: string
  author: {
    id: number
    username: string
  }
}

// 数据状态
const videos = ref<Video[]>([])
const loading = ref(false)
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(10)
const searchQuery = ref('')

// 获取图片完整URL
const getImageUrl = (path: string) => {
  return path.startsWith('http') ? path : `/api/uploads/${path}`
}

// 格式化时长
const formatDuration = (seconds: number) => {
  const mins = Math.floor(seconds / 60)
  const secs = seconds % 60
  return `${mins}:${secs.toString().padStart(2, '0')}`
}

// 日期格式化
const formatDate = (dateString: string) => {
  return new Date(dateString).toLocaleString()
}

// 获取视频列表
const fetchVideos = async () => {
  try {
    loading.value = true
    const params = {
      page: currentPage.value - 1, // 后端页码从0开始
      size: pageSize.value,
      title: searchQuery.value || undefined,
    }

    const response = await axios.get('/api/videos', { params })
    videos.value = response.data.content
    total.value = response.data.totalElements
  } catch (error) {
    ElMessage.error('获取视频列表失败')
    console.error('获取视频列表失败:', error)
  } finally {
    loading.value = false
  }
}

// 删除视频
const deleteVideo = async (id: number) => {
  try {
    await axios.delete(`/api/videos/${id}`)
    ElMessage.success('删除成功')
    fetchVideos()
  } catch (error) {
    ElMessage.error('删除失败')
    console.error('删除视频失败:', error)
  }
}

// 搜索处理
const handleSearch = () => {
  currentPage.value = 1
  fetchVideos()
}

const handleSearchClear = () => {
  searchQuery.value = ''
  handleSearch()
}

// 编辑视频
const handleEdit = (id: number) => {
  router.push(`/admin/videos/edit/${id}`)
}

// 删除确认
const handleDelete = async (id: number) => {
  try {
    await ElMessageBox.confirm('确定要删除此视频吗？', '警告', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    })
    await deleteVideo(id)
  } catch (error) {
    if (error !== 'cancel') {
      console.error('删除取消或失败:', error)
    }
  }
}

// 初始化加载
onMounted(() => {
  fetchVideos()
})
</script>

<style scoped>
.video-admin-container {
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

.el-image {
  border-radius: 4px;
  cursor: pointer;
}
</style>
