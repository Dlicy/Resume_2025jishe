<template>
  <div class="auto-test-view">
    <h1 class="page-title">针灸学智能组卷</h1>
    <p class="page-subtitle">根据您的学习情况生成个性化测试试卷</p>

    <div class="test-options">
      <div class="option-card" @click="startExam('quick')">
        <div class="option-icon">⚡</div>
        <h3>快速练习</h3>
        <p>10道随机题目，立即开始测试</p>
        <button class="start-button">开始练习</button>
      </div>

      <div class="option-card featured" @click="startExam('smart')">
        <div class="option-icon">🧠</div>
        <h3>智能组卷</h3>
        <p>根据您的错题记录智能生成试卷</p>
        <button class="start-button">智能组卷</button>
        <div class="recommend-badge">推荐</div>
      </div>

      <div class="option-card" @click="startExam('custom')">
        <div class="option-icon">📚</div>
        <h3>专项练习</h3>
        <p>按经络、穴位或病症分类练习</p>
        <button class="start-button">选择分类</button>
      </div>
    </div>

    <!-- 考试弹窗 -->
    <el-dialog
      v-model="examDialogVisible"
      title="针灸学测试"
      width="80%"
      fullscreen
      :close-on-click-modal="false"
      :show-close="false"
    >
      <div v-if="currentExam">
        <div class="exam-header">
          <h2>针灸学测试</h2>
          <div class="exam-timer">
            <el-icon><timer /></el-icon>
            {{ formatTime(examTime) }}
          </div>
        </div>

        <div class="exam-progress">
          已完成: {{ answeredCount }}/{{ currentExam.questions.length }}
        </div>

        <div class="question-container">
          <div
            class="question"
            v-for="(question, index) in currentExam.questions"
            :key="question.id"
          >
            <h3>{{ index + 1 }}. {{ question.question }}</h3>
            <el-radio-group v-model="userAnswers[index]">
              <el-radio label="A">A. {{ question.optionA }}</el-radio>
              <el-radio label="B">B. {{ question.optionB }}</el-radio>
              <el-radio label="C">C. {{ question.optionC }}</el-radio>
              <el-radio label="D">D. {{ question.optionD }}</el-radio>
            </el-radio-group>
          </div>
        </div>

        <div class="exam-footer">
          <el-button
            type="primary"
            @click="submitExam"
            :disabled="answeredCount < currentExam.questions.length"
          >
            提交试卷
          </el-button>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onUnmounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Timer } from '@element-plus/icons-vue'
import api from '@/api/question'
import examApi from '@/api/examApi'

// 考试相关状态
const examDialogVisible = ref(false)
const currentExam = ref(null)
const userAnswers = ref([])
const examTime = ref(0) // 考试用时(秒)
let timer = null

// 已答题数量计算
const answeredCount = computed(() => {
  return userAnswers.value.filter((answer) => answer !== undefined).length
})

// 开始考试
const startExam = async (type) => {
  try {
    const res = await api.generateRandomPaper(10, type)
    currentExam.value = {
      type,
      questions: res.data,
      startTime: new Date(),
    }
    userAnswers.value = new Array(res.data.length).fill(undefined)
    examTime.value = 0
    examDialogVisible.value = true

    // 开始计时
    timer = setInterval(() => {
      examTime.value++
    }, 1000)
  } catch (error) {
    ElMessage.error('组卷失败: ' + error.message)
  }
}

// 提交考试
const submitExam = async () => {
  try {
    clearInterval(timer)

    // 计算得分
    const correctAnswers = currentExam.value.questions.map((q) => q.correctAnswer)
    const score =
      userAnswers.value.reduce((total, answer, index) => {
        return total + (answer === correctAnswers[index] ? 1 : 0)
      }, 0) * 10 // 每题10分

    // 提交考试结果
    await examApi.submitExam({
      userId: getCurrentUserId(), // 从store或localStorage获取
      type: currentExam.value.type,
      score: score,
      answers: userAnswers.value.map((answer, index) => ({
        questionId: currentExam.value.questions[index].id,
        userAnswer: answer,
        isCorrect: answer === correctAnswers[index],
      })),
    })

    // 显示结果
    ElMessageBox.alert(
      `测试完成！得分: ${score}分，用时: ${formatTime(examTime.value)}`,
      '测试结果',
      {
        confirmButtonText: '确定',
        callback: () => {
          examDialogVisible.value = false
        },
      },
    )
  } catch (error) {
    ElMessage.error('提交失败: ' + error.message)
  }
}

// 格式化时间显示
const formatTime = (seconds) => {
  const mins = Math.floor(seconds / 60)
  const secs = seconds % 60
  return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
}

// 清理计时器
onUnmounted(() => {
  if (timer) clearInterval(timer)
})
</script>
