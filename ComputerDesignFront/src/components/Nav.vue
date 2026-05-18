<template>
  <header class="nav-bar">
    <div class="container nav-container">
      <router-link to="/" class="logo">
        <img src="@/assets/logo.png" alt="中医针灸" class="logo-img" />
        <span class="logo-text">智学云枢——AI赋能IPv6的中医个性化仿真教学平台</span>
      </router-link>

      <!-- 汉堡菜单按钮 -->
      <button class="hamburger" @click="toggleMenu" aria-label="Toggle menu">
        <span class="hamburger-line"></span>
        <span class="hamburger-line"></span>
        <span class="hamburger-line"></span>
      </button>

      <nav class="nav-menu" :class="{ active: isMenuOpen }">
        <div class="nav-links">
          <router-link to="/guide" class="nav-link">学习指南</router-link>
          <router-link to="/Virtual_labs" class="nav-link">3D穴位</router-link>
          <router-link to="/Unitypractice" class="nav-link">模拟诊断</router-link>
          <router-link to="/online_course" class="nav-link">在线课堂</router-link>
          <router-link to="/search01" class="nav-link">中医资料库</router-link>
          <router-link to="/practice" class="nav-link">知识测评</router-link>
        </div>
        <div class="auth-buttons">
          <template v-if="!isAuthenticated">
            <router-link to="/login" class="auth-link">登录</router-link>
            <span class="divider">|</span>
            <router-link to="/register" class="auth-link">注册</router-link>
          </template>
          <template v-else>
            <router-link to="/userhome" class="username">{{ username }}</router-link>
            <span class="divider">|</span>
            <a href="#" class="auth-link" @click.prevent="logout">退出登录</a>
          </template>
        </div>
      </nav>
    </div>
  </header>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount, watch, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { updateStudyTime } from '@/api/studyTime'

const router = useRouter()
const route = useRoute()
const isAuthenticated = ref(false)
const username = ref('')
const isMenuOpen = ref(false)
let studyTimer = null

const moduleMap = {
  '/guide': 'other',
  '/search01': 'book',
  '/search02': 'herb',
  '/search03': 'formula',
  '/practice': 'practive',
  '/userhome': 'user',
}

const currentModule = computed(() => {
  return moduleMap[route.path] || '未知模块'
})

// 检查登录状态
const checkAuth = () => {
  const token = localStorage.getItem('token')
  const user = localStorage.getItem('user')

  isAuthenticated.value = !!token
  if (user) {
    try {
      const userData = JSON.parse(user)
      username.value = userData.username || '用户'
    } catch (e) {
      console.error('解析用户信息失败', e)
    }
  }
}

// 切换菜单状态
const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value
}

// 关闭菜单
const closeMenu = () => {
  isMenuOpen.value = false
}

// 启动学习时间跟踪
const startStudyTimeTracking = async () => {
  try {
    await updateStudyTime(currentModule.value)
  } catch (err) {
    console.error('首次学习时间记录失败:', err)
    if (err.response?.status === 401) logout()
  }

  studyTimer = setInterval(async () => {
    try {
      await updateStudyTime(currentModule.value)
    } catch (err) {
      console.error('学习时间更新失败:', err)
      if (err.response?.status === 401) logout()
    }
  }, 60000)
}

// 停止跟踪
const stopStudyTimeTracking = () => {
  if (studyTimer) {
    clearInterval(studyTimer)
    studyTimer = null
  }
}

// 退出登录
const logout = () => {
  stopStudyTimeTracking()
  localStorage.removeItem('token')
  localStorage.removeItem('user')
  isAuthenticated.value = false
  username.value = ''
  router.push('/login')
  closeMenu()
}

// 组件挂载和卸载
onMounted(() => {
  checkAuth()
  if (isAuthenticated.value) {
    startStudyTimeTracking()
  }

  // 点击路由链接时关闭菜单
  router.afterEach(() => {
    closeMenu()
  })
})

onBeforeUnmount(() => {
  stopStudyTimeTracking()
})

// 监听登录状态变化
watch(isAuthenticated, (newVal) => {
  if (newVal) {
    startStudyTimeTracking()
  } else {
    stopStudyTimeTracking()
  }
})
</script>

<style scoped>
/* 导航栏基础样式 */
.nav-bar {
  position: sticky;
  top: 0;
  z-index: 50;
  background-color: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(8px);
  border-bottom: 1px solid var(--border-color);
  padding: 0 24px;
  height: 64px;
  display: flex;
  align-items: center;
}

.nav-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
}

.logo {
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 600;
  font-size: 18px;
  color: var(--text-color);
  text-decoration: none;
}

.logo-img {
  height: 48px;
  width: 48px;
}

.logo-text {
  white-space: nowrap;
}

.nav-menu {
  display: flex;
  gap: 24px;
  align-items: center;
}

.nav-links {
  display: flex;
  gap: 24px;
}

.nav-link {
  color: var(--text-color);
  text-decoration: none;
  font-weight: 500;
  font-size: 14px;
  transition: color 0.25s;
  white-space: nowrap;
}

.nav-link:hover {
  color: var(--link-color);
}

.nav-link.router-link-exact-active {
  color: var(--primary-color);
  font-weight: 600;
}

.auth-buttons {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-left: 24px;
}

.auth-link {
  color: var(--text-color);
  text-decoration: none;
  cursor: pointer;
  font-weight: 500;
  font-size: 14px;
  transition: color 0.25s;
}

.auth-link:hover {
  color: var(--primary-color);
}

.divider {
  color: var(--border-color);
  user-select: none;
}

.username {
  color: var(--text-color);
  font-weight: 500;
  font-size: 14px;
  margin-right: 8px;
}

/* 汉堡菜单按钮 - 默认隐藏 */
.hamburger {
  display: none;
  background: none;
  border: none;
  cursor: pointer;
  padding: 10px;
  z-index: 100;
}

.hamburger-line {
  display: block;
  width: 24px;
  height: 3px; /* 加粗线条 */
  background-color: #333; /* 使用深灰色提高对比度 */
  margin: 5px 0;
  transition: all 0.3s ease;
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .logo-text {
    display: none;
  }
}

@media (max-width: 768px) {
  .hamburger {
    display: block;
  }

  .nav-menu {
    position: fixed;
    top: 64px;
    left: 0;
    width: 100%;
    height: calc(100vh - 64px);
    background-color: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(12px);
    flex-direction: column;
    align-items: flex-start;
    padding: 20px 24px;
    gap: 20px;
    transform: translateX(-100%);
    transition: transform 0.3s ease;
  }

  .nav-menu.active {
    transform: translateX(0);
  }

  .nav-links {
    flex-direction: column;
    width: 100%;
    gap: 15px;
  }

  .auth-buttons {
    margin-left: 0;
    width: 100%;
    justify-content: flex-start;
    padding-top: 15px;
    border-top: 1px solid var(--border-color);
  }

  .nav-link,
  .auth-link {
    font-size: 16px;
    padding: 8px 0;
  }
}

@media (max-width: 480px) {
  .nav-bar {
    padding: 0 16px;
    height: 56px;
  }

  .logo-img {
    height: 40px;
    width: 40px;
  }

  .nav-menu {
    top: 56px;
    height: calc(100vh - 56px);
  }
}
</style>
