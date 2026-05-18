<template>
  <div class="herb-detail-page">
    <!-- 主容器 -->
    <div class="herb-container" v-if="drug">
      <!-- 返回按钮 - 现在在容器内部 -->
      <button class="back-btn" @click="goBack">
        <svg class="back-icon" viewBox="0 0 24 24">
          <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
        </svg>
        返回中药库
      </button>

      <!-- 主内容区域 -->
      <div class="herb-content">
        <!-- 左侧图片 -->
        <div class="herb-cover">
          <div class="cover-wrapper">
            <img
              v-if="drug.imageUrl"
              :src="drug.imageUrl"
              :alt="drug.mainName"
              class="cover-image"
              @error="handleImageError"
            />
            <div v-else class="no-cover">
              <svg class="no-cover-icon" viewBox="0 0 24 24">
                <path
                  d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm-1-13h2v6h-2zm0 8h2v2h-2z"
                />
              </svg>
              <span>暂无图片</span>
            </div>
          </div>
        </div>

        <!-- 右侧信息 -->
        <div class="herb-info">
          <div class="info-header">
            <h1 class="herb-title">{{ drug.mainName }}</h1>
            <div class="herb-subtitle">{{ drug.subName }}</div>
          </div>

          <div class="info-scroll-container">
            <div class="info-grid">
              <div class="info-item" v-for="(item, index) in filteredInfoItems" :key="index">
                <span class="info-label">{{ item.label }}</span>
                <span class="info-value" v-html="item.value"></span>
                <div class="info-divider"></div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 加载状态 -->
      <div v-if="loading" class="loading-state">
        <div class="spinner"></div>
        <p>正在加载中药信息...</p>
      </div>

      <!-- 错误提示 -->
      <div v-if="error" class="error-state">
        <svg class="error-icon" viewBox="0 0 24 24">
          <path
            d="M11 15h2v2h-2zm0-8h2v6h-2zm.99-5C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"
          />
        </svg>
        <p>{{ error }}</p>
        <button class="btn btn-primary" @click="fetchDrug">重新加载</button>
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

<script setup>
import { ref, onMounted, watch, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const router = useRouter()

// 组件参数
const drugId = computed(() => route.query.herbid)

// 响应式状态
const drug = ref(null)
const loading = ref(false)
const error = ref(null)

// 计算属性：过滤掉空值的信息项
const filteredInfoItems = computed(() => {
  return [
    { label: '所属类别', value: drug.value?.drugCategories },
    { label: '具体分类', value: drug.value?.drugCategory },
    { label: '来源描述', value: drug.value?.source },
    { label: '性味', value: drug.value?.natureAndFlavor },
    { label: '加工方法', value: drug.value?.processing },
    { label: '性状特征', value: drug.value?.characters },
    { label: '功效', value: drug.value?.efficacy },
    { label: '中药归经', value: drug.value?.meridians },
    { label: '适应症', value: drug.value?.indications },
    { label: '用法和用量', value: drug.value?.usageAndDosage },
    { label: '禁忌', value: drug.value?.contraindications },
    { label: '方剂', value: drug.value?.formulas },
  ].filter((item) => item.value && item.value !== '未知' && item.value !== null)
})

// API 配置
const API_BASE = import.meta.env.VITE_API_URL
const getDrugUrl = () => `/Encyclopedia/getHerbs_detail`

// 返回上一页
const goBack = () => {
  router.go(-1)
}

// 获取中药详情
const fetchDrug = async () => {
  loading.value = true
  error.value = null

  try {
    const response = await axios.post(getDrugUrl(), drugId.value, {
      headers: {
        'Content-Type': 'application/json',
      },
    })

    const result = response.data

    if (!result.success) {
      throw new Error(result.errorMessage || '获取数据失败')
    }

    const data = result.data

    drug.value = {
      id: data.id,
      drugCategories: data.drugCategories,
      drugCategory: data.drugCategory,
      mainName: data.mainName,
      subName: data.subName,
      source: data.source,
      natureAndFlavor: data.natureAndFlavor,
      processing: data.processing,
      characters: data.characters,
      efficacy: data.efficacy,
      meridians: data.meridians,
      indications: data.indications,
      usageAndDosage: data.usageAndDosage,
      contraindications: data.contraindications,
      formulas: data.formulas,
      imageUrl: data.imageUrl.startsWith('http') ? data.imageUrl : API_BASE + data.imageUrl,
    }
  } catch (err) {
    error.value = `加载失败: ${err.message}`
    console.error('获取中药错误:', err)
  } finally {
    loading.value = false
  }
}

// 图片加载失败处理
const handleImageError = (e) => {
  e.target.style.display = 'none'
  e.target.parentElement.querySelector('.no-cover').style.display = 'flex'
}

// 生命周期钩子
onMounted(() => {
  fetchDrug()
})

// 监听drugId变化
// 监听 drugId 变化
watch(
  () => drugId.value,
  (newVal) => {
    if (newVal) {
      fetchDrug()
    }
  },
  { immediate: true },
)
</script>

<style scoped>
/* 基础样式 */
.herb-detail-page {
  min-height: 100vh;
  padding: 2rem 1.5rem;
  background-color: #f8f9fa;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
  line-height: 1.6;
  color: #213547;
}

/* 主容器 */
.herb-container {
  max-width: 1200px;
  margin: 0 auto;
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
  padding: 2.5rem;
  position: relative;
}

/* 返回按钮 - 现在在容器内部顶部 */
.back-btn {
  display: inline-flex;
  align-items: center;
  background: none;
  border: none;
  color: #3c8772;
  padding: 0.5rem 1rem;
  margin-bottom: 1.5rem;
  cursor: pointer;
  font-size: 0.9rem;
  transition: color 0.2s;
  position: absolute;
  top: 1.5rem;
  left: 1.5rem;
}

.back-btn:hover {
  color: #2c6e5d;
}

.back-icon {
  width: 1.25rem;
  height: 1.25rem;
  margin-right: 0.5rem;
  fill: currentColor;
}

/* 内容布局 */
.herb-content {
  display: flex;
  gap: 3rem;
  margin-top: 2rem; /* 为返回按钮留出空间 */
}

/* 封面样式 */
.herb-cover {
  flex: 0 0 300px;
}

.cover-wrapper {
  position: relative;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
}

.cover-image {
  width: 100%;
  height: 400px;
  object-fit: cover;
  display: block;
  transition: transform 0.3s ease;
}

.cover-image:hover {
  transform: scale(1.02);
}

.no-cover {
  width: 100%;
  height: 400px;
  display: none;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: #f5f5f5;
  color: #666;
}

.no-cover-icon {
  width: 3rem;
  height: 3rem;
  margin-bottom: 1rem;
  fill: #ccc;
}

/* 信息区域 */
.herb-info {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.info-header {
  margin-bottom: 1.5rem;
}

.herb-title {
  font-size: 2rem;
  margin: 0 0 0.5rem;
  color: #2c3e50;
  font-weight: 600;
  line-height: 1.2;
}

.herb-subtitle {
  font-size: 1rem;
  color: #666;
  font-style: italic;
}

/* 可滚动信息容器 */
.info-scroll-container {
  flex: 1;
  overflow-y: auto;
  padding-right: 1rem;
}

/* 信息网格 */
.info-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1.5rem;
}

.info-item {
  padding-bottom: 1rem;
}

.info-label {
  display: block;
  font-size: 0.85rem;
  color: #666;
  margin-bottom: 0.5rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  font-weight: 500;
}

.info-value {
  display: block;
  font-size: 1rem;
  color: #2c3e50;
  line-height: 1.6;
  white-space: pre-line;
}

.info-divider {
  height: 1px;
  background: rgba(0, 0, 0, 0.05);
  margin-top: 1rem;
}

/* 按钮样式 */
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.75rem 1.5rem;
  border-radius: 6px;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
  border: 1px solid transparent;
}

.btn-primary {
  background-color: #3c8772;
  color: white;
}

.btn-primary:hover {
  background-color: #2c6e5d;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(60, 135, 114, 0.3);
}

/* 加载状态 */
.loading-state {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(255, 255, 255, 0.95);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  z-index: 10;
  border-radius: 12px;
}

.spinner {
  width: 3rem;
  height: 3rem;
  border: 4px solid rgba(60, 135, 114, 0.1);
  border-top-color: #3c8772;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 1rem;
}

.loading-state p {
  font-size: 1rem;
  color: #2c3e50;
}

@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

/* 错误提示 */
.error-state {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 2rem;
  z-index: 10;
  background-color: rgba(255, 255, 255, 0.95);
  border-radius: 12px;
}

.error-icon {
  width: 3rem;
  height: 3rem;
  fill: #f44336;
  margin-bottom: 1rem;
}

.error-state p {
  color: #2c3e50;
  font-size: 1rem;
  margin-bottom: 1.5rem;
  max-width: 80%;
  line-height: 1.5;
}

/* 响应式设计 */
@media (max-width: 960px) {
  .herb-content {
    flex-direction: column;
    gap: 2rem;
    margin-top: 3rem; /* 在小屏幕上为返回按钮留更多空间 */
  }

  .herb-cover {
    flex: none;
    margin: 0 auto;
    max-width: 300px;
  }

  .herb-container {
    padding: 1.5rem;
  }

  .back-btn {
    top: 1rem;
    left: 1rem;
  }
}

@media (max-width: 640px) {
  .herb-title {
    font-size: 1.5rem;
  }

  .herb-cover {
    max-width: 100%;
  }

  .cover-image,
  .no-cover {
    height: 300px;
  }

  .back-btn {
    font-size: 0.8rem;
    padding: 0.4rem 0.8rem;
  }
}

/* 页脚 */
.footer {
  padding: 40px 0;
  border-top: 1px solid rgba(60, 60, 67, 0.12);
  text-align: center;
  font-size: 14px;
  color: rgba(60, 60, 67, 0.7);
}

.footer a {
  color: #3c8772;
  text-decoration: none;
}

.footer a:hover {
  text-decoration: underline;
}
</style>
