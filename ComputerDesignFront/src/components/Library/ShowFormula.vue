<template>
  <div class="formula-detail-page">
    <!-- 主容器 -->
    <div class="formula-container" v-if="formula">
      <!-- 返回按钮 -->
      <button class="back-btn" @click="goBack">
        <svg class="back-icon" viewBox="0 0 24 24">
          <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" />
        </svg>
        返回方剂列表
      </button>

      <!-- 主内容区域 -->
      <div class="formula-content">
        <!-- 左侧基本信息 -->
        <div class="formula-basic-info">
          <div class="info-header">
            <h1 class="formula-title">{{ formula.name }}</h1>
            <div class="formula-categories">
              <span class="main-category">{{ formula.mainCategory }}</span>
              <span class="sub-category">{{ formula.subCategory }}</span>
            </div>
            <div class="formula-source" v-if="formula.source">
              <span class="info-label">出处</span>
              <span class="info-value">{{ formula.source }}</span>
            </div>
          </div>

          <div class="basic-info-grid">
            <div class="info-item">
              <span class="info-label">方剂组成</span>
              <span class="info-value">{{ formula.composition }}</span>
              <div class="info-divider"></div>
            </div>

            <div class="info-item">
              <span class="info-label">功效</span>
              <span class="info-value">{{ formula.functions }}</span>
              <div class="info-divider"></div>
            </div>
          </div>
        </div>

        <!-- 右侧详细信息 -->
        <div class="formula-detail-info">
          <div class="info-scroll-container">
            <div class="detail-info-grid">
              <div class="info-item" v-if="formula.indications">
                <span class="info-label">主治</span>
                <span class="info-value">{{ formula.indications }}</span>
                <div class="info-divider"></div>
              </div>

              <div class="info-item" v-if="formula.usageMethod">
                <span class="info-label">用法用量</span>
                <span class="info-value">{{ formula.usageMethod }}</span>
                <div class="info-divider"></div>
              </div>

              <div class="info-item" v-if="formula.precautions">
                <span class="info-label">注意事项</span>
                <span class="info-value">{{ formula.precautions }}</span>
                <div class="info-divider"></div>
              </div>

              <div class="info-item" v-if="formula.explanation">
                <span class="info-label">方解</span>
                <span class="info-value">{{ formula.explanation }}</span>
                <div class="info-divider"></div>
              </div>

              <div class="info-item" v-if="formula.classification">
                <span class="info-label">分类</span>
                <span class="info-value">{{ formula.classification }}</span>
                <div class="info-divider"></div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 加载状态 -->
      <div v-if="loading" class="loading-state">
        <div class="spinner"></div>
        <p>正在加载方剂信息...</p>
      </div>

      <!-- 错误提示 -->
      <div v-if="error" class="error-state">
        <svg class="error-icon" viewBox="0 0 24 24">
          <path
            d="M11 15h2v2h-2zm0-8h2v6h-2zm.99-5C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"
          />
        </svg>
        <p>{{ error }}</p>
        <button class="btn btn-primary" @click="fetchFormula">重新加载</button>
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
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const router = useRouter()

interface Formula {
  id: number
  name: string
  mainCategory: string
  subCategory: string
  classification?: string
  composition: string
  functions: string
  indications: string
  usageMethod?: string
  precautions?: string
  explanation?: string
  source?: string
}

// 响应式状态
const formula = ref<Formula | null>(null)
const loading = ref(false)
const error = ref<string | null>(null)

// 获取方剂ID
const formulaId = computed(() => route.query.formulaid)

// 返回列表
const goBack = () => {
  router.push('/search03')
}

// 获取方剂详情
const fetchFormula = async () => {
  loading.value = true
  error.value = null

  try {
    if (!formulaId.value) {
      throw new Error('缺少方剂ID')
    }

    const response = await axios.get(`/encyclopedia/formulas/${formulaId.value}`)

    if (response.data.success) {
      formula.value = response.data.data
      console.log('方剂详情:', formula.value)
    } else {
      throw new Error(response.data.message || '获取方剂详情失败')
    }
  } catch (err) {
    error.value = `加载失败: ${err.message}`
    console.error('获取方剂错误:', err)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchFormula()
})
</script>

<style scoped>
/* 基础样式 */
.formula-detail-page {
  min-height: 100vh;
  padding: 2rem 1.5rem;
  background-color: #f8f9fa;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
  line-height: 1.6;
  color: #213547;
}

/* 主容器 */
.formula-container {
  max-width: 1200px;
  margin: 0 auto;
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
  padding: 2.5rem;
  position: relative;
}

/* 返回按钮 */
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
.formula-content {
  display: flex;
  gap: 3rem;
  margin-top: 2rem;
}

/* 左侧基本信息 */
.formula-basic-info {
  flex: 0 0 40%;
}

.info-header {
  margin-bottom: 1.5rem;
}

.formula-title {
  font-size: 2rem;
  margin: 0 0 0.5rem;
  color: #2c3e50;
  font-weight: 600;
  line-height: 1.2;
}

.formula-categories {
  display: flex;
  gap: 10px;
  margin-top: 15px;
}

.main-category,
.sub-category {
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 500;
}

.main-category {
  background-color: #e6f2ef;
  color: #3c8772;
}

.sub-category {
  background-color: #f0f5ff;
  color: #4a6bdf;
}

.basic-info-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1.5rem;
}

/* 右侧详细信息 */
.formula-detail-info {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.info-scroll-container {
  flex: 1;
  overflow-y: auto;
  padding-right: 1rem;
}

.detail-info-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1.5rem;
}

/* 信息项通用样式 */
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
  .formula-content {
    flex-direction: column;
    gap: 2rem;
    margin-top: 3rem;
  }

  .formula-basic-info {
    flex: none;
  }

  .formula-container {
    padding: 1.5rem;
  }

  .back-btn {
    top: 1rem;
    left: 1rem;
  }
}

@media (max-width: 640px) {
  .formula-title {
    font-size: 1.5rem;
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
