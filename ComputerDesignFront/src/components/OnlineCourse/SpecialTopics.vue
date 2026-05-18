<template>
  <div class="app">
    <Header />
    <div class="main-content">
      <h1 class="page-title">专题课程</h1>
      <div v-if="loading" class="loading">加载中...</div>
      <div v-else-if="error" class="error">加载失败: {{ error }}</div>
      <div v-else class="course-list">
        <div v-for="course in courses" :key="course.id" class="course-card">
          <router-link :to="`/course/${course.id}`" class="course-link">
            <div class="cover-container">
              <img
                :src="course.coverImage || '/default-course-cover.jpg'"
                :alt="course.title"
                class="course-cover"
                @error="handleImageError"
              />
            </div>
            <div class="course-info">
              <h3>{{ course.title }}</h3>
              <p class="description">{{ course.description || '暂无描述' }}</p>
              <div class="meta">
                <span class="creator">创建者: {{ course.creatorId }}</span>
                <span class="time">{{ formatDate(course.createTime) }}</span>
              </div>
            </div>
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Header from './tools/Header.vue'
import axios from 'axios'

export default {
  components: {
    Header,
  },
  data() {
    return {
      courses: [],
      loading: true,
      error: null,
    }
  },
  async created() {
    try {
      const response = await axios.get('/api/courses/all')
      this.courses = response.data
      console.log(response.data)
    } catch (error) {
      console.error('获取专题课程失败:', error)
      this.error = error.message || '获取课程列表失败'
    } finally {
      this.loading = false
    }
  },
  methods: {
    handleImageError(e) {
      e.target.src = '/default-course-cover.jpg'
    },
    formatDate(dateString) {
      if (!dateString) return ''
      const date = new Date(dateString)
      return date.toLocaleDateString()
    },
  },
}
</script>

<style scoped>
.app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.main-content {
  flex: 1;
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
  width: 100%;
}

.page-title {
  font-size: 28px;
  margin-bottom: 30px;
  color: #333;
  text-align: center;
}

.loading,
.error {
  text-align: center;
  padding: 40px;
  font-size: 18px;
}

.error {
  color: #f56c6c;
}

.course-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 25px;
  padding: 10px;
}

.course-card {
  background: #fff;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
}

.course-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
}

.course-link {
  text-decoration: none;
  color: inherit;
  display: block;
  height: 100%;
}

.cover-container {
  height: 180px;
  overflow: hidden;
}

.course-cover {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s;
}

.course-card:hover .course-cover {
  transform: scale(1.05);
}

.course-info {
  padding: 15px;
}

.course-info h3 {
  margin: 0 0 10px;
  font-size: 18px;
  color: #333;
  font-weight: 600;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.description {
  margin: 0 0 12px;
  font-size: 14px;
  color: #666;
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.meta {
  display: flex;
  justify-content: space-between;
  font-size: 12px;
  color: #999;
}
</style>
