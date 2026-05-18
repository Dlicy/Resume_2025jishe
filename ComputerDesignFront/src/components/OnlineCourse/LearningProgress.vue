<template>
  <div class="learning-progress-page">
    <Header />
    <div class="main-content">
      <h1 class="page-title">我的学习进度</h1>

      <!-- 课程列表 -->
      <div class="course-list">
        <div v-for="course in courses" :key="course.id" class="course-card">
          <div class="course-header">
            <img :src="course.coverImage || defaultCover" class="course-cover" />
            <div class="course-info">
              <h2 class="course-title">{{ course.title }}</h2>
              <p class="course-description">{{ course.description || '暂无描述' }}</p>
            </div>
          </div>

          <!-- 课程进度条 -->
          <div class="progress-container">
            <div class="progress-bar">
              <div class="progress-fill" :style="{ width: course.progress + '%' }"></div>
            </div>
            <span class="progress-text">
              {{ course.progress }}% 已完成 ({{ course.completedVideos }}/{{
                course.totalVideos
              }}个视频)
            </span>
          </div>

          <!-- 视频列表 -->
          <div class="video-list">
            <div v-for="video in course.videos" :key="video.id" class="video-item">
              <div class="video-thumbnail" @click="goToVideo(video.id)">
                <img :src="video.coverImage || defaultThumbnail" />
                <div class="video-duration">{{ formatDuration(video.duration) }}</div>
                <div class="video-progress" :style="{ width: video.progress + '%' }"></div>
                <div v-if="video.progress === 100" class="completed-badge">
                  <svg viewBox="0 0 24 24">
                    <path
                      d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"
                      fill="currentColor"
                    />
                  </svg>
                </div>
              </div>
              <div class="video-details">
                <h3 class="video-title">{{ video.title }}</h3>
                <div class="video-meta">
                  <span class="video-progress-text">{{ video.progress }}% 已完成</span>
                  <span class="video-time">已学习 {{ formatTime(video.durationLearned) }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div v-if="loading" class="loading-state">
        <div class="spinner"></div>
        <p>加载中...</p>
      </div>

      <div v-if="!loading && courses.length === 0" class="empty-state">
        <svg viewBox="0 0 24 24">
          <path
            d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 14H9V8h2v8zm4 0h-2V8h2v8z"
            fill="currentColor"
          />
        </svg>
        <p>您还没有开始任何课程</p>
        <router-link to="/courses" class="explore-btn">探索课程</router-link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import Header from './tools/Header.vue'

const router = useRouter()
const courses = ref([])
const loading = ref(true)
const defaultCover = 'https://via.placeholder.com/300x170?text=Course+Cover'
const defaultThumbnail = 'https://via.placeholder.com/300x170?text=Video+Thumbnail'

// 获取用户学习进度数据
const fetchLearningProgress = async () => {
  try {
    loading.value = true

    // 1. 获取用户的所有课程
    const coursesResponse = await axios.get('/api/courses/all')
    const allCourses = coursesResponse.data

    // 2. 为每个课程获取视频和学习进度
    const coursesWithProgress = await Promise.all(
      allCourses.map(async (course) => {
        // 获取课程下的所有视频
        const videosResponse = await axios.get(`/api/courses/${course.id}/videos`)
        const videos = videosResponse.data

        // 获取每个视频的学习进度
        const videosWithProgress = await Promise.all(
          videos.map(async (video) => {
            try {
              const progressResponse = await axios.get(`/api/learning/progress`, {
                params: {
                  userId: getUserId(),
                  videoId: video.id,
                },
              })
              console.log(progressResponse)
              return {
                ...video,
                progress: progressResponse.data?.progress || 0,
                durationLearned: progressResponse.data?.durationLearned || 0,
                isCompleted: progressResponse.data?.isCompleted || false,
              }
            } catch (error) {
              console.error(`获取视频 ${video.id} 进度失败:`, error)
              return {
                ...video,
                progress: 0,
                durationLearned: 0,
                isCompleted: false,
              }
            }
          }),
        )

        // 计算课程整体进度
        const completedVideos = videosWithProgress.filter((v) => v.isCompleted).length
        const totalVideos = videosWithProgress.length
        const progress = totalVideos > 0 ? Math.round((completedVideos / totalVideos) * 100) : 0

        return {
          ...course,
          videos: videosWithProgress,
          progress,
          completedVideos,
          totalVideos,
        }
      }),
    )

    courses.value = coursesWithProgress
  } catch (error) {
    console.error('获取学习进度失败:', error)
  } finally {
    loading.value = false
  }
}

// 获取当前用户ID（根据您的认证系统调整）
const getUserId = () => {
  // 示例：从localStorage或Vuex获取用户ID
  const user = JSON.parse(localStorage.getItem('user'))
  return user?.id || 1 // 默认为1，实际应用中应该处理未登录情况
}

// 跳转到视频播放页
const goToVideo = (videoId) => {
  router.push(`/video/${videoId}`)
}

// 格式化时间显示
const formatDuration = (seconds) => {
  if (!seconds) return '00:00'
  const mins = Math.floor(seconds / 60)
  const secs = Math.floor(seconds % 60)
  return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
}

const formatTime = (seconds) => {
  if (!seconds) return '0秒'
  const mins = Math.floor(seconds / 60)
  const secs = Math.floor(seconds % 60)
  return mins > 0 ? `${mins}分${secs}秒` : `${secs}秒`
}

onMounted(() => {
  fetchLearningProgress()
})
</script>

<style scoped>
.learning-progress-page {
  background-color: #f5f5f5;
  min-height: 100vh;
}

.main-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.page-title {
  font-size: 28px;
  margin-bottom: 30px;
  color: #333;
}

.course-list {
  display: grid;
  gap: 25px;
}

.course-card {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  transition: transform 0.2s;
}

.course-card:hover {
  transform: translateY(-3px);
}

.course-header {
  display: flex;
  padding: 20px;
  border-bottom: 1px solid #eee;
}

.course-cover {
  width: 200px;
  height: 120px;
  object-fit: cover;
  border-radius: 4px;
  margin-right: 20px;
}

.course-info {
  flex: 1;
}

.course-title {
  font-size: 20px;
  margin: 0 0 10px 0;
  color: #333;
}

.course-description {
  color: #666;
  margin: 0;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.progress-container {
  padding: 15px 20px;
  background-color: #f9f9f9;
}

.progress-bar {
  height: 8px;
  background-color: #e0e0e0;
  border-radius: 4px;
  margin-bottom: 8px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background-color: #4caf50;
  border-radius: 4px;
  transition: width 0.3s ease;
}

.progress-text {
  font-size: 14px;
  color: #666;
}

.video-list {
  padding: 15px 20px;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 15px;
}

.video-item {
  border: 1px solid #eee;
  border-radius: 6px;
  overflow: hidden;
  transition: transform 0.2s;
}

.video-item:hover {
  transform: translateY(-3px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.video-thumbnail {
  position: relative;
  cursor: pointer;
}

.video-thumbnail .video-progress {
  position: absolute;
  bottom: 0;
  left: 0;
  height: 3px;
  background-color: #4caf50;
}

/* 视频详情中的进度文本 */
.video-progress-text {
  color: #4caf50;
  font-weight: 500;
}

.video-thumbnail img {
  width: 100%;
  height: 140px;
  object-fit: cover;
}

.video-duration {
  position: absolute;
  bottom: 5px;
  right: 5px;
  background-color: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 2px 6px;
  border-radius: 3px;
  font-size: 12px;
}

.video-progress {
  position: absolute;
  bottom: 0;
  left: 0;
  height: 3px;
  background-color: #4caf50;
}

.completed-badge {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 40px;
  height: 40px;
  background-color: rgba(76, 175, 80, 0.9);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.completed-badge svg {
  width: 24px;
  height: 24px;
  fill: white;
}

.video-details {
  padding: 12px;
}

.video-title {
  font-size: 16px;
  margin: 0 0 8px 0;
  color: #333;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.video-meta {
  display: flex;
  justify-content: space-between;
  font-size: 13px;
  color: #666;
}

.loading-state {
  text-align: center;
  padding: 50px 0;
}

.spinner {
  width: 40px;
  height: 40px;
  margin: 0 auto 20px;
  border: 4px solid rgba(0, 0, 0, 0.1);
  border-left-color: #4caf50;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.empty-state {
  text-align: center;
  padding: 50px 20px;
  color: #666;
}

.empty-state svg {
  width: 60px;
  height: 60px;
  margin-bottom: 20px;
  color: #bdbdbd;
}

.explore-btn {
  display: inline-block;
  margin-top: 20px;
  padding: 10px 20px;
  background-color: #4caf50;
  color: white;
  text-decoration: none;
  border-radius: 4px;
  transition: background-color 0.2s;
}

.explore-btn:hover {
  background-color: #3d8b40;
}

@media (max-width: 768px) {
  .course-header {
    flex-direction: column;
  }

  .course-cover {
    width: 100%;
    margin-right: 0;
    margin-bottom: 15px;
  }

  .video-list {
    grid-template-columns: 1fr;
  }
}
</style>
