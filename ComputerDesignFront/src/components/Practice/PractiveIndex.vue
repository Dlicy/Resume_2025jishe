<template>
  <div class="acupuncture-platform">
    <!-- 简化导航栏 -->
    <nav class="simple-nav">
      <router-link
        to="/practice/auto-test"
        class="nav-item"
        :class="{ active: $route.path === '/acupuncture/auto-test' }"
      >
        <i class="nav-icon">📝</i>
        <span>自动组卷</span>
      </router-link>
      <router-link
        to="/practice/history"
        class="nav-item"
        :class="{ active: $route.path === '/acupuncture/history' }"
      >
        <i class="nav-icon">⏳</i>
        <span>历史试卷</span>
      </router-link>
      <router-link
        to="/practice/wrong-questions"
        class="nav-item"
        :class="{ active: $route.path === '/acupuncture/wrong-questions' }"
      >
        <i class="nav-icon">❌</i>
        <span>错题集</span>
      </router-link>
    </nav>

    <!-- 主内容区 - 根据路由动态切换 -->
    <main class="platform-main">
      <router-view></router-view>
    </main>
  </div>
</template>

<script setup>
import { useRoute } from 'vue-router'

const $route = useRoute()
</script>

<style scoped>
.acupuncture-platform {
  font-family: 'Microsoft YaHei', sans-serif;
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  color: #333;
}

/* 简化导航栏样式 */
.simple-nav {
  display: flex;
  justify-content: center;
  gap: 5px;
  margin-bottom: 30px;
  background-color: #f5f5f5;
  padding: 10px;
  border-radius: 50px;
  max-width: 500px;
  margin-left: auto;
  margin-right: auto;
}

.nav-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 10px 20px;
  text-decoration: none;
  color: #666;
  border-radius: 50px;
  transition: all 0.3s;
  font-size: 14px;
}

.nav-item:hover {
  background-color: #eaeaea;
}

.nav-item.active {
  background-color: #e1edcc;
  color: #2b580c;
  font-weight: bold;
}

.nav-icon {
  font-size: 20px;
  margin-bottom: 5px;
}

.platform-main {
  background-color: #fff;
  border-radius: 8px;
  padding: 30px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
  min-height: 500px;
}

@media (max-width: 768px) {
  .simple-nav {
    padding: 8px;
  }

  .nav-item {
    padding: 8px 15px;
    font-size: 13px;
  }

  .nav-icon {
    font-size: 18px;
    margin-bottom: 3px;
  }

  .platform-main {
    padding: 20px 15px;
  }
}
</style>
