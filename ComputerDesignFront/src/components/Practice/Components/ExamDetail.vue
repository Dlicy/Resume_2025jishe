<template>
  <div class="exam-detail-container">
    <el-page-header @back="goBack" class="page-header">
      <template #content>
        <div class="header-content">
          <h1>试卷详情</h1>
          <el-tag :type="scoreTagType" size="large" class="score-tag"> {{ exam.score }}分 </el-tag>
        </div>
      </template>
    </el-page-header>

    <div v-if="loading" class="loading-container">
      <el-skeleton :rows="6" animated class="skeleton-item" />
    </div>

    <div v-else class="exam-content">
      <el-card class="exam-meta-card" shadow="hover">
        <div class="meta-grid">
          <div class="meta-item">
            <el-icon><Calendar /></el-icon>
            <span>提交时间</span>
            <strong>{{ formatDate(exam.submissionTime) }}</strong>
          </div>
          <div class="meta-item">
            <el-icon><Clock /></el-icon>
            <span>答题用时</span>
            <strong>{{ formatDuration(exam.duration) }}</strong>
          </div>
          <div class="meta-item">
            <el-icon><Document /></el-icon>
            <span>题目数量</span>
            <strong>{{ exam.answers?.length || 0 }}题</strong>
          </div>
          <div class="meta-item">
            <el-icon><PieChart /></el-icon>
            <span>正确率</span>
            <strong>{{ calculateCorrectRate() }}%</strong>
          </div>
        </div>
      </el-card>

      <el-card class="question-list-card" shadow="never">
        <div
          v-for="(answer, index) in exam.answers"
          :key="answer.id"
          class="question-item"
          :class="{ correct: answer.isCorrect, wrong: !answer.isCorrect }"
        >
          <div class="question-header">
            <div class="question-number">第{{ index + 1 }}题</div>
            <el-tag :type="answer.isCorrect ? 'success' : 'danger'" size="small">
              {{ answer.isCorrect ? '回答正确' : '回答错误' }}
            </el-tag>
          </div>

          <div class="question-content">
            <p class="question-text">{{ answer.question?.question }}</p>

            <el-radio-group v-model="answer.userAnswer" disabled class="options-group">
              <el-radio label="A" class="option">
                <span class="option-label">A</span>
                <span class="option-text">{{ answer.question?.optionA }}</span>
              </el-radio>
              <el-radio label="B" class="option">
                <span class="option-label">B</span>
                <span class="option-text">{{ answer.question?.optionB }}</span>
              </el-radio>
              <el-radio label="C" class="option">
                <span class="option-label">C</span>
                <span class="option-text">{{ answer.question?.optionC }}</span>
              </el-radio>
              <el-radio label="D" class="option">
                <span class="option-label">D</span>
                <span class="option-text">{{ answer.question?.optionD }}</span>
              </el-radio>
            </el-radio-group>
          </div>

          <div class="answer-analysis" :class="{ 'has-explanation': answer.question?.explanation }">
            <div class="correct-answer">
              <el-icon><Check /></el-icon>
              <span>正确答案：{{ answer.question?.correctAnswer }}</span>
            </div>
            <div v-if="answer.question?.explanation" class="explanation">
              <el-icon><InfoFilled /></el-icon>
              <div class="explanation-content">
                <h4>题目解析</h4>
                <p>{{ answer.question.explanation }}</p>
              </div>
            </div>
          </div>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { Calendar, Clock, Document, PieChart, Check, InfoFilled } from '@element-plus/icons-vue'
import examApi from '@/api/examApi'

const route = useRoute()
const router = useRouter()

const exam = ref({
  id: null,
  score: 0,
  submissionTime: null,
  duration: 0,
  answers: [],
})
const loading = ref(true)

// 计算分数标签类型
const scoreTagType = computed(() => {
  const score = exam.value.score
  return score >= 85 ? 'success' : score >= 60 ? 'warning' : 'danger'
})

// 获取试卷详情
const fetchExamDetail = async () => {
  try {
    loading.value = true
    const res = await examApi.getExamDetail(route.params.id)
    exam.value = res.data
  } catch (error) {
    console.error('获取试卷详情失败:', error)
  } finally {
    loading.value = false
  }
}

// 计算正确率
const calculateCorrectRate = () => {
  if (!exam.value.answers?.length) return 0
  const correctCount = exam.value.answers.filter((a) => a.isCorrect).length
  return Math.round((correctCount / exam.value.answers.length) * 100)
}

// 格式化日期
const formatDate = (dateString) => {
  if (!dateString) return '未知时间'
  const date = new Date(dateString)
  return date.toLocaleDateString() + ' ' + date.toLocaleTimeString().slice(0, 5)
}

// 格式化用时
const formatDuration = (seconds) => {
  if (!seconds) return '0秒'
  const mins = Math.floor(seconds / 60)
  const secs = seconds % 60
  return mins > 0 ? `${mins}分${secs}秒` : `${secs}秒`
}

// 返回上一页
const goBack = () => {
  router.go(-1)
}

onMounted(() => {
  fetchExamDetail()
})
</script>

<style scoped>
.exam-detail-container {
  max-width: 900px;
  margin: 0 auto;
  padding: 20px;
}

.page-header {
  margin-bottom: 30px;
}

.header-content {
  display: flex;
  align-items: center;
  gap: 20px;
}

.header-content h1 {
  margin: 0;
  font-size: 24px;
  color: #333;
}

.score-tag {
  font-size: 16px;
  font-weight: bold;
  padding: 0 12px;
  height: 32px;
  line-height: 32px;
}

.loading-container {
  padding: 30px;
  background: #fff;
  border-radius: 8px;
}

.skeleton-item {
  padding: 20px 0;
}

.exam-meta-card {
  margin-bottom: 25px;
  border-radius: 12px;
}

.meta-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
}

.meta-item {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.meta-item .el-icon {
  font-size: 20px;
  color: #5a8f29;
}

.meta-item span {
  font-size: 14px;
  color: #666;
}

.meta-item strong {
  font-size: 16px;
  color: #333;
}

.question-list-card {
  border-radius: 12px;
  border: none;
}

.question-item {
  padding: 25px;
  margin-bottom: 20px;
  border-radius: 8px;
  background-color: #fff;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
  transition: all 0.3s;
}

.question-item.correct {
  border-left: 4px solid #67c23a;
}

.question-item.wrong {
  border-left: 4px solid #f56c6c;
}

.question-item:last-child {
  margin-bottom: 0;
}

.question-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.question-number {
  font-size: 16px;
  font-weight: 600;
  color: #2b580c;
}

.question-content {
  margin-bottom: 20px;
}

.question-text {
  font-size: 16px;
  line-height: 1.6;
  color: #333;
  margin: 15px 0;
}

.options-group {
  width: 100%;
  margin-top: 15px;
}

.option {
  display: flex;
  align-items: flex-start;
  margin-bottom: 12px;
  padding: 12px;
  border-radius: 6px;
  transition: background-color 0.2s;
  width: 100%;
  height: 50px;
  border: 1px solid #eee;
}

.option:hover {
  background-color: #f9f9f9;
  border-color: #ddd;
}

.option.is-checked {
  background-color: #f0f7e6;
  border-color: #d4e8b5;
}

.option-label {
  display: inline-block;
  width: 24px;
  height: 24px;
  line-height: 24px;
  text-align: center;
  background-color: #f0f7e6;
  color: #5a8f29;
  border-radius: 50%;
  margin-right: 12px;
  font-weight: 500;
  flex-shrink: 0;
}

.option-text {
  flex: 1;
  text-align: left;
}

.answer-analysis {
  padding: 15px;
  border-radius: 6px;
  background-color: #f9f9f9;
}

.answer-analysis.has-explanation {
  background-color: #f5f9f0;
}

.correct-answer {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 10px;
  font-size: 15px;
  color: #333;
}

.correct-answer .el-icon {
  color: #67c23a;
}

.explanation {
  display: flex;
  gap: 8px;
  margin-top: 15px;
  padding-top: 15px;
  border-top: 1px dashed #ddd;
}

.explanation .el-icon {
  color: #5a8f29;
  font-size: 18px;
  margin-top: 2px;
}

.explanation-content {
  flex: 1;
}

.explanation h4 {
  margin: 0 0 8px 0;
  font-size: 15px;
  color: #2b580c;
}

.explanation p {
  margin: 0;
  line-height: 1.6;
  color: #555;
}

@media (max-width: 768px) {
  .meta-grid {
    grid-template-columns: 1fr 1fr;
  }

  .question-item {
    padding: 20px 15px;
  }

  .option {
    padding: 10px;
  }
}

@media (max-width: 480px) {
  .meta-grid {
    grid-template-columns: 1fr;
  }

  .header-content {
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
  }
}
</style>
