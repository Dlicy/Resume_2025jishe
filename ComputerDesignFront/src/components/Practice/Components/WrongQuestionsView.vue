<template>
  <div class="wrong-questions-view">
    <div class="header">
      <h1 class="page-title">我的错题集</h1>
      <div class="search-bar">
        <el-input
          v-model="searchQuery"
          placeholder="搜索错题..."
          clearable
          @clear="handleSearchClear"
          @keyup.enter="handleSearch"
        >
          <template #append>
            <el-button icon="Search" @click="handleSearch" />
          </template>
        </el-input>
      </div>
    </div>

    <div class="stats-summary">
      <div class="stat-card">
        <div class="stat-value">{{ totalWrongQuestions }}</div>
        <div class="stat-label">错题总数</div>
      </div>
      <div class="stat-card">
        <div class="stat-value">{{ uniqueWrongQuestions }}</div>
        <div class="stat-label">错题类型</div>
      </div>
    </div>

    <div class="questions-container">
      <div class="questions-list" v-loading="loading">
        <el-empty
          v-if="!loading && paginatedQuestions.length === 0"
          :description="searchQuery ? '没有找到相关错题' : '暂无错题记录'"
        />

        <div
          v-for="question in paginatedQuestions"
          :key="question.id"
          class="question-item"
          @click="showQuestionDetail(question)"
        >
          <div class="question-content">
            <div class="question-main">
              <h3>{{ getQuestionTitle(question) }}</h3>
              <p class="question-meta">
                <span class="meta-item">
                  <el-icon><Warning /></el-icon>
                  错误次数: {{ question.wrongTimes || 1 }}
                </span>
                <span class="meta-item">
                  <el-icon><Clock /></el-icon>
                  最后错误: {{ formatDate(question.lastWrongTime) }}
                </span>
              </p>
              <el-tag v-if="question.category" size="small" type="info" class="question-tag">
                {{ question.category }}
              </el-tag>
            </div>
            <div class="question-actions">
              <el-button type="danger" text size="small" @click.stop="handleRemove(question)">
                移除
              </el-button>
            </div>
          </div>
        </div>
      </div>

      <div class="pagination-container" v-if="filteredQuestions.length > 0">
        <el-pagination
          background
          layout="prev, pager, next, jumper, total"
          :total="filteredQuestions.length"
          :page-size="pageSize"
          v-model:current-page="currentPage"
          @current-change="handlePageChange"
        />
      </div>
    </div>

    <el-dialog v-model="dialogVisible" :title="`错题详情`" width="70%">
      <div v-if="currentQuestion" class="question-detail">
        <div class="question-content">
          <h3>{{ currentQuestion.question || '无题目内容' }}</h3>
          <div class="options" v-if="hasOptions(currentQuestion)">
            <el-radio-group v-model="currentQuestion.userAnswer" disabled>
              <el-radio label="A" class="option">A. {{ currentQuestion.optionA }}</el-radio>
              <el-radio label="B" class="option">B. {{ currentQuestion.optionB }}</el-radio>
              <el-radio label="C" class="option">C. {{ currentQuestion.optionC }}</el-radio>
              <el-radio label="D" class="option">D. {{ currentQuestion.optionD }}</el-radio>
            </el-radio-group>
          </div>
        </div>

        <el-divider />

        <div class="answer-info">
          <el-tag :type="isAnswerCorrect(currentQuestion) ? 'success' : 'danger'">
            您的答案：{{ currentQuestion.userAnswer || '未作答' }}
          </el-tag>
          <el-tag type="success" style="margin-left: 10px">
            正确答案：{{ currentQuestion.correctAnswer || '无' }}
          </el-tag>
        </div>

        <div v-if="currentQuestion.explanation" class="explanation">
          <el-divider />
          <h4>题目解析：</h4>
          <p>{{ currentQuestion.explanation }}</p>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Warning, Clock, Search } from '@element-plus/icons-vue'
import examApi from '@/api/examApi'

const loading = ref(true)
const dialogVisible = ref(false)
const currentQuestion = ref(null)
const searchQuery = ref('')
const wrongQuestions = ref([])
const currentPage = ref(1)
const pageSize = ref(10)

// 获取错题数据
const fetchWrongQuestions = async () => {
  try {
    loading.value = true
    const user = JSON.parse(localStorage.getItem('user') || '{}')
    const response = await examApi.getUserExamHistory(user.id)

    const questionMap = new Map()
    response.data?.forEach((exam) => {
      exam.answers?.forEach((answer) => {
        if (!answer.isCorrect && answer.question) {
          const questionId = answer.question.id
          const existing = questionMap.get(questionId)

          if (existing) {
            existing.wrongTimes++
            if (new Date(exam.submissionTime) > new Date(existing.lastWrongTime)) {
              existing.lastWrongTime = exam.submissionTime
            }
          } else {
            questionMap.set(questionId, {
              ...answer.question,
              id: questionId,
              wrongTimes: 1,
              lastWrongTime: exam.submissionTime,
              userAnswer: answer.userAnswer,
            })
          }
        }
      })
    })

    wrongQuestions.value = Array.from(questionMap.values())
  } catch (error) {
    ElMessage.error(`获取错题失败: ${error.message}`)
  } finally {
    loading.value = false
  }
}

// 搜索处理
const handleSearch = () => {
  currentPage.value = 1
}

const handleSearchClear = () => {
  searchQuery.value = ''
  currentPage.value = 1
}

// 分页处理
const handlePageChange = (val) => {
  currentPage.value = val
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

// 移除错题
const handleRemove = async (question) => {
  try {
    await ElMessageBox.confirm(`确定要移除这道错题吗？`, '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    })

    wrongQuestions.value = wrongQuestions.value.filter((q) => q.id !== question.id)
    ElMessage.success('已移除错题')

    // 如果当前页没有题目了，且不是第一页，则返回上一页
    if (paginatedQuestions.value.length === 0 && currentPage.value > 1) {
      currentPage.value -= 1
    }
  } catch {
    // 用户取消了操作
  }
}

// 安全获取题目标题
const getQuestionTitle = (question) => {
  if (!question) return '无题目信息'
  if (question.title) return question.title
  if (question.content) {
    return question.content.length > 50
      ? question.content.substring(0, 50) + '...'
      : question.content
  }
  return `题目ID: ${question.id}`
}

// 检查是否有选项
const hasOptions = (question) => {
  return question.optionA || question.optionB || question.optionC || question.optionD
}

// 检查答案是否正确
const isAnswerCorrect = (question) => {
  return question.userAnswer === question.correctAnswer
}

// 显示错题详情
const showQuestionDetail = (question) => {
  currentQuestion.value = question
  dialogVisible.value = true
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

// 计算属性
const totalWrongQuestions = computed(() =>
  wrongQuestions.value.reduce((sum, q) => sum + q.wrongTimes, 0),
)
const uniqueWrongQuestions = computed(() => wrongQuestions.value.length)

const filteredQuestions = computed(() => {
  if (!searchQuery.value.trim()) return wrongQuestions.value

  const query = searchQuery.value.toLowerCase().trim()
  return wrongQuestions.value.filter((question) => {
    if (question.content?.toLowerCase().includes(query)) return true
    if (String(question.id).includes(query)) return true
    if (question.category?.toLowerCase().includes(query)) return true
    return false
  })
})

const paginatedQuestions = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  return filteredQuestions.value.slice(start, end)
})

onMounted(() => {
  fetchWrongQuestions()
})
</script>

<style scoped>
.wrong-questions-view {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
}

.header {
  margin-bottom: 30px;
  text-align: center;
}

.page-title {
  color: #2b580c;
  font-size: 28px;
  margin-bottom: 15px;
}

.search-bar {
  max-width: 500px;
  margin: 0 auto;
}

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
  min-width: 120px;
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

.questions-container {
  margin-top: 30px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
  padding: 20px;
}

.question-item {
  border-bottom: 1px solid #f0f0f0;
  transition: all 0.3s;
  cursor: pointer;
}

.question-item:last-child {
  border-bottom: none;
}

.question-item:hover {
  background-color: #f9f9f9;
}

.question-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 0;
}

.question-main {
  flex: 1;
  min-width: 0;
}

.question-main h3 {
  margin: 0 0 8px 0;
  font-size: 16px;
  font-weight: 500;
  color: #333;
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}

.question-meta {
  margin: 0;
  font-size: 13px;
  color: #888;
  display: flex;
  gap: 15px;
}

.meta-item {
  display: flex;
  align-items: center;
}

.meta-item .el-icon {
  margin-right: 4px;
  font-size: 14px;
}

.question-tag {
  margin-top: 8px;
}

.question-actions {
  flex-shrink: 0;
  margin-left: 15px;
}

.pagination-container {
  margin-top: 30px;
  display: flex;
  justify-content: center;
  padding: 20px 0 10px;
}

.el-empty {
  padding: 50px 0;
}

/* 详情弹窗样式 */
.question-detail {
  padding: 0 10px;
}

.question-detail h3 {
  font-size: 18px;
  margin-bottom: 20px;
  color: #333;
  line-height: 1.6;
}

.options {
  margin: 20px 0;
}

.option {
  display: block;
  margin: 10px 0;
  padding: 10px;
  border-radius: 6px;
  background-color: #f9f9f9;
}

.answer-info {
  margin: 20px 0;
  display: flex;
  align-items: center;
}

.explanation h4 {
  color: #2b580c;
  margin-bottom: 10px;
  font-size: 16px;
}

.explanation p {
  line-height: 1.8;
  color: #555;
  white-space: pre-wrap;
}

@media (max-width: 768px) {
  .question-content {
    flex-direction: column;
    align-items: flex-start;
  }

  .question-actions {
    margin-left: 0;
    margin-top: 10px;
    align-self: flex-end;
  }

  .question-meta {
    flex-direction: column;
    gap: 5px;
  }

  .answer-info {
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
  }
}
</style>
