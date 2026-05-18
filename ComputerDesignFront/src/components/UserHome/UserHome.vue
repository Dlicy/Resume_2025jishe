<template>
  <div class="user-profile">
    <!-- 用户基本信息 -->
    <div class="profile-header">
      <div class="avatar-container">
        <img :src="user.avatar" alt="用户头像" class="avatar" />
        <input
          type="file"
          ref="avatarInput"
          accept="image/*"
          @change="handleAvatarUpload"
          style="display: none"
        />
        <button class="avatar-upload-btn" @click="$refs.avatarInput.click()">
          <i class="fas fa-camera"></i>
        </button>
      </div>
      <div class="user-info">
        <div class="name-edit">
          <h1 class="user-name" v-if="!editingName">{{ user.name }}</h1>
          <input
            v-else
            v-model="editingNameValue"
            @keyup.enter="saveName"
            @blur="saveName"
            class="name-input"
          />
          <button class="edit-btn" @click="toggleNameEdit">
            <i :class="editingName ? 'fas fa-check' : 'fas fa-pencil-alt'"></i>
          </button>
        </div>
        <p class="user-email">{{ user.email }}</p>

        <div class="action-buttons">
          <button class="action-btn" title="更新头像" @click="$refs.avatarInput.click()">
            <i class="fas fa-user-circle"></i>
          </button>
          <button class="action-btn" title="更改名称" @click="toggleNameEdit">
            <i class="fas fa-user-edit"></i>
          </button>
          <button class="action-btn" title="刷新数据" @click="fetchStudyData">
            <i class="fas fa-sync-alt"></i>
          </button>
        </div>
      </div>
    </div>

    <!-- 学习贡献图 -->
    <ContributionGraph :current-year="currentYear" :contribution-data="contributionData" />

    <!-- 学习趋势图表 -->
    <LearningTrendChart :study-data="studyData" />

    <!-- 新增：学习数据图表区域 -->
    <div class="charts-container">
      <!-- 左侧：学习模块分布图 -->
      <ModuleDistributionChart :today-data="todayModuleData" />

      <!-- 右侧：视频复习列表 -->
      <VideoReviewList />
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import axios from 'axios'
import LearningTrendChart from './Components/LearningTrendChart.vue'
import ContributionGraph from './Components/ContributionGraph.vue'
import ModuleDistributionChart from './Components/ModuleDistributionChart.vue'
import VideoReviewList from './Components/VideoReviewList.vue'

const currentYear = new Date().getFullYear()
const userAll = localStorage.getItem('user')
const userData = JSON.parse(userAll)

// 学习时长曲线图
const studyData = ref([])
// 贡献数据
const contributionData = ref([])
const isLoading = ref(true)
const editingName = ref(false)
const editingNameValue = ref('')
const avatarInput = ref(null)

// 用户数据
const user = ref({
  name: userData.username,
  email: userData.email,
  avatar: userData.avatarUrl,
})

// 新增响应式数据
const todayModuleData = ref({
  bookTime: 0,
  herbTime: 0,
  formulaTime: 0,
  otherTime: 0,
})

// 格式化日期为YYYY-MM-DD
const formatDate = (date) => {
  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, '0')
  const day = String(date.getDate()).padStart(2, '0')
  return `${year}-${month}-${day}`
}

// 格式化显示日期
const formatDisplayDate = (date) => {
  const options = { year: 'numeric', month: 'long', day: 'numeric', weekday: 'long' }
  return date.toLocaleDateString('zh-CN', options)
}

// 根据学习分钟数获取贡献级别
const getContributionLevel = (minutes) => {
  if (minutes === 0) return undefined
  if (minutes <= 30) return 1
  if (minutes <= 60) return 2
  if (minutes <= 90) return 3
  return 4
}

// 切换名称编辑状态
const toggleNameEdit = () => {
  editingName.value = !editingName.value
  if (editingName.value) {
    editingNameValue.value = user.value.name
  }
}

// 更新用户名
const saveName = async () => {
  if (editingNameValue.value.trim() === '') return

  try {
    const token = localStorage.getItem('token')

    const response = await axios.put(
      '/User/update-username',
      { username: editingNameValue.value },
      {
        headers: {
          Authorization: `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      },
    )

    // 更新本地数据
    user.value.name = editingNameValue.value
    const userLocal = JSON.parse(localStorage.getItem('user'))
    userLocal.username = editingNameValue.value
    localStorage.setItem('user', JSON.stringify(userLocal))

    alert('用户名更新成功')
  } catch (error) {
    console.error('更新失败:', error.response?.data || error.message)
    alert(`更新失败: ${error.response?.data?.message || error.message}`)
  } finally {
    editingName.value = false
  }
}

// 上传头像
const handleAvatarUpload = async (event) => {
  const file = event.target.files[0]
  if (!file) return

  try {
    const token = localStorage.getItem('token')
    const formData = new FormData()
    formData.append('avatar', file)

    const response = await axios.post('/User/update-avatar', formData, {
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'multipart/form-data',
      },
    })

    // 更新头像显示
    user.value.avatar = response.data.data // 假设返回的是新的头像URL
    const userLocal = JSON.parse(localStorage.getItem('user'))
    userLocal.avatarUrl = response.data.data
    localStorage.setItem('user', JSON.stringify(userLocal))

    alert('头像更新成功')
  } catch (error) {
    console.error('上传失败:', error.response?.data || error.message)
    alert(`上传失败: ${error.response?.data?.message || error.message}`)
  }
}

// 从后端获取学习数据
const fetchStudyData = async () => {
  try {
    const token = localStorage.getItem('token')
    const response = await axios.get('/api/study-time/last-year', {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })

    const studyRecords = response.data.data || []
    studyData.value = response.data.data || []

    // 新增：获取今日模块分布数据
    const todayResponse = await axios.get('/api/study-time/today-modules', {
      headers: { Authorization: `Bearer ${token}` },
    })
    todayModuleData.value = todayResponse.data.data || {
      bookTime: 0,
      herbTime: 0,
      formulaTime: 0,
      otherTime: 0,
    }

    // 创建日期到学习时间的映射
    const studyMap = new Map()
    studyRecords.forEach((record) => {
      studyMap.set(record.studyDate, record.studyTime)
    })

    // 生成一年前的日期到今天的贡献数据
    const today = new Date()
    const oneYearAgo = new Date(today)
    oneYearAgo.setDate(oneYearAgo.getDate() - 364) // 364天前（共365天）

    const data = []
    for (let i = 0; i < 365; i++) {
      const date = new Date(oneYearAgo)
      date.setDate(date.getDate() + i)

      const dateStr = formatDate(date)
      const minutes = studyMap.get(dateStr) || 0

      data.push({
        date: formatDisplayDate(date),
        level: getContributionLevel(minutes),
        hours: minutes,
      })
    }

    // 填充到53周（371天）以满足贡献图布局
    while (data.length < 53 * 7) {
      data.push({
        date: '',
        level: undefined,
        hours: 0,
      })
    }

    contributionData.value = data
  } catch (error) {
    console.error('获取学习数据失败:', error)
    // 如果请求失败，使用空数据
    contributionData.value = Array(53 * 7).fill({
      date: '',
      level: undefined,
      hours: 0,
    })
  } finally {
    isLoading.value = false
  }
}

onMounted(() => {
  fetchStudyData()
})

onUnmounted(() => {
  // 清理工作
})
</script>

<style scoped>
@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css');

.user-profile {
  max-width: 1100px;
  margin: 2rem auto;
  padding: 2.5rem;
  background: #ffffff;
  border-radius: 18px;
  box-shadow: 0 12px 35px rgba(0, 0, 0, 0.1);
}

.profile-header {
  display: flex;
  gap: 3rem;
  margin-bottom: 3rem;
  align-items: center;
  padding-bottom: 2.5rem;
  border-bottom: 1px solid #f0f0f0;
}

.avatar-container {
  position: relative;
  width: 140px;
  height: 140px;
}

.avatar {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  object-fit: cover;
  border: 6px solid #f8f9fa;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
}

.avatar-upload-btn {
  position: absolute;
  right: 10px;
  bottom: 10px;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: #3498db;
  color: white;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.avatar-upload-btn:hover {
  background: #2980b9;
  transform: scale(1.1);
}

.user-info {
  flex: 1;
}

.name-edit {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 0.5rem;
}

.user-name {
  font-size: 2.5rem;
  margin: 0;
  color: #2c3e50;
  font-weight: 600;
}

.name-input {
  font-size: 2.5rem;
  font-weight: 600;
  color: #2c3e50;
  border: 1px solid #ddd;
  border-radius: 4px;
  padding: 0 8px;
  width: 300px;
}

.edit-btn {
  background: none;
  border: none;
  color: #7f8c8d;
  cursor: pointer;
  font-size: 1.2rem;
  transition: all 0.2s ease;
}

.edit-btn:hover {
  color: #3498db;
  transform: scale(1.1);
}

.user-email {
  font-size: 1.2rem;
  color: #7f8c8d;
  margin-bottom: 2rem;
}

.action-buttons {
  display: flex;
  gap: 1.2rem;
}

.action-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 42px;
  height: 42px;
  border-radius: 50%;
  background: #f5f7fa;
  color: #7f8c8d;
  border: none;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 1.1rem;
}

.action-btn:hover {
  background: #3498db;
  color: white;
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
}

.charts-container {
  display: flex;
  gap: 2rem;
  margin-top: 2rem;
}

@media (max-width: 992px) {
  .user-profile {
    max-width: 95%;
    padding: 2rem;
  }

  .profile-header {
    gap: 2rem;
  }

  .avatar-container {
    width: 120px;
    height: 120px;
  }
}

@media (max-width: 768px) {
  .user-profile {
    padding: 1.8rem;
  }

  .profile-header {
    flex-direction: column;
    text-align: center;
    gap: 1.8rem;
  }

  .user-name {
    font-size: 2.2rem;
  }

  .name-edit {
    justify-content: center;
  }

  .action-buttons {
    justify-content: center;
  }

  .charts-container {
    flex-direction: column;
  }
}
</style>
