<template>
  <Header />
  <div class="daily-learning-container">
    <!-- 顶部信息卡片 -->
    <div class="summary-card">
      <div class="summary-content">
        <div class="date-section">
          <div class="weekday">{{ weekday }}</div>
          <div class="date">{{ formattedDate }}</div>
        </div>
        <div class="stats-section">
          <div class="stat-item">
            <div class="stat-icon">
              <svg viewBox="0 0 24 24">
                <path
                  d="M18 4l2 4h-3l-2-4h-2l2 4h-3l-2-4H8l2 4H7L5 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V4h-4z"
                />
              </svg>
            </div>
            <div class="stat-info">
              <span class="stat-value">{{ totalVideos }}</span>
              <span class="stat-label">学习视频</span>
            </div>
          </div>
          <div class="stat-item">
            <div class="stat-icon">
              <svg viewBox="0 0 24 24">
                <path
                  d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"
                />
                <path d="M12.5 7H11v6l5.25 3.15.75-1.23-4.5-2.67z" />
              </svg>
            </div>
            <div class="stat-info">
              <span class="stat-value">{{ formatTime(totalDuration) }}</span>
              <span class="stat-label">学习时长</span>
            </div>
          </div>
          <div class="stat-item">
            <div class="stat-icon">
              <svg viewBox="0 0 24 24">
                <path d="M9 16.2L4.8 12l-1.4 1.4L9 19 21 7l-1.4-1.4L9 16.2z" />
              </svg>
            </div>
            <div class="stat-info">
              <span class="stat-value">{{ completedCount }}</span>
              <span class="stat-label">已完成</span>
            </div>
          </div>
        </div>
      </div>
      <div class="motivation-section">
        <p>{{ motivationQuote }}</p>
      </div>
    </div>

    <!-- 学习内容区域 -->
    <div class="content-section">
      <h2 class="section-title">
        <svg viewBox="0 0 24 24">
          <path
            d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"
          />
        </svg>
        今日学习内容
      </h2>

      <!-- 视频列表 -->
      <div v-if="!loading && videos.length > 0" class="video-grid">
        <div v-for="video in videos" :key="video.id" class="video-card">
          <div
            class="video-thumbnail"
            :style="{ backgroundImage: `url(${video.coverImage || defaultThumbnail})` }"
          >
            <div class="video-overlay">
              <div class="video-duration">{{ formatTime(video.duration) }}</div>
              <div class="video-progress-container">
                <div class="video-progress" :style="{ width: `${video.progress}%` }"></div>
              </div>
              <button v-if="!video.isCompleted" class="play-button" @click="playVideo(video)">
                <svg viewBox="0 0 24 24">
                  <path d="M8 5v14l11-7z" fill="currentColor" />
                </svg>
              </button>
              <div v-else class="completed-badge">
                <svg viewBox="0 0 24 24">
                  <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z" fill="currentColor" />
                </svg>
              </div>
            </div>
          </div>
          <div class="video-details">
            <h3 class="video-title">{{ video.title }}</h3>
            <div class="video-meta">
              <span class="meta-item">
                <svg viewBox="0 0 24 24">
                  <path
                    d="M12 2C6.5 2 2 6.5 2 12s4.5 10 10 10 10-4.5 10-10S17.5 2 12 2zm-1 14H9V8h2v8zm4 0h-2V8h2v8z"
                  />
                </svg>
                {{ formatDateTime(video.lastPlayTime) }}
              </span>
              <span class="meta-item">
                <svg viewBox="0 0 24 24">
                  <path d="M9 16.2L4.8 12l-1.4 1.4L9 19 21 7l-1.4-1.4L9 16.2z" />
                </svg>
                {{ video.progress }}% 完成
              </span>
            </div>
            <div class="video-actions">
              <button class="action-btn review-btn" @click="reviewVideo(video)">
                <svg viewBox="0 0 24 24">
                  <path
                    d="M12 5V1L7 6l5 5V7c3.31 0 6 2.69 6 6s-2.69 6-6 6-6-2.69-6-6H4c0 4.42 3.58 8 8 8s8-3.58 8-8-3.58-8-8-8z"
                  />
                </svg>
                复习
              </button>
              <button class="action-btn continue-btn" @click="continueVideo(video)">
                <svg viewBox="0 0 24 24">
                  <path d="M8 5v14l11-7z" />
                </svg>
                继续
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- 加载状态 -->
      <div v-if="loading" class="loading-state">
        <div class="spinner"></div>
        <p>正在加载学习记录...</p>
      </div>

      <!-- 空状态 -->
      <div v-if="!loading && videos.length === 0" class="empty-state">
        <div class="empty-illustration">
          <svg viewBox="0 0 200 200">
            <circle cx="100" cy="100" r="80" fill="#F5F7FA" />
            <path d="M60,70 Q100,30 140,70" fill="none" stroke="#D1D9E6" stroke-width="8" />
            <circle cx="80" cy="60" r="8" fill="#D1D9E6" />
            <circle cx="120" cy="60" r="8" fill="#D1D9E6" />
            <path d="M70,120 Q100,150 130,120" fill="none" stroke="#D1D9E6" stroke-width="8" />
          </svg>
        </div>
        <h3>今天还没有学习记录</h3>
        <p>开始你的学习之旅，记录每一天的进步</p>
        <button class="start-learning-btn" @click="startLearning">
          <svg viewBox="0 0 24 24">
            <path
              d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 14.5v-9l6 4.5-6 4.5z"
            />
          </svg>
          开始学习
        </button>
      </div>
    </div>

    <!-- 学习建议卡片 -->
    <div class="suggestion-card">
      <h3 class="suggestion-title">
        <svg viewBox="0 0 24 24">
          <path
            d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z"
          />
        </svg>
        学习建议
      </h3>
      <ul class="suggestion-list">
        <li>每天固定时间学习，形成习惯</li>
        <li>学习新内容前先复习前一天的知识</li>
        <li>每学习45分钟休息5分钟</li>
        <li>尝试用自己的话总结学习内容</li>
      </ul>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from 'axios'
import Header from './tools/Header.vue'
import { useRouter } from 'vue-router'

const defaultThumbnail = 'https://via.placeholder.com/300x170?text=No+Thumbnail'

// 响应式数据
const router = useRouter()
const videos = ref([])
const loading = ref(true)
const userId = ref(1) // 实际应用中应从用户登录状态获取
const motivationQuotes = [
  '学如逆水行舟，不进则退',
  '不积跬步，无以至千里',
  '今天的努力是明天的实力',
  '学习是最好的投资',
  '知识就是力量',
]
const motivationQuote = ref(motivationQuotes[Math.floor(Math.random() * motivationQuotes.length)])

// 计算属性
const totalVideos = computed(() => videos.value.length)
const completedCount = computed(() => videos.value.filter((v) => v.isCompleted).length)
const totalDuration = computed(() => {
  return videos.value.reduce((sum, video) => {
    return (
      sum +
      (video.isCompleted ? video.duration : Math.floor((video.duration * video.progress) / 100))
    )
  }, 0)
})

const weekday = computed(() => {
  return new Date().toLocaleDateString('zh-CN', { weekday: 'long' })
})

const formattedDate = computed(() => {
  return new Date().toLocaleDateString('zh-CN', { year: 'numeric', month: 'long', day: 'numeric' })
})

// 方法
const formatTime = (seconds) => {
  const hrs = Math.floor(seconds / 3600)
  const mins = Math.floor((seconds % 3600) / 60)
  const secs = seconds % 60

  if (hrs > 0) {
    return `${hrs}小时${mins}分钟`
  } else if (mins > 0) {
    return `${mins}分钟${secs}秒`
  } else {
    return `${secs}秒`
  }
}

const formatDateTime = (datetime) => {
  if (!datetime) return ''
  const date = new Date(datetime)
  return date.toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit' })
}

const playVideo = (video) => {
  alert(video.coverImage)
  router.push(`/video/${video.id}`)
}

const reviewVideo = (video) => {
  alert(video.coverImage)
  router.push(`/video/${video.id}`)
}

const continueVideo = (video) => {
  alert(video.coverImage)
  router.push(`/video/${video.id}`)
}

const startLearning = () => {
  alert(video.coverImage)
  router.push(`/video/${video.id}`)
}

const fetchTodayLearningVideos = async () => {
  try {
    loading.value = true
    const today = new Date()
      .toLocaleDateString('zh-CN', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
      })
      .replace(/\//g, '-')

    // 调用后端API获取今天的学习记录
    const response = await axios.get(`/api/learning/today`, {
      params: {
        userId: userId.value,
        date: today,
      },
    })

    // 处理返回的数据
    videos.value = response.data.map((item) => ({
      id: item.video.id,
      title: item.video.title,
      duration: item.video.duration,
      coverImage: item.video.coverImage,
      progress: item.learning.progress,
      isCompleted: item.learning.isCompleted,
      lastPlayTime: item.learning.lastPlayTime,
      durationLearned: item.learning.durationLearned,
      startTime: item.learning.startTime,
      endTime: item.learning.endTime,
    }))
  } catch (error) {
    console.error('获取学习记录失败:', error)
    alert('获取学习记录失败，请稍后重试')
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchTodayLearningVideos()
})
</script>

<style scoped>
.daily-learning-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: 'PingFang SC', 'Microsoft YaHei', sans-serif;
  color: #333;
  background-color: rgb(248, 250, 250);
}

/* 顶部摘要卡片 */
.summary-card {
  background: white;
  border-radius: 12px;
  padding: 24px;
  margin-bottom: 24px;
  color: #2c3e50;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  border: 1px solid rgba(0, 0, 0, 0.05);
}

.summary-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.date-section {
  display: flex;
  flex-direction: column;
}

.weekday {
  font-size: 16px;
  font-weight: 500;
  margin-bottom: 4px;
  color: #7f8c8d;
}

.date {
  font-size: 22px;
  font-weight: 600;
  color: #2c3e50;
}

.stats-section {
  display: flex;
  gap: 24px;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 12px;
}

.stat-icon {
  width: 36px;
  height: 36px;
  background-color: rgb(248, 250, 250);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid rgba(0, 0, 0, 0.05);
}

.stat-icon svg {
  width: 18px;
  height: 18px;
  fill: #4a6bdf;
}

.stat-info {
  display: flex;
  flex-direction: column;
}

.stat-value {
  font-size: 18px;
  font-weight: 600;
  color: #2c3e50;
}

.stat-label {
  font-size: 13px;
  color: #7f8c8d;
}

.motivation-section {
  font-size: 15px;
  font-style: italic;
  text-align: center;
  padding: 12px;
  background-color: rgb(248, 250, 250);
  border-radius: 8px;
  color: #4a6bdf;
  border: 1px dashed rgba(74, 107, 223, 0.3);
}

/* 内容区域 */
.content-section {
  background-color: white;
  border-radius: 12px;
  padding: 24px;
  margin-bottom: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  border: 1px solid rgba(0, 0, 0, 0.05);
}

.section-title {
  font-size: 18px;
  font-weight: 600;
  margin: 0 0 20px 0;
  display: flex;
  align-items: center;
  gap: 10px;
  color: #2c3e50;
}

.section-title svg {
  width: 22px;
  height: 22px;
  fill: #4a6bdf;
}

/* 视频网格 */
.video-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 16px;
}

.video-card {
  background-color: white;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
  transition:
    transform 0.3s ease,
    box-shadow 0.3s ease;
  border: 1px solid rgba(0, 0, 0, 0.05);
}

.video-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.video-thumbnail {
  position: relative;
  width: 100%;
  height: 0;
  padding-bottom: 56.25%; /* 16:9 比例 */
  background-size: cover;
  background-position: center;
}

.video-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.5) 0%, rgba(0, 0, 0, 0) 50%);
}

.video-duration {
  position: absolute;
  bottom: 10px;
  right: 10px;
  padding: 3px 6px;
  background-color: rgba(0, 0, 0, 0.7);
  color: white;
  font-size: 11px;
  border-radius: 3px;
}

.video-progress-container {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 3px;
  background-color: rgba(255, 255, 255, 0.2);
}

.video-progress {
  height: 100%;
  background-color: #4a6bdf;
  border-radius: 0 3px 3px 0;
}

.play-button,
.completed-badge {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 44px;
  height: 44px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
}

.play-button {
  background-color: rgba(255, 255, 255, 0.9);
  color: #4a6bdf;
  box-shadow: 0 2px 8px rgba(74, 107, 223, 0.2);
}

.play-button:hover {
  transform: translate(-50%, -50%) scale(1.05);
}

.completed-badge {
  background-color: rgba(46, 204, 113, 0.9);
  color: white;
}

.play-button svg,
.completed-badge svg {
  width: 20px;
  height: 20px;
}

.video-details {
  padding: 14px;
}

.video-title {
  font-size: 15px;
  font-weight: 600;
  margin: 0 0 10px 0;
  color: #2c3e50;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  min-height: 36px;
}

.video-meta {
  display: flex;
  gap: 12px;
  margin-bottom: 14px;
  font-size: 12px;
  color: #7f8c8d;
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 4px;
}

.meta-item svg {
  width: 13px;
  height: 13px;
  fill: #7f8c8d;
}

.video-actions {
  display: flex;
  gap: 8px;
}

.action-btn {
  flex: 1;
  padding: 7px 10px;
  border: none;
  border-radius: 5px;
  font-size: 13px;
  font-weight: 500;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 5px;
  transition: all 0.2s ease;
}

.action-btn svg {
  width: 14px;
  height: 14px;
}

.review-btn {
  background-color: rgb(248, 250, 250);
  color: #4a6bdf;
}

.review-btn:hover {
  background-color: #e2e8f0;
}

.continue-btn {
  background-color: #4a6bdf;
  color: white;
}

.continue-btn:hover {
  background-color: #3a56c7;
}

/* 加载状态 */
.loading-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px 0;
}

.spinner {
  width: 40px;
  height: 40px;
  border: 3px solid rgb(248, 250, 250);
  border-top: 3px solid #4a6bdf;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 16px;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

.loading-state p {
  color: #7f8c8d;
  font-size: 14px;
}

/* 空状态 */
.empty-state {
  text-align: center;
  padding: 30px 20px;
}

.empty-illustration {
  width: 120px;
  height: 120px;
  margin: 0 auto 16px;
}

.empty-state h3 {
  font-size: 16px;
  color: #2c3e50;
  margin-bottom: 8px;
}

.empty-state p {
  color: #7f8c8d;
  margin-bottom: 16px;
  font-size: 14px;
}

.start-learning-btn {
  padding: 10px 20px;
  background-color: #4a6bdf;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  transition: all 0.2s ease;
}

.start-learning-btn:hover {
  background-color: #3a56c7;
}

.start-learning-btn svg {
  width: 18px;
  height: 18px;
  fill: white;
}

/* 学习建议卡片 */
.suggestion-card {
  background-color: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  border: 1px solid rgba(0, 0, 0, 0.05);
}

.suggestion-title {
  font-size: 16px;
  font-weight: 600;
  margin: 0 0 14px 0;
  display: flex;
  align-items: center;
  gap: 8px;
  color: #2c3e50;
}

.suggestion-title svg {
  width: 18px;
  height: 18px;
  fill: #4a6bdf;
}

.suggestion-list {
  list-style-type: none;
  padding: 0;
  margin: 0;
}

.suggestion-list li {
  padding: 8px 0;
  border-bottom: 1px solid rgb(248, 250, 250);
  display: flex;
  align-items: center;
}

.suggestion-list li:before {
  content: '•';
  color: #4a6bdf;
  font-weight: bold;
  display: inline-block;
  width: 1em;
  margin-left: -1em;
}

.suggestion-list li:last-child {
  border-bottom: none;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .summary-content {
    flex-direction: column;
    align-items: flex-start;
    gap: 16px;
  }

  .stats-section {
    width: 100%;
    justify-content: space-between;
    gap: 12px;
  }

  .video-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 480px) {
  .stat-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 4px;
  }

  .video-actions {
    flex-direction: column;
  }
}
</style>
