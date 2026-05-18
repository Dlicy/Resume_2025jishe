<template>
  <div class="video-platform">
    <!-- 顶部导航栏 -->
    <header class="header">
      <div class="logo">视频平台</div>
      <div class="search-bar">
        <input
          type="text"
          placeholder="搜索视频..."
          v-model="searchQuery"
          @keyup.enter="searchVideos"
        />
        <button @click="searchVideos">搜索</button>
      </div>
    </header>

    <!-- 主要内容区 -->
    <main class="main-content">
      <!-- 专题部分 -->
      <section class="section courses-section">
        <h2 class="section-title">专题</h2>
        <div class="courses-container">
          <div
            class="course-card"
            v-for="course in courses"
            :key="course.id"
            @click="viewCourse(course.id)"
          >
            <div class="course-cover">
              <img
                :src="course.coverImage || 'https://via.placeholder.com/300x200'"
                :alt="course.title"
                @error="handleImageError"
              />
            </div>
            <div class="course-info">
              <h3 class="course-title">{{ course.title }}</h3>
              <p class="course-desc" v-if="course.description">{{ course.description }}</p>
            </div>
          </div>
        </div>
      </section>

      <!-- 视频部分 -->
      <section class="section videos-section">
        <h2 class="section-title">视频</h2>
        <div class="videos-container">
          <div
            class="video-card"
            v-for="video in videos"
            :key="video.id"
            @click="playVideo(video.id)"
          >
            <div class="video-cover">
              <img
                :src="video.coverImage || 'https://via.placeholder.com/300x200'"
                :alt="video.title"
                @error="handleImageError"
              />
              <div class="video-duration">{{ formatDuration(video.duration) }}</div>
            </div>
            <div class="video-info">
              <h3 class="video-title">{{ video.title }}</h3>
              <p class="video-desc" v-if="video.description">{{ video.description }}</p>
              <div class="video-meta">
                <span class="upload-time">{{ formatDate(video.uploadTime) }}</span>
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>

    <!-- 视频播放模态框 -->
    <div class="video-modal" v-if="showVideoModal">
      <div class="modal-content">
        <button class="close-btn" @click="showVideoModal = false">×</button>
        <video
          v-if="currentVideo"
          controls
          autoplay
          :poster="currentVideo.coverImage || 'https://via.placeholder.com/800x450'"
        >
          <source :src="currentVideo.videoPath" type="video/mp4" />
          您的浏览器不支持 HTML5 视频。
        </video>
        <div class="video-details" v-if="currentVideo">
          <h2>{{ currentVideo.title }}</h2>
          <p>{{ currentVideo.description }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'VideoPlatform',
  data() {
    return {
      courses: [],
      videos: [],
      searchQuery: '',
      showVideoModal: false,
      currentVideo: null,
      currentPage: 1,
      pageSize: 10,
      isLoading: false,
    }
  },
  created() {
    this.fetchCourses()
    this.fetchVideos()
  },
  methods: {
    async fetchCourses() {
      try {
        const response = await axios.get('/api/courses/all')
        console.log(response.data)
        this.courses = response.data
      } catch (error) {
        console.error('获取专题列表失败:', error)
      }
    },
    async fetchVideos() {
      this.isLoading = true
      try {
        const response = await axios.get('/api/videos', {
          params: {
            page: this.currentPage - 1,
            size: this.pageSize,
            title: this.searchQuery,
          },
        })
        this.videos = response.data.content
      } catch (error) {
        console.error('获取视频列表失败:', error)
      } finally {
        this.isLoading = false
      }
    },
    searchVideos() {
      this.currentPage = 1
      this.fetchVideos()
    },
    viewCourse(courseId) {
      // 这里可以跳转到专题详情页或过滤该专题下的视频
      console.log('查看专题:', courseId)
      // 示例：过滤该专题下的视频
      this.searchQuery = ''
      this.currentPage = 1
      this.fetchVideosByCourse(courseId)
    },
    async fetchVideosByCourse(courseId) {
      try {
        const response = await axios.get(`/api/courses/${courseId}`)
        const course = response.data
        // 假设专题对象中包含视频列表
        if (course.videos) {
          this.videos = course.videos
        }
      } catch (error) {
        console.error('获取专题视频失败:', error)
      }
    },
    async playVideo(videoId) {
      try {
        const response = await axios.get(`/api/videos/${videoId}`)
        console.log(response.data)
        this.currentVideo = response.data
        this.showVideoModal = true
      } catch (error) {
        console.error('获取视频详情失败:', error)
      }
    },
    formatDuration(seconds) {
      if (!seconds) return '00:00'
      const mins = Math.floor(seconds / 60)
      const secs = seconds % 60
      return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
    },
    formatDate(dateString) {
      if (!dateString) return ''
      const date = new Date(dateString)
      return date.toLocaleDateString()
    },
    // handleImageError(event) {
    //   event.target.src = 'https://via.placeholder.com/300x200'
    // },
  },
}
</script>

<style scoped>
.video-platform {
  font-family: 'Arial', sans-serif;
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
  padding-bottom: 15px;
  border-bottom: 1px solid #eee;
}

.logo {
  font-size: 24px;
  font-weight: bold;
  color: #00a1d6;
}

.search-bar {
  display: flex;
  width: 50%;
}

.search-bar input {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px 0 0 4px;
  outline: none;
}

.search-bar button {
  padding: 8px 16px;
  background-color: #00a1d6;
  color: white;
  border: none;
  border-radius: 0 4px 4px 0;
  cursor: pointer;
}

.search-bar button:hover {
  background-color: #0087b3;
}

.section {
  margin-bottom: 40px;
}

.section-title {
  font-size: 20px;
  margin-bottom: 15px;
  padding-bottom: 10px;
  border-bottom: 1px solid #eee;
}

.courses-container,
.videos-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
}

.course-card,
.video-card {
  border-radius: 4px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
  cursor: pointer;
}

.course-card:hover,
.video-card:hover {
  transform: translateY(-5px);
}

.course-cover,
.video-cover {
  position: relative;
  height: 0;
  padding-bottom: 56.25%; /* 16:9 比例 */
  overflow: hidden;
}

.course-cover img,
.video-cover img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.video-duration {
  position: absolute;
  right: 5px;
  bottom: 5px;
  background-color: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 2px 5px;
  border-radius: 2px;
  font-size: 12px;
}

.course-info,
.video-info {
  padding: 12px;
}

.course-title,
.video-title {
  font-size: 16px;
  margin: 0 0 8px 0;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.course-desc,
.video-desc {
  font-size: 14px;
  color: #666;
  margin: 0 0 8px 0;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.video-meta {
  font-size: 12px;
  color: #999;
}

.video-modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.8);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  background-color: white;
  width: 80%;
  max-width: 800px;
  border-radius: 4px;
  overflow: hidden;
  position: relative;
}

.modal-content video {
  width: 100%;
  display: block;
}

.close-btn {
  position: absolute;
  top: 10px;
  right: 10px;
  background: none;
  border: none;
  font-size: 24px;
  color: white;
  cursor: pointer;
  z-index: 10;
}

.video-details {
  padding: 15px;
}
</style>
