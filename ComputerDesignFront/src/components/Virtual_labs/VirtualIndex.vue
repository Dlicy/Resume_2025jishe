<template>
  <div class="home-page">
    <!-- 背景层 -->
    <div class="background-overlay"></div>
    <div class="background-gradient"></div>

    <!-- 主要内容 -->
    <div class="welcome-section">
      <h1 class="welcome-title">
        <span class="accent">基于Unity3D</span><br />
        虚拟针灸学习实验室
      </h1>
      <RouterLink to="/UnityShow" class="enter-lab-button">进入实验室</RouterLink>
    </div>

    <div class="features-section">
      <h2 class="section-title">功能介绍</h2>
      <p class="feature-description">
        本功能充分利用Unity3D软件的功能，构建精细且逼真的人体经脉穴位三维模型。通过精准的光影渲染技术，模型将呈现出细腻的纹理和精准的穴位结构，为用户提供身临其境的学习体验。将实现虚拟经脉穴位模型与现实世界的无缝融合。用户只需通过移动设备，即可实时观察和学习自身身体上的穴位分布和特点，从而加深对中医经脉穴位的理解和认识。
      </p>

      <div class="feature-boxes">
        <div class="feature-box">
          <h3>可视化人体经络穴位</h3>
          <p>高精度3D模型展示全身经络穴位分布</p>
        </div>
        <div class="feature-box">
          <h3>穴位定位介绍</h3>
          <p>详细解析每个穴位的位置、功能和主治</p>
        </div>
        <div class="feature-box">
          <h3>穴位记忆系统</h3>
          <p>智能记忆学习进度，强化重点穴位记忆</p>
        </div>
      </div>
    </div>
  </div>
  <footer class="footer">
    <div class="container">
      <p>© 2025 中医针灸学习平台 - 计算机设计大赛参赛作品</p>
      <p>
        联系我们:
        <a href="mailto:2015870900@qq.com">2015870900@qq.com</a>
      </p>
    </div>
  </footer>
</template>

<script setup lang="ts">
import { RouterLink } from 'vue-router'
</script>

<style scoped>
.home-page {
  position: relative;
  min-height: 100vh;
  color: var(--text-color);
  overflow-x: hidden;
}

/* 背景样式 */
.background-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image: url('./Vir背景.png');
  background-size: cover;
  background-position: center;
  z-index: 1;
  opacity: 0.8;
}

.background-gradient {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(to bottom, rgba(60, 135, 114, 0.2) 0%, rgba(248, 250, 250, 0.95) 80%);
  z-index: 2;
}

/* 欢迎区域 */
.welcome-section {
  position: relative;
  z-index: 3;
  text-align: center;
  padding-top: 25vh;
  padding-bottom: 10vh;
}

.welcome-title {
  font-size: 3.5rem;
  font-weight: 700;
  line-height: 1.2;
  margin: 0 auto 2rem;
  max-width: 800px;
}

.accent {
  color: var(--primary-color);
}

/* 功能区域 */
.features-section {
  position: relative;
  z-index: 3;
  background-color: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  padding: 3rem 2rem;
  margin: 0 auto;
  max-width: 1200px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.section-title {
  text-align: center;
  font-size: 2.2rem;
  margin-bottom: 2rem;
  color: var(--primary-color);
}

.feature-description {
  font-size: 1.1rem;
  line-height: 1.8;
  margin: 0 auto 3rem;
  max-width: 900px;
  text-align: center;
  color: var(--text-color);
}

/* 功能盒子 */
.feature-boxes {
  display: flex;
  justify-content: center;
  gap: 2rem;
  flex-wrap: wrap;
  margin-top: 2rem;
}

.feature-box {
  flex: 1;
  min-width: 280px;
  background-color: white;
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  border-top: 4px solid var(--primary-color);
}

.feature-box:hover {
  transform: translateY(-10px);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
}

.feature-box h3 {
  font-size: 1.4rem;
  color: var(--primary-color);
  margin-top: 0;
  margin-bottom: 1rem;
}

.feature-box p {
  color: #666;
  line-height: 1.6;
  margin: 0;
}

/* 按钮样式 */
.enter-lab-button {
  display: inline-block;
  padding: 0.8rem 2.5rem;
  font-size: 1.2rem;
  font-weight: 600;
  color: white;
  background-color: rgb(74,179,202);
  /* background-color: var(--primary-color); */
  border: none;
  border-radius: 30px;
  cursor: pointer;
  transition: all 0.3s ease;
  text-decoration: none;
  box-shadow: 0 4px 10px rgba(60, 135, 114, 0.3);
}

.enter-lab-button:hover {
  background-color: rgb(74,179,202);
  /* background-color: var(--link-hover-color); */
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(60, 135, 114, 0.4);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .welcome-title {
    font-size: 2.5rem;
    padding: 0 1rem;
  }

  .feature-boxes {
    flex-direction: column;
    align-items: center;
  }

  .feature-box {
    width: 100%;
    max-width: 400px;
  }

  .features-section {
    padding: 2rem 1rem;
    margin: 0 1rem;
  }
}

/* 颜色变量 */
:root {
  --primary-color: #3c8772;
  --text-color: #213547;
  --link-hover-color: #2c6a5a;
}
</style>
