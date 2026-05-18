<template>
  <div class="home-page">
    <main>
      <section class="hero">
        <div class="container">
          <h1 class="tagline">
            <LogoName />
            <!-- <span class="accent">岐黄经络</span><br /> -->
            AI赋能IPv6的中医个性化仿真教学平台
          </h1>
          <p class="description">
            创新的中医针灸学习平台，结合现代3D技术与传统中医理论，提供沉浸式的穴位学习体验。
          </p>
          <div class="actions">
            <router-link to="/UnityShow" class="btn btn-primary">开始体验</router-link>
            <router-link to="/Guide" class="btn btn-secondary">学习指南</router-link>
          </div>
        </div>
      </section>

      <section class="model-preview">
        <div class="container">
          <h2 style="font-size: 32px; margin-bottom: 16px">3D穴位模型预览</h2>
          <p style="max-width: 600px; margin: 0 auto 40px; color: rgba(60, 60, 67, 0.7)">
            点击、拖拽模型进行交互，探索人体经络穴位的奥秘
          </p>
          <div class="model-container">
            <!-- 这里可以嵌入Unity WebGL构建的模型 -->
            <vue-unity :unity="unityContext" width="100%" height="100%" />
          </div>
        </div>
      </section>

      <section class="features">
        <div class="container">
          <h2 style="text-align: center; margin-bottom: 40px; font-size: 32px">平台特色</h2>
          <div class="feature-container">
            <div class="feature-box">
              <h2>3D交互模型</h2>
              <p>基于Unity3D构建的高精度人体穴位模型，支持360度旋转、缩放和多角度观察。</p>
            </div>
            <div class="feature-box">
              <h2>穴位精确定位</h2>
              <p>提供标准化的穴位定位系统，包含十四经穴、经外奇穴等400多个穴位信息。</p>
            </div>
            <div class="feature-box">
              <h2>针灸模拟练习</h2>
              <p>虚拟针灸操作模拟，提供进针角度、深度等实时反馈，帮助掌握正确手法。</p>
            </div>
            <div class="feature-box">
              <h2>经络系统可视化</h2>
              <p>完整展示十二正经、奇经八脉等经络系统，理解气血运行规律。</p>
            </div>
            <div class="feature-box">
              <h2>中医理论库</h2>
              <p>集成丰富的中医理论知识，包括穴位功效、配伍禁忌、治疗案例等。</p>
            </div>
            <div class="feature-box">
              <h2>学习路径规划</h2>
              <p>根据学习进度智能推荐内容，从基础到进阶系统化学习针灸知识。</p>
            </div>
          </div>
        </div>
      </section>
    </main>

    <footer class="footer">
      <div class="container">
        <p>© 2025 中医针灸学习平台 - 计算机设计大赛参赛作品</p>
        <p>
          联系我们:
          <a href="mailto:2015870900@qq.com">2015870900@qq.com</a>
        </p>
      </div>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { useRoute } from 'vue-router'
import UnityWebgl from 'unity-webgl'
import VueUnity from 'unity-webgl/vue'
import LogoName from './LogoName.vue'

const unityContext = new UnityWebgl({
  loaderUrl: '/public/首页/Build/首页.loader.js',
  dataUrl: '/public/首页/Build/首页.data',
  frameworkUrl: '/public/首页/Build/首页.framework.js',
  codeUrl: '/public/首页/Build/首页.wasm',
})
</script>

<style scoped>
.home-page {
  --primary-color: #3c8772;
  --text-color: #213547;
  --bg-color: #ffffff;
  --border-color: rgba(60, 60, 67, 0.12);
  --link-color: var(--primary-color);
  --link-hover-color: #2c6a5a;

  font-family:
    -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Fira Sans',
    'Droid Sans', 'Helvetica Neue', sans-serif;
  color: var(--text-color);
  background-color: var(--bg-color);
  margin: 0;
  padding: 0;
  line-height: 1.5;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 24px;
}

/* 导航栏 */
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
  height: 24px;
  width: 24px;
}

.nav-menu {
  display: flex;
  gap: 24px;
}

.nav-link {
  color: var(--text-color);
  text-decoration: none;
  font-weight: 500;
  font-size: 14px;
  transition: color 0.25s;
}

.nav-link:hover {
  color: var(--link-color);
}

.nav-link.router-link-exact-active {
  color: var(--primary-color);
  font-weight: 600;
}

/* 英雄区域 */
.hero {
  padding: 96px 0;
  text-align: center;
}

.tagline {
  font-size: 48px;
  font-weight: 700;
  line-height: 1.25;
  margin: 0 0 24px;
}

.accent {
  color: var(--primary-color);
}

.description {
  font-size: 18px;
  max-width: 600px;
  margin: 0 auto 40px;
  color: rgba(60, 60, 67, 0.7);
}

.actions {
  display: flex;
  justify-content: center;
  gap: 16px;
}

.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 20px;
  padding: 0 24px;
  height: 44px;
  font-size: 14px;
  font-weight: 500;
  text-decoration: none;
  transition: all 0.25s;
}

.btn-primary {
  background-color: var(--primary-color);
  color: white;
}

.btn-primary:hover {
  background-color: var(--link-hover-color);
}

.btn-secondary {
  border: 1px solid var(--border-color);
  color: var(--text-color);
}

.btn-secondary:hover {
  border-color: var(--primary-color);
  color: var(--primary-color);
}

/* 特性区域 */
.features {
  padding: 80px 0;
}

.feature-container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
}

.feature-box {
  border: 1px solid var(--border-color);
  border-radius: 12px;
  padding: 24px;
  transition:
    transform 0.25s,
    box-shadow 0.25s;
}

.feature-box:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.feature-box h2 {
  font-size: 20px;
  font-weight: 600;
  margin: 0 0 16px;
}

.feature-box p {
  margin: 0;
  color: rgba(60, 60, 67, 0.7);
}

/* 3D模型预览 */
.model-preview {
  padding: 80px 0;
  text-align: center;
}

.model-container {
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  height: 500px;
  background-color: #f5f5f5;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 40px 0;
}

.model-placeholder {
  font-size: 18px;
  color: rgba(0, 0, 0, 0.5);
}

/* 页脚 */
.footer {
  padding: 40px 0;
  border-top: 1px solid var(--border-color);
  text-align: center;
  font-size: 14px;
  color: rgba(60, 60, 67, 0.7);
}

.footer a {
  color: var(--link-color);
  text-decoration: none;
}

.footer a:hover {
  text-decoration: underline;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .feature-container {
    grid-template-columns: 1fr;
  }

  .tagline {
    font-size: 36px;
  }

  .actions {
    flex-direction: column;
    align-items: center;
  }
}
</style>
