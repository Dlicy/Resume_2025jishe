<template>
  <div class="history-view">
    <div class="header-section">
      <h1 class="page-title">历史试卷</h1>
      <p class="page-subtitle">回顾过往测试 · 巩固针灸知识</p>
      <div class="header-decoration">
        <div class="decoration-line"></div>
        <div class="decoration-icon">✿</div>
        <div class="decoration-line"></div>
      </div>
    </div>

    <div class="filter-section">
      <el-input
        v-model="searchQuery"
        placeholder="搜索试卷..."
        clearable
        class="search-input"
        @clear="handleSearchClear"
        @keyup.enter="fetchExamHistory"
      >
        <template #append>
          <el-button icon="Search" @click="fetchExamHistory" />
        </template>
      </el-input>
    </div>

    <div class="stats-summary">
      <div class="stat-card">
        <div class="stat-value">{{ totalExams }}</div>
        <div class="stat-label">总测试次数</div>
      </div>
      <div class="stat-card">
        <div class="stat-value">{{ averageScore }}分</div>
        <div class="stat-label">平均得分</div>
      </div>
      <div class="stat-card">
        <div class="stat-value">{{ totalDuration }}</div>
        <div class="stat-label">总测试时长</div>
      </div>
    </div>

    <div class="history-container">
      <div class="history-list" v-loading="loading">
        <el-empty
          v-if="!loading && paginatedExams.length === 0"
          :description="searchQuery ? '没有找到相关试卷' : '暂无历史试卷记录'"
        />

        <div
          v-for="exam in paginatedExams"
          :key="exam.id"
          class="history-item"
          @click="viewExamDetail(exam.id)"
        >
          <div class="exam-score">
            <el-progress
              type="circle"
              :percentage="calculatePercentage(exam.score)"
              :width="80"
              :color="getScoreColor(exam.score)"
            >
              <span class="score-text">{{ exam.score }}分</span>
            </el-progress>
          </div>
          <div class="exam-info">
            <h3>{{ exam.examName || `测试 #${exam.id}` }}</h3>
            <p class="exam-meta">
              <span class="meta-item">
                <el-icon><Calendar /></el-icon>
                {{ formatDate(exam.submissionTime) }}
              </span>
              <span class="meta-item">
                <el-icon><Timer /></el-icon>
                {{ formatDuration(exam.duration) }}
              </span>
              <span class="meta-item">
                <el-icon><Document /></el-icon>
                {{ exam.questionCount || '未知' }}题
              </span>
            </p>
            <div class="exam-tags">
              <el-tag
                v-if="exam.examType"
                size="small"
                :type="exam.examType === '模拟考试' ? 'warning' : 'info'"
              >
                {{ exam.examType }}
              </el-tag>
              <el-tag
                v-if="exam.difficulty"
                size="small"
                :type="getDifficultyTagType(exam.difficulty)"
              >
                {{ exam.difficulty }}
              </el-tag>
            </div>
          </div>
          <div class="exam-actions">
            <el-button
              type="primary"
              size="small"
              @click.stop="reviewExam(exam.id)"
            >
              复习试卷
            </el-button>

          </div>
        </div>
      </div>

      <div class="pagination-container" v-if="exams.length > 0">
        <el-pagination
          background
          layout="prev, pager, next, jumper, total"
          :total="exams.length"
          :page-size="pageSize"
          v-model:current-page="currentPage"
          @current-change="handlePageChange"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Search, Timer, Calendar, Document } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import examApi from '@/api/examApi'

const router = useRouter()

const exams = ref([])
const loading = ref(false)
const searchQuery = ref('')
const currentPage = ref(1)
const pageSize = ref(8)

// 获取历史试卷
const fetchExamHistory = async () => {
  try {
    loading.value = true
    const user = JSON.parse(localStorage.getItem('user') || '{}')
    const res = await examApi.getUserExamHistory(user.id, searchQuery.value)
    
    exams.value = res.data.map((exam) => ({
      ...exam,
      duration: calculateDuration(exam.submissionTime, exam.createdAt),
      score: exam.score || 0,
      submissionTime: exam.submissionTime || exam.createdAt,
      questionCount: exam.answers?.length || 0
    }))
    
    currentPage.value = 1 // 搜索后重置到第一页
  } catch (error) {
    ElMessage.error(`获取历史试卷失败: ${error.message}`)
  } finally {
    loading.value = false
  }
}

// 计算统计信息
const totalExams = computed(() => exams.value.length)
const averageScore = computed(() => {
  if (exams.value.length === 0) return 0
  const total = exams.value.reduce((sum, exam) => sum + exam.score, 0)
  return Math.round(total / exams.value.length)
})
const totalDuration = computed(() => {
  const totalSeconds = exams.value.reduce((sum, exam) => sum + (exam.duration || 0), 0)
  const hours = Math.floor(totalSeconds / 3600)
  const mins = Math.floor((totalSeconds % 3600) / 60)
  const secs = totalSeconds % 60
  return `${hours > 0 ? `${hours}小时` : ''}${mins}分${secs}秒`
})

// 分页相关
const paginatedExams = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  return exams.value.slice(start, end)
})

const handlePageChange = (val) => {
  currentPage.value = val
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

// 计算考试用时
const calculateDuration = (submissionTime, createdAt) => {
  if (!submissionTime || !createdAt) return 0
  const start = new Date(createdAt).getTime()
  const end = new Date(submissionTime).getTime()
  return Math.floor((end - start) / 1000) // 返回秒数
}

// 格式化日期
const formatDate = (dateString) => {
  if (!dateString) return '未知时间'
  try {
    const date = new Date(dateString)
    return isNaN(date.getTime()) 
      ? '无效日期' 
      : date.toLocaleDateString() + ' ' + date.toLocaleTimeString().slice(0, 5)
  } catch {
    return '无效日期'
  }
}

// 格式化用时
const formatDuration = (seconds) => {
  if (!seconds) return '0秒'
  const mins = Math.floor(seconds / 60)
  const secs = seconds % 60
  return mins > 0 ? `${mins}分${secs}秒` : `${secs}秒`
}

// 计算百分比
const calculatePercentage = (score) => {
  return Math.min(Math.round(score), 100) // 确保不超过100%
}

// 根据分数获取颜色
const getScoreColor = (score) => {
  if (score >= 85) return '#67C23A'
  if (score >= 60) return '#E6A23C'
  return '#F56C6C'
}

// 根据难度获取标签类型
const getDifficultyTagType = (difficulty) => {
  switch (difficulty) {
    case '简单': return 'success'
    case '中等': return 'warning'
    case '困难': return 'danger'
    default: return 'info'
  }
}

// 搜索处理
const handleSearchClear = () => {
  searchQuery.value = ''
  fetchExamHistory()
}


// 复习试卷
const reviewExam = (id) => {
  router.push(`/acupuncture/review/${id}`)
}

onMounted(() => {
  fetchExamHistory()
})
</script>

<style scoped>
.history-view {
  max-width: 1100px;
  margin: 0 auto;
  padding: 20px;
}

/* 头部样式 */
.header-section {
  text-align: center;
  margin-bottom: 30px;
}

.page-title {
  color: #2b580c;
  font-size: 32px;
  margin-bottom: 8px;
}

.page-subtitle {
  color: #5a8f29;
  font-size: 16px;
  margin-bottom: 15px;
}

.header-decoration {
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto;
  max-width: 400px;
}

.decoration-line {
  flex: 1;
  height: 1px;
  background: linear-gradient(90deg, transparent, #5a8f29, transparent);
}

.decoration-icon {
  margin: 0 15px;
  color: #5a8f29;
  font-size: 20px;
}

/* 筛选区域 */
.filter-section {
  display: flex;
  justify-content: center;
  margin-bottom: 30px;
}

.search-input {
  width: 400px;
}

/* 统计卡片 */
.stats-summary {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-bottom: 30px;
  flex-wrap: wrap;
}

.stat-card {
  background: #f5f9f0;
  border-radius: 12px;
  padding: 20px 30px;
  text-align: center;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  min-width: 150px;
}

.stat-value {
  font-size: 28px;
  font-weight: bold;
  color: #2b580c;
  margin-bottom: 5px;
}

.stat-label {
  font-size: 14px;
  color: #666;
}

/* 历史列表 */
.history-container {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
  padding: 20px;
}

.history-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(450px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.history-item {
  display: flex;
  padding: 20px;
  background-color: #fff;
  border-radius: 10px;
  transition: all 0.3s;
  cursor: pointer;
  border: 1px solid #eaeaea;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.history-item:hover {
  transform: translateY(-5px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
  border-color: #d4e8b5;
}

.exam-score {
  margin-right: 20px;
  display: flex;
  align-items: center;
}

.score-text {
  font-size: 14px;
  font-weight: bold;
  color: #333;
}

.exam-info {
  flex-grow: 1;
  min-width: 0;
}

.exam-info h3 {
  margin: 0 0 10px 0;
  color: #333;
  font-size: 18px;
  font-weight: 500;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.exam-meta {
  display: flex;
  gap: 15px;
  margin: 0 0 10px 0;
  color: #666;
  font-size: 14px;
  flex-wrap: wrap;
}

.meta-item {
  display: flex;
  align-items: center;
}

.meta-item .el-icon {
  margin-right: 5px;
  font-size: 16px;
}

.exam-tags {
  display: flex;
  gap: 8px;
  margin-top: 10px;
}

.exam-actions {
  flex-shrink: 0;
  margin-left: 15px;
  display: flex;
  flex-direction: column;
  gap: 8px;
  min-width: 100px;
}

/* 分页样式 */
.pagination-container {
  display: flex;
  justify-content: center;
  padding: 20px 0 10px;
}

/* 空状态样式 */
.el-empty {
  grid-column: 1 / -1;
  padding: 50px 0;
}

/* 响应式设计 */
@media (max-width: 992px) {
  .history-list {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .history-item {
    flex-direction: column;
    gap: 15px;
  }
  
  .exam-score {
    margin-right: 0;
    justify-content: center;
  }
  
  .exam-actions {
    margin-left: 0;
    flex-direction: row;
    justify-content: flex-end;
  }
  
  .search-input {
    width: 100%;
  }
}

@media (max-width: 480px) {
  .exam-meta {
    flex-direction: column;
    gap: 5px;
  }
  
  .exam-actions {
    width: 100%;
    justify-content: space-between;
  }
  
  .stat-card {
    min-width: 120px;
    padding: 15px 20px;
  }
  
  .stat-value {
    font-size: 24px;
  }
}
</style>