<template>
  <div class="video-review-container">
    <h2 class="review-title">推荐复习视频</h2>
    <div class="video-list">
      <div v-if="isLoading" class="loading">
        <p>加载中...</p>
      </div>
      <div v-else-if="videos.length === 0" class="no-videos">
        <p>暂无已完成的视频</p>
      </div>
      <div v-else class="video-items">
        <div v-for="video in videos" :key="video.videoId" class="video-item">
          <div class="video-info">
            <h3 class="video-name">{{ video.title }}</h3>
            <p class="video-meta">
              完成于: {{ formatDate(video.completedAt) }} | 时长:
              {{ formatDuration(video.durationSeconds) }}
            </p>
          </div>
          <button class="review-btn" @click="goToVideo(video.videoId)">复习</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const videos = ref([])
const isLoading = ref(true)

const formatDate = (dateString) => {
  if (!dateString) return '未知时间'
  const date = new Date(dateString)
  return date.toLocaleDateString('zh-CN', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  })
}

const formatDuration = (seconds) => {
  if (!seconds) return '0秒'
  const mins = Math.floor(seconds / 60)
  const secs = seconds % 60
  return `${mins}分${secs}秒`
}

const goToVideo = (videoId) => {
  router.push(`/video/${videoId}`)
}

const fetchCompletedVideos = async () => {
  try {
    const token = localStorage.getItem('token')
    const response = await axios.get('/api/learning/completed-videos', {
      headers: { Authorization: `Bearer ${token}` },
    })
    videos.value = response.data
  } catch (error) {
    console.error('获取视频列表失败:', error)
    videos.value = []
  } finally {
    isLoading.value = false
  }
}

onMounted(() => {
  fetchCompletedVideos()
})
</script>

<style scoped>
.video-review-container {
  flex: 1;
  background: #ffffff;
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  display: flex;
  flex-direction: column;
  height: 400px;
}

.review-title {
  font-size: 1.2rem;
  color: #2c3e50;
  margin-bottom: 1.5rem;
  text-align: center;
  font-weight: 600;
}

.video-list {
  flex: 1;
  overflow-y: auto;
  padding-right: 0.5rem;
}

.loading,
.no-videos {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  color: #7f8c8d;
}

.video-items {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.video-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background: #f8f9fa;
  border-radius: 8px;
  transition: all 0.2s ease;
}

.video-item:hover {
  background: #e9ecef;
  transform: translateY(-2px);
}

.video-info {
  flex: 1;
}

.video-name {
  margin: 0 0 0.5rem;
  font-size: 1rem;
  color: #2c3e50;
}

.video-meta {
  margin: 0;
  font-size: 0.8rem;
  color: #7f8c8d;
}

.review-btn {
  padding: 0.5rem 1rem;
  background: #4bc0c0;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.2s ease;
  font-size: 0.9rem;
}

.review-btn:hover {
  background: #3aa8a8;
  box-shadow: 0 2px 8px rgba(75, 192, 192, 0.3);
}

/* 滚动条样式 */
.video-list::-webkit-scrollbar {
  width: 6px;
}

.video-list::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 3px;
}

.video-list::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 3px;
}

@media (max-width: 768px) {
  .video-review-container {
    margin-top: 1.5rem;
    height: auto;
    max-height: 300px;
  }
}
</style>
