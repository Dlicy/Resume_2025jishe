<template>
  <div class="app">
    <Header />
    <div class="course-detail">
      <!-- 课程封面和基本信息 -->
      <div class="course-header">
        <img :src="course.coverImage || '/default-course-cover.jpg'" class="course-cover" />
        <div class="course-info">
          <h1>{{ course.title }}</h1>
          <p class="description">{{ course.description || '暂无描述' }}</p>
          <div class="meta">
            <span>创建者: {{ course.creatorId }}</span>
            <span>创建时间: {{ formatDate(course.createTime) }}</span>
          </div>

          <!-- 加入/退出课程按钮和学习进度 -->
          <div class="course-actions">
            <button v-if="!isEnrolled" class="join-btn" @click="joinCourse">加入课程</button>
            <div v-else class="enrolled-status">
              <div class="progress-container">
                <div class="progress-text">学习进度: {{ learningProgress }}%</div>
                <div class="progress-bar">
                  <div class="progress-fill" :style="{ width: learningProgress + '%' }"></div>
                </div>
              </div>
              <button class="quit-btn" @click="quitCourse">退出课程</button>
            </div>
          </div>
        </div>
      </div>

      <!-- 视频列表部分 -->
      <div class="video-section">
        <h2>课程视频 ({{ videos.length }}个)</h2>
        <div class="video-list">
          <div
            v-for="video in videos"
            :key="video.id"
            class="video-item"
            @click="goToVideo(video.id)"
          >
            <div class="video-thumbnail">
              <img :src="video.coverImage || '/default-video-cover.jpg'" />
              <div class="duration">{{ formatDuration(video.duration) }}</div>
              <div
                v-if="isEnrolled && videoProgress[video.id]"
                class="video-progress"
                :style="{ width: videoProgress[video.id].progress + '%' }"
              ></div>
            </div>
            <div class="video-info">
              <h3>{{ video.title }}</h3>
              <p>{{ video.views }}次观看</p>
              <div v-if="isEnrolled && videoProgress[video.id]" class="video-status">
                {{ videoProgress[video.id].isCompleted ? '已完成' : '学习中' }}
              </div>
            </div>
          </div>
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
      course: {},
      videos: [],
      loading: true,
      error: null,
      isEnrolled: false,
      learningProgress: 0,
      videoProgress: {},
      userId: null, // 从登录状态获取
    }
  },
  computed: {
    courseId() {
      return this.$route.params.id
    },
  },
  async created() {
    // 获取当前用户ID (根据你的认证系统调整)
    this.userId = localStorage.getItem('userId') || 1 // 示例，请替换为实际获取方式

    await this.fetchCourse()
    await this.fetchVideos()
    await this.checkEnrollment()
    if (this.isEnrolled) {
      await this.fetchLearningProgress()
    }
  },
  methods: {
    async fetchCourse() {
      try {
        const response = await axios.get(`/api/courses/${this.courseId}`)
        this.course = response.data
      } catch (error) {
        console.error('获取课程详情失败:', error)
        this.error = error.message || '获取课程详情失败'
      }
    },
    async fetchVideos() {
      try {
        const response = await axios.get(`/api/courses/${this.courseId}/videos`)
        this.videos = response.data
      } catch (error) {
        console.error('获取课程视频失败:', error)
      } finally {
        this.loading = false
      }
    },
    async checkEnrollment() {
      try {
        const response = await axios.get(`/api/courses/${this.courseId}/enrollment-status`, {
          params: { userId: this.userId },
        })

        // 正确设置 enrolled 状态
        this.isEnrolled = response.data.isEnrolled

        if (this.isEnrolled) {
          this.courseLearningData = response.data
          // 获取学习进度
          await this.fetchLearningProgress()
        }

        console.log('Enrollment check:', {
          isEnrolled: this.isEnrolled,
          data: response.data,
        })
      } catch (error) {
        console.error('检查课程报名状态失败:', error)
        this.isEnrolled = false
      }
    },

    async joinCourse() {
      try {
        await axios.post(`/api/courses/${this.courseId}/enroll`, {
          userId: this.userId,
        })

        // 强制刷新状态
        await this.checkEnrollment()

        this.$message.success('成功加入课程')
      } catch (error) {
        console.error('加入课程失败:', error)
        this.$message.error('加入课程失败: ' + (error.response?.data?.message || error.message))
      }
    },

    async fetchLearningProgress() {
      try {
        // 1. 获取所有视频的学习进度
        const response = await axios.get(`/api/courses/${this.courseId}/video-progress`, {
          params: { userId: this.userId },
        })

        // 2. 直接使用后端返回的视频进度数据
        this.videoProgress = response.data

        // 3. 前端计算总体进度
        const videoIds = Object.keys(this.videoProgress)
        if (videoIds.length > 0) {
          const completedCount = Object.values(this.videoProgress).filter(
            (v) => v.isCompleted,
          ).length
          this.learningProgress = Math.round((completedCount / videoIds.length) * 100)
        } else {
          this.learningProgress = 0
        }
      } catch (error) {
        console.error('获取学习进度失败:', error)
        this.learningProgress = 0
        this.videoProgress = {}
      }
    },

    async quitCourse() {
      try {
        await axios.delete(`/api/courses/${this.courseId}/quit?userId=${this.userId}`)
        this.isEnrolled = false
        this.learningProgress = 0
        this.videoProgress = {}
        this.$message.success('已退出课程')
      } catch (error) {
        console.error('退出课程失败:', error)
        this.$message.error('退出课程失败: ' + (error.response?.data?.message || error.message))
      }
    },
    goToVideo(videoId) {
      this.$router.push(`/video/${videoId}`)
    },
    formatDate(dateString) {
      if (!dateString) return ''
      const date = new Date(dateString)
      return date.toLocaleDateString()
    },
    formatDuration(seconds) {
      if (!seconds) return '00:00'
      const mins = Math.floor(seconds / 60)
      const secs = seconds % 60
      return `${mins}:${secs.toString().padStart(2, '0')}`
    },
  },
}
</script>
<style scoped>
.course-detail {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.course-header {
  display: flex;
  gap: 30px;
  margin-bottom: 40px;
}

.course-cover {
  width: 300px;
  height: 200px;
  object-fit: cover;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.course-info {
  flex: 1;
}

.course-info h1 {
  margin: 0 0 15px;
  font-size: 28px;
  color: #333;
}

.description {
  margin: 0 0 20px;
  font-size: 16px;
  color: #666;
  line-height: 1.6;
}

.meta {
  display: flex;
  gap: 20px;
  font-size: 14px;
  color: #999;
}

.video-section {
  margin-top: 30px;
}

.video-section h2 {
  margin: 0 0 20px;
  font-size: 22px;
  color: #333;
}

.video-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
}

.video-item {
  cursor: pointer;
  transition: transform 0.2s;
  background: #fff;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.video-item:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.video-thumbnail {
  position: relative;
  width: 100%;
  height: 0;
  padding-bottom: 56.25%; /* 16:9 宽高比 */
  overflow: hidden;
}

.video-thumbnail img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.duration {
  position: absolute;
  right: 8px;
  bottom: 8px;
  background: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 2px 6px;
  border-radius: 4px;
  font-size: 12px;
}

.video-info {
  padding: 12px;
}

.video-info h3 {
  margin: 0 0 8px;
  font-size: 16px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.video-info p {
  margin: 0;
  font-size: 14px;
  color: #999;
}

.course-actions {
  margin-top: 20px;
}

.join-btn,
.quit-btn {
  padding: 8px 16px;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s;
}

.join-btn {
  background-color: #1890ff;
  color: white;
  border: none;
}

.join-btn:hover {
  background-color: #40a9ff;
}

.quit-btn {
  background-color: #fff;
  border: 1px solid #ff4d4f;
  color: #ff4d4f;
  margin-left: 15px;
}

.quit-btn:hover {
  background-color: #fff2f0;
}

.enrolled-status {
  display: flex;
  align-items: center;
}

.progress-container {
  flex: 1;
}

.progress-text {
  font-size: 14px;
  margin-bottom: 5px;
  color: #666;
}

.progress-bar {
  height: 8px;
  background-color: #f5f5f5;
  border-radius: 4px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background-color: #52c41a;
  transition: width 0.3s;
}

.video-progress {
  position: absolute;
  bottom: 0;
  left: 0;
  height: 3px;
  background-color: #52c41a;
}

.video-status {
  font-size: 12px;
  color: #1890ff;
  margin-top: 5px;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .enrolled-status {
    flex-direction: column;
    align-items: flex-start;
  }

  .quit-btn {
    margin-left: 0;
    margin-top: 10px;
  }
}
</style>
