<template>
  <div class="video-detail-page">
    <Header />
    <div class="main-content">
      <!-- 返回按钮 -->
      <button class="back-button" @click="goBack">
        <svg viewBox="0 0 24 24" width="20" height="20" fill="#61666d">
          <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"></path>
        </svg>
        返回
      </button>

      <!-- 学习进度指示器 -->
      <div class="progress-indicator" v-if="currentProgress > 0">
        学习进度: {{ currentProgress }}% (已观看 {{ formatTime(durationLearned) }})
      </div>

      <!-- 视频播放区域 -->
      <div class="video-player-container">
        <div class="video-player">
          <video
            ref="videoPlayer"
            :src="video.videoUrl"
            controls
            autoplay
            class="video-element"
            @pause="handlePause"
            @play="handlePlay"
          ></video>
        </div>
      </div>

      <!-- 视频信息区域 -->
      <div class="video-info">
        <h1 class="video-title">{{ video.title }}</h1>

        <div class="video-meta">
          <div class="video-stats">
            <span class="stat-item">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="#61666d">
                <path
                  d="M12 5V1L7 6l5 5V7c3.31 0 6 2.69 6 6s-2.69 6-6 6-6-2.69-6-6H4c0 4.42 3.58 8 8 8s8-3.58 8-8-3.58-8-8-8z"
                ></path>
              </svg>
              {{ video.views }}播放
            </span>
            <span class="stat-item">{{ video.uploadTime }}</span>
          </div>
        </div>

        <div class="video-description">
          <h3>视频简介</h3>
          <p>{{ video.description || '暂无简介' }}</p>
        </div>

        <!-- 相关推荐 -->
        <div class="recommendations">
          <h3 class="section-title">相关推荐</h3>
          <div class="recommend-list">
            <VideoCard v-for="(video, index) in recommendedVideos" :key="index" :video="video" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Header from './tools/Header.vue'
import VideoCard from './tools/VideoCard.vue'
import axios from 'axios'

export default {
  components: {
    Header,
    VideoCard,
  },
  props: {
    id: {
      type: [String, Number],
      required: true,
    },
  },
  data() {
    return {
      video: {
        id: 0,
        title: '',
        videoUrl: '',
        cover: '',
        duration: 0,
        views: 0,
        uploadTime: '',
        description: '',
      },
      recommendedVideos: [],
      currentProgress: 0,
      durationLearned: 0,
      videoPlayer: null,
      progressInterval: null,
      lastUpdateTime: null,
      isCompleted: false,
      isPlaying: false,
      lastSaveTime: null,
      unsavedProgress: null,
    }
  },
  async created() {
    await this.fetchVideoData()
    this.fetchRecommendedVideos()
    // 尝试从本地存储恢复进度
    this.restoreProgressFromLocalStorage()
  },
  mounted() {
    this.$nextTick(() => {
      this.videoPlayer = this.$refs.videoPlayer
      this.setupVideoTracking()
    })

    // 监听页面可见性变化
    document.addEventListener('visibilitychange', this.handleVisibilityChange)

    // 监听beforeunload事件
    window.addEventListener('beforeunload', this.handleBeforeUnload)
  },
  beforeUnmount() {
    this.cleanupVideoTracking()
    this.sendLearningProgress(true) // 页面卸载时发送进度
    // 移除事件监听器
    document.removeEventListener('visibilitychange', this.handleVisibilityChange)
    window.removeEventListener('beforeunload', this.handleBeforeUnload)
  },
  methods: {
    goBack() {
      this.$router.go(-1)
    },
    setupVideoTracking() {
      if (!this.videoPlayer) return

      this.lastUpdateTime = new Date()
      this.lastSaveTime = new Date()

      // 事件监听
      this.videoPlayer.addEventListener('timeupdate', this.handleTimeUpdate)
      this.videoPlayer.addEventListener('ended', this.handleVideoEnded)
      this.videoPlayer.addEventListener('loadedmetadata', this.handleLoadedMetadata)

      // 定期保存进度
      this.progressInterval = setInterval(() => {
        this.sendLearningProgress(false)
      }, 10000) // 每10秒自动保存一次
    },
    cleanupVideoTracking() {
      if (!this.videoPlayer) return

      this.videoPlayer.removeEventListener('timeupdate', this.handleTimeUpdate)
      this.videoPlayer.removeEventListener('ended', this.handleVideoEnded)
      this.videoPlayer.removeEventListener('loadedmetadata', this.handleLoadedMetadata)

      if (this.progressInterval) {
        clearInterval(this.progressInterval)
      }
    },
    handleLoadedMetadata() {
      // 视频元数据加载完成后，尝试恢复播放位置
      if (this.currentProgress > 0 && this.videoPlayer) {
        this.videoPlayer.currentTime = (this.currentProgress / 100) * this.videoPlayer.duration
      }
    },
    handleTimeUpdate() {
      if (!this.videoPlayer) return

      const now = new Date()
      const timeDiff = (now - this.lastUpdateTime) / 1000 // 秒

      // 只有在播放状态才计算学习时长
      // if (this.isPlaying) {
      //   this.durationLearned += Math.floor(timeDiff)
      // }

      if (this.lastUpdateTime) {
        const timeDiff = (now - this.lastUpdateTime) / 1000

        // 只有在播放状态才计算为有效学习时长
        if (this.isPlaying && timeDiff < 5) {
          // 限制最大间隔防止异常值
          this.durationLearned += timeDiff

          // 同步到本地存储
          localStorage.setItem(
            `videoProgress_${this.video.id}_duration`,
            this.durationLearned.toString(),
          )
        }
      }
      this.lastUpdateTime = now

      // 计算当前进度百分比
      if (this.videoPlayer.duration > 0) {
        this.currentProgress = Math.min(
          Math.floor((this.videoPlayer.currentTime / this.videoPlayer.duration) * 100),
          100,
        )
      }

      this.lastUpdateTime = now

      // 如果进度变化超过5%或10秒未保存，则标记需要保存
      if (
        Math.abs(this.currentProgress - (this.unsavedProgress || 0)) > 5 ||
        now - this.lastSaveTime > 10000
      ) {
        this.unsavedProgress = this.currentProgress
        this.sendLearningProgress(false)
      }
    },
    handlePlay() {
      this.isPlaying = true
      this.lastUpdateTime = new Date()
    },
    handlePause() {
      this.isPlaying = false
      this.sendLearningProgress(false)
    },
    handleVideoEnded() {
      this.isCompleted = true
      this.currentProgress = 100
      this.sendLearningProgress(true)
    },
    handleVisibilityChange() {
      if (document.visibilityState === 'hidden') {
        // 页面隐藏时立即保存进度
        this.sendLearningProgress(true)
      }
    },
    handleBeforeUnload(event) {
      // 在页面关闭前确保进度已保存
      if (this.unsavedProgress !== null) {
        this.sendLearningProgressSync() // 同步发送请求
      }
    },
    async sendLearningProgress(isFinal) {
      try {
        // 获取当前用户ID（根据你的认证系统调整）
        const user = localStorage.getItem('user')
        const userId = user.id || 1 // 示例，请替换为实际用户ID获取方式

        const response = await axios.put('/api/learning/video-progress', {
          userId: userId,
          videoId: this.video.id,
          progress: this.currentProgress,
          isCompleted: this.isCompleted,
          durationLearned: this.durationLearned,
        })

        this.lastSaveTime = new Date()
        this.unsavedProgress = null

        // 保存到本地存储
        this.saveProgressToLocalStorage()

        if (isFinal) {
          console.log('学习进度已保存')
        }

        return response
      } catch (error) {
        console.error('保存学习进度失败:', error)
        // 保存到本地，待网络恢复后重试
        this.saveProgressToLocalStorage()
        throw error
      }
    },
    sendLearningProgressSync() {
      // 使用navigator.sendBeacon同步发送请求
      const userId = this.$store.state.user?.id || 1
      const data = new Blob(
        [
          JSON.stringify({
            userId: userId,
            videoId: this.video.id,
            progress: this.currentProgress,
            isCompleted: this.isCompleted,
            durationLearned: this.durationLearned,
          }),
        ],
        { type: 'application/json' },
      )

      navigator.sendBeacon('http://localhost:8105/api/learning/video-progress', data)
    },
    saveProgressToLocalStorage() {
      localStorage.setItem(
        `videoProgress_${this.video.id}`,
        JSON.stringify({
          progress: this.currentProgress,
          durationLearned: this.durationLearned,
          isCompleted: this.isCompleted,
          lastUpdated: new Date().toISOString(),
        }),
      )
    },
    restoreProgressFromLocalStorage() {
      const savedProgress = localStorage.getItem(`videoProgress_${this.id}`)
      if (savedProgress) {
        try {
          const progressData = JSON.parse(savedProgress)
          this.currentProgress = progressData.progress || 0
          this.durationLearned = progressData.durationLearned || 0
          this.isCompleted = progressData.isCompleted || false
        } catch (e) {
          console.error('恢复进度失败:', e)
        }
      }
    },
    formatTime(seconds) {
      if (!seconds) return '00:00'
      const mins = Math.floor(seconds / 60)
      const secs = Math.floor(seconds % 60)
      return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
    },
    async fetchVideoData() {
      try {
        const response = await axios.get(`/api/videos/${this.id}`)
        const videoData = response.data

        this.video = {
          id: videoData.id,
          title: videoData.title,
          videoUrl: videoData.videoPath,
          cover: videoData.coverImage || 'https://placeholder.com/default-cover.jpg',
          duration: videoData.duration,
          views: this.formatViews(videoData.views || 0),
          uploadTime: this.formatDate(videoData.uploadTime),
          description: videoData.description,
        }
      } catch (error) {
        console.error('获取视频详情失败:', error)
      }
    },
    async fetchRecommendedVideos() {
      try {
        const response = await axios.get('/api/videos', {
          params: {
            page: 0,
            size: 4,
            exclude: this.id,
          },
        })

        this.recommendedVideos = response.data.content.map((video) => ({
          id: video.id,
          title: video.title,
          cover: video.coverImage || 'https://placeholder.com/default-cover.jpg',
          duration: this.formatDuration(video.duration),
          views: this.formatViews(video.views || 0),
          link: `/video/${video.id}`,
        }))
      } catch (error) {
        console.error('获取推荐视频失败:', error)
      }
    },
    formatDuration(seconds) {
      if (!seconds) return '00:00'
      const mins = Math.floor(seconds / 60)
      const secs = Math.floor(seconds % 60)
      return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
    },
    formatViews(count) {
      if (typeof count === 'string') return count
      if (count >= 10000) {
        return `${(count / 10000).toFixed(1)}万`
      }
      return count.toString()
    },
    formatDate(dateString) {
      if (!dateString) return ''
      const date = new Date(dateString)
      return date.toLocaleDateString() + ' ' + date.toLocaleTimeString()
    },
  },
}
</script>

<style scoped>
.video-detail-page {
  background-color: #f4f4f4;
  min-height: 100vh;
}

.main-content {
  max-width: 1400px;
  margin: 0 auto;
  padding: 20px;
}

.back-button {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 8px 16px;
  background-color: #fff;
  border: 1px solid #e5e5e5;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
  margin-bottom: 20px;
  transition: all 0.2s;
}

.back-button:hover {
  background-color: #f5f5f5;
  border-color: #d9d9d9;
}

.progress-indicator {
  background-color: #fff;
  padding: 8px 16px;
  border-radius: 4px;
  margin-bottom: 16px;
  font-size: 14px;
  color: #666;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.video-player-container {
  background-color: #000;
  border-radius: 8px;
  overflow: hidden;
  margin-bottom: 20px;
}

.video-player {
  position: relative;
  width: 100%;
  padding-top: 56.25%; /* 16:9 宽高比 */
}

.video-element {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  outline: none;
}

.video-info {
  background-color: #fff;
  border-radius: 8px;
  padding: 24px;
  margin-bottom: 20px;
  max-width: 100%;
}

.video-title {
  font-size: 24px;
  margin: 0 0 20px 0;
  color: #18191c;
  line-height: 1.3;
}

.video-meta {
  margin-bottom: 20px;
}

.video-stats {
  display: flex;
  gap: 20px;
  color: #61666d;
  font-size: 14px;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 6px;
}

.video-description h3 {
  font-size: 18px;
  margin: 0 0 12px 0;
  color: #61666d;
}

.video-description p {
  font-size: 16px;
  line-height: 1.7;
  color: #18191c;
  white-space: pre-line;
  margin-bottom: 30px;
}

.recommendations {
  margin-top: 30px;
}

.section-title {
  font-size: 20px;
  margin: 0 0 20px 0;
  color: #18191c;
}

.recommend-list {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
}

@media (max-width: 1200px) {
  .recommend-list {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (max-width: 900px) {
  .recommend-list {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 600px) {
  .recommend-list {
    grid-template-columns: 1fr;
  }

  .main-content {
    padding: 15px;
  }

  .video-info {
    padding: 18px;
  }

  .video-title {
    font-size: 20px;
  }
}
</style>
