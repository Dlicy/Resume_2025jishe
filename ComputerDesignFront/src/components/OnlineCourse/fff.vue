<template>
  <div class="app">
    <Header @search="handleSearch" />
    <div class="main-content">
      <Carousel :items="carouselItems" />
      <div class="video-list">
        <VideoCard
          v-for="(video, index) in filteredVideos"
          :key="index"
          :video="formatVideoData(video)"
        />
      </div>
      <div class="pagination" v-if="totalPages > 1 && !searchActive">
        <button @click="prevPage" :disabled="currentPage === 1">上一页</button>
        <span>第 {{ currentPage }} 页 / 共 {{ totalPages }} 页</span>
        <button @click="nextPage" :disabled="currentPage === totalPages">下一页</button>
      </div>
      <div v-if="searchActive && filteredVideos.length === 0" class="no-results">
        没有找到匹配的视频
      </div>
    </div>
  </div>
</template>

<script>
import Header from './tools/Header.vue'
import Carousel from './tools/Carousel.vue'
import VideoCard from './tools/VideoCard.vue'
import axios from 'axios'
import { debounce } from 'lodash'

export default {
  components: {
    Header,
    Carousel,
    VideoCard,
  },
  data() {
    return {
      carouselItems: [],
      videoList: [],
      currentPage: 1,
      pageSize: 10,
      totalPages: 1,
      searchQuery: '',
      searchActive: false,
      allVideos: [], // 存储所有视频用于客户端搜索
    }
  },
  computed: {
    filteredVideos() {
      if (!this.searchQuery) {
        return this.videoList
      }
      const query = this.searchQuery.toLowerCase()
      return this.allVideos.filter(video =>
        video.title.toLowerCase().includes(query) ||
        (video.description && video.description.toLowerCase().includes(query))
    )
    }
  },
  async mounted() {
    await this.fetchCarouselVideos()
    await this.fetchAllVideos() // 获取所有视频用于客户端搜索
    this.fetchVideos()
  },
  methods: {
    async fetchCarouselVideos() {
      try {
        const response = await axios.get('/api/videos/carousel')
        this.carouselItems = response.data
          .map((video) => {
            if (!video) return null
            return {
              id: video.id,
              title: video.title,
              image: video.coverImage || 'https://placeholder.com/default-cover.jpg',
              link: `/video/${video.id}`,
            }
          })
          .filter((item) => item !== null)
      } catch (error) {
        console.error('获取轮播图数据失败:', error)
        this.carouselItems = []
      }
    },
    async fetchAllVideos() {
      try {
        const response = await axios.get('/api/videos/all')
        this.allVideos = response.data
      } catch (error) {
        console.error('获取全部视频失败:', error)
        this.allVideos = []
      }
    },
    async fetchVideos() {
      try {
        const response = await axios.get('/api/videos', {
          params: {
            page: this.currentPage - 1,
            size: this.pageSize,
          },
        })
        this.videoList = response.data.content
        this.totalPages = response.data.totalPages
      } catch (error) {
        console.error('获取视频列表失败:', error)
      }
    },
    async handleSearch(query) {
      this.searchQuery = query
      this.searchActive = !!query

      if (query) {
        // 如果有搜索词，使用客户端过滤
        return
      }

      // 如果没有搜索词，重置为正常分页显示
      this.searchActive = false
      this.fetchVideos()
    },
    formatVideoData(video) {
      return {
        id: video.id,
        title: video.title,
        cover: video.coverImage || 'https://placeholder.com/default-cover.jpg',
        duration: this.formatDuration(video.duration),
        views: this.formatViews(video.views || 0),
        likes: this.formatViews(video.likes || 0),
        comments: this.formatViews(video.comments || 0),
        author: video.authorName || '上传者',
        authorAvatar: video.authorAvatar || 'https://placeholder.com/avatar.jpg',
        link: `/video/${video.id}`,
        authorId: video.authorId,
      }
    },
    formatDuration(seconds) {
      if (!seconds) return '00:00'
      const mins = Math.floor(seconds / 60)
      const secs = Math.floor(seconds % 60)
      return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
    },
    formatViews(count) {
      if (count >= 10000) {
        return `${(count / 10000).toFixed(1)}万`
      }
      return count.toString()
    },
    prevPage() {
      if (this.currentPage > 1) {
        this.currentPage--
        this.fetchVideos()
      }
    },
    nextPage() {
      if (this.currentPage < this.totalPages) {
        this.currentPage++
        this.fetchVideos()
      }
    },
  },
}
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
}

.app {
  background-color: #f4f4f4;
  min-height: 100vh;
}

.main-content {
  max-width: 1600px;
  margin: 0 auto;
  padding: 20px;
}

.video-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
  margin-top: 20px;
}

.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 20px;
  gap: 20px;
}

.pagination button {
  padding: 8px 16px;
  background-color: #fb7299;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.pagination button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.no-results {
  text-align: center;
  padding: 40px;
  font-size: 18px;
  color: #666;
}
</style>
