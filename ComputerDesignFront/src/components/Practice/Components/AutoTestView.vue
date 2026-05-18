<template>
  <div class="auto-test-view">
    <!-- 顶部标题区域 -->
    <div class="header-section">
      <h1 class="page-title">针灸学知识测评系统</h1>
      <p class="page-subtitle">巩固中医知识 · 提升临床技能 · 传承针灸文化</p>
      <div class="header-decoration">
        <div class="decoration-line"></div>
        <div class="decoration-icon">✿</div>
        <div class="decoration-line"></div>
      </div>
    </div>

    <!-- 测试简介卡片 -->
    <div class="intro-card">
      <div class="intro-icon">
        <svg viewBox="0 0 24 24">
          <path
            d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 14H9V8h2v8zm4 0h-2V8h2v8z"
          />
        </svg>
      </div>
      <div class="intro-content">
        <h3>针灸学知识测评</h3>
        <p>
          通过系统测试，检验您对经络腧穴、刺法灸法、治疗各论等知识的掌握程度，帮助您发现知识盲点，针对性提升针灸临床能力。
        </p>
      </div>
    </div>

    <!-- 测试选项区域 -->
    <div class="test-options-section">
      <h2 class="section-title">
        <span class="title-icon">❖</span>
        选择测试模式
        <span class="title-icon">❖</span>
      </h2>

      <div class="test-options">
        <div class="option-card" @click="startExam">
          <div class="option-icon">
            <svg viewBox="0 0 24 24">
              <path
                d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm.5-13H11v6l5.25 3.15.75-1.23-4.5-2.67z"
              />
            </svg>
          </div>
          <h3>快速测评</h3>
          <p>10道精选题目，限时15分钟，快速检验知识掌握情况</p>
          <div class="option-meta">
            <span class="meta-item">
              <svg viewBox="0 0 24 24">
                <path
                  d="M12 2C6.5 2 2 6.5 2 12s4.5 10 10 10 10-4.5 10-10S17.5 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm.5-13H11v6l5.2 3.2.8-1.3-4.5-2.7V7z"
                />
              </svg>
              15分钟
            </span>
            <span class="meta-item">
              <svg viewBox="0 0 24 24">
                <path
                  d="M4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6zm16-4H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-1 9H9V9h10v2zm-4 4H9v-2h6v2zm4-8H9V5h10v2z"
                />
              </svg>
              10题
            </span>
          </div>
          <button class="start-button">
            <svg viewBox="0 0 24 24"><path d="M8 5v14l11-7z" /></svg>
            开始测评
          </button>
        </div>

        <div class="option-card disabled-card">
          <div class="option-icon">
            <svg viewBox="0 0 24 24">
              <path
                d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"
              />
            </svg>
          </div>
          <h3>专项训练 <span class="coming-soon">(即将开放)</span></h3>
          <p>按知识点分类练习，针对性强化薄弱环节</p>
          <div class="option-meta">
            <span class="meta-item">
              <svg viewBox="0 0 24 24">
                <path
                  d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-5.5 8.5l7.51-3.49L17.5 6.5 9.99 9.99 6.5 17.5zm5.5 6.6c.61 0 1.1.49 1.1 1.1s-.49 1.1-1.1 1.1-1.1-.49-1.1-1.1.49-1.1 1.1-1.1z"
                />
              </svg>
              自选题目
            </span>
            <span class="meta-item">
              <svg viewBox="0 0 24 24">
                <path
                  d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V5h14v14zM7 10h2v7H7zm4-3h2v10h-2zm4 6h2v4h-2z"
                />
              </svg>
              数据分析
            </span>
          </div>
          <button class="start-button" disabled>
            <svg viewBox="0 0 24 24">
              <path
                d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 14.5v-9l6 4.5-6 4.5z"
              />
            </svg>
            敬请期待
          </button>
        </div>
      </div>
    </div>

    <!-- 知识小贴士 -->
    <div class="knowledge-tips">
      <h2 class="section-title">
        <span class="title-icon">❖</span>
        针灸学小知识
        <span class="title-icon">❖</span>
      </h2>

      <div class="tips-container">
        <div class="tip-card">
          <div class="tip-icon">㇏</div>
          <h3>经络系统</h3>
          <p>人体经络包括十二经脉、奇经八脉、十二经别、十五络脉等，是气血运行的通道。</p>
        </div>

        <div class="tip-card">
          <div class="tip-icon">⸰</div>
          <h3>五输穴</h3>
          <p>井、荥、输、经、合五类特定穴，分布在肘膝关节以下，具有重要治疗作用。</p>
        </div>

        <div class="tip-card">
          <div class="tip-icon">⿔</div>
          <h3>针刺补泻</h3>
          <p>补法多用捻转角度小、频率慢、用力轻；泻法则相反，是针灸治疗的重要原则。</p>
        </div>
      </div>
    </div>

    <!-- 考试弹窗 -->
    <el-dialog
      v-model="examDialogVisible"
      title="针灸学知识测评"
      width="80%"
      fullscreen
      :close-on-click-modal="false"
      :show-close="false"
      class="exam-dialog"
    >
      <div v-if="currentExam" class="exam-container">
        <!-- 考试头部 -->
        <div class="exam-header">
          <div class="exam-info">
            <h2>针灸学知识测评</h2>
            <div class="exam-meta">
              <span class="exam-type">快速测评</span>
              <span class="question-count">共 {{ currentExam.questions.length }} 题</span>
            </div>
          </div>
          <div class="exam-timer">
            <el-icon><timer /></el-icon>
            <span class="time-text">{{ formatTime(examTime) }}</span>
          </div>
        </div>

        <!-- 进度条 -->
        <div class="progress-container">
          <div class="progress-bar">
            <div
              class="progress-fill"
              :style="{ width: `${(answeredCount / currentExam.questions.length) * 100}%` }"
            ></div>
          </div>
          <div class="progress-text">
            已完成 {{ answeredCount }}/{{ currentExam.questions.length }} 题 ({{
              Math.round((answeredCount / currentExam.questions.length) * 100)
            }}%)
          </div>
        </div>

        <!-- 题目容器 -->
        <div class="question-container">
          <div
            class="question-item"
            v-for="(question, index) in currentExam.questions"
            :key="question.id"
          >
            <div class="question-header">
              <span class="question-number">第 {{ index + 1 }} 题</span>
              <span class="question-difficulty" :class="getDifficultyClass(question.difficulty)">
                {{ getDifficultyText(question.difficulty) }}
              </span>
            </div>

            <div class="question-content">
              <h3 class="question-text">{{ question.question }}</h3>

              <el-radio-group v-model="userAnswers[index]" class="options-group">
                <el-radio label="A" class="option">
                  <span class="option-label">A</span>
                  <span class="option-text">{{ question.optionA }}</span>
                </el-radio>

                <el-radio label="B" class="option">
                  <span class="option-label">B</span>
                  <span class="option-text">{{ question.optionB }}</span>
                </el-radio>

                <el-radio label="C" class="option">
                  <span class="option-label">C</span>
                  <span class="option-text">{{ question.optionC }}</span>
                </el-radio>

                <el-radio label="D" class="option">
                  <span class="option-label">D</span>
                  <span class="option-text">{{ question.optionD }}</span>
                </el-radio>
              </el-radio-group>
            </div>

            <div class="question-footer">
              <button class="mark-button" @click="toggleMark(index)">
                <svg viewBox="0 0 24 24">
                  <path d="M17 3H7c-1.1 0-2 .9-2 2v16l7-3 7 3V5c0-1.1-.9-2-2-2z" />
                </svg>
                {{ markedQuestions.includes(index) ? '取消标记' : '标记此题' }}
              </button>
            </div>
          </div>
        </div>

        <!-- 考试底部 -->
        <div class="exam-footer">
          <el-button class="exit-button" @click="confirmExit"> 退出测评 </el-button>
          <el-button
            type="primary"
            class="submit-button"
            @click="submitExam"
            :disabled="answeredCount < currentExam.questions.length"
          >
            <svg viewBox="0 0 24 24">
              <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z" />
            </svg>
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
import questionApi from '@/api/question'
import examApi from '@/api/examApi'

// 考试相关状态
const examDialogVisible = ref(false)
const currentExam = ref(null)
const userAnswers = ref([])
const markedQuestions = ref([])
const examTime = ref(0)
let timer = null

// 已答题数量计算
const answeredCount = computed(() => {
  return userAnswers.value.filter((answer) => answer !== undefined).length
})

// 开始考试
const startExam = async () => {
  try {
    const res = await questionApi.getRandomQuestions(10)
    currentExam.value = {
      questions: res.data,
      startTime: new Date(),
    }
    userAnswers.value = new Array(res.data.length).fill(undefined)
    markedQuestions.value = []
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
    const score = userAnswers.value.reduce((total, answer, index) => {
      return total + (answer === correctAnswers[index] ? 10 : 0)
    }, 0)

    const user = localStorage.getItem('user')
    const userData = JSON.parse(user)
    // 提交考试结果
    await examApi.submitExam({
      userId: userData.id,
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

// 标记问题
const toggleMark = (index) => {
  const idx = markedQuestions.value.indexOf(index)
  if (idx === -1) {
    markedQuestions.value.push(index)
  } else {
    markedQuestions.value.splice(idx, 1)
  }
}

// 确认退出
const confirmExit = () => {
  ElMessageBox.confirm('确定要退出当前测评吗？未提交的进度将会丢失。', '确认退出', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  })
    .then(() => {
      examDialogVisible.value = false
      if (timer) clearInterval(timer)
    })
    .catch(() => {
      // 取消操作
    })
}

// 难度相关方法
const getDifficultyText = (difficulty) => {
  const map = { easy: '简单', medium: '中等', hard: '困难' }
  return map[difficulty] || '未知'
}

const getDifficultyClass = (difficulty) => {
  return `difficulty-${difficulty}`
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

<style scoped>
/* 基础样式 */
.auto-test-view {
  max-width: 1200px;
  margin: 0 auto;
  padding: 30px 20px;
  font-family: 'PingFang SC', 'Microsoft YaHei', sans-serif;
  color: #333;
}

/* 头部区域 */
.header-section {
  text-align: center;
  margin-bottom: 40px;
}

.page-title {
  color: #2b580c;
  font-size: 32px;
  margin-bottom: 10px;
  font-weight: 600;
  letter-spacing: 1px;
}

.page-subtitle {
  color: #5a8f29;
  font-size: 16px;
  margin-bottom: 20px;
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

/* 简介卡片 */
.intro-card {
  display: flex;
  background-color: #f5f9f0;
  border-radius: 12px;
  padding: 25px;
  margin-bottom: 40px;
  align-items: center;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.intro-icon {
  width: 60px;
  height: 60px;
  background-color: #e1edcc;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 20px;
  flex-shrink: 0;
}

.intro-icon svg {
  width: 30px;
  height: 30px;
  fill: #5a8f29;
}

.intro-content h3 {
  color: #2b580c;
  margin-top: 0;
  margin-bottom: 10px;
  font-size: 20px;
}

.intro-content p {
  color: #666;
  margin: 0;
  line-height: 1.6;
  font-size: 15px;
}

/* 分区标题 */
.section-title {
  color: #2b580c;
  font-size: 24px;
  text-align: center;
  margin: 40px 0 30px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.title-icon {
  margin: 0 10px;
  color: #5a8f29;
}

/* 测试选项 */
.test-options {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 25px;
  margin-bottom: 50px;
}

.option-card {
  background-color: white;
  border-radius: 12px;
  padding: 25px;
  text-align: center;
  cursor: pointer;
  transition: all 0.3s;
  border: 1px solid #eaeaea;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  display: flex;
  flex-direction: column;
  height: 100%;
}

.option-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
  border-color: #d4e8b5;
}

.option-card.disabled-card {
  cursor: not-allowed;
  opacity: 0.7;
}

.option-card.disabled-card:hover {
  transform: none;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.option-icon {
  width: 60px;
  height: 60px;
  background-color: #f0f7e6;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 15px;
}

.option-icon svg {
  width: 30px;
  height: 30px;
  fill: #5a8f29;
}

.option-card h3 {
  color: #2b580c;
  margin-bottom: 12px;
  font-size: 18px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.coming-soon {
  font-size: 12px;
  color: #999;
  margin-left: 5px;
  font-weight: normal;
}

.option-card p {
  color: #666;
  font-size: 14px;
  margin-bottom: 20px;
  line-height: 1.6;
  flex-grow: 1;
}

.option-meta {
  display: flex;
  justify-content: center;
  gap: 15px;
  margin-bottom: 20px;
  font-size: 13px;
  color: #666;
}

.meta-item {
  display: flex;
  align-items: center;
}

.meta-item svg {
  width: 14px;
  height: 14px;
  fill: #5a8f29;
  margin-right: 5px;
}

.start-button {
  background-color: #5a8f29;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s;
  width: 80%;
  margin: 0 auto;
  font-size: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.start-button:hover {
  background-color: #4a7c20;
}

.start-button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.start-button svg {
  width: 16px;
  height: 16px;
  fill: white;
}

/* 知识小贴士 */
.knowledge-tips {
  margin-bottom: 40px;
}

.tips-container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 20px;
}

.tip-card {
  background-color: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  border: 1px solid #eaeaea;
  transition: transform 0.3s;
}

.tip-card:hover {
  transform: translateY(-3px);
}

.tip-icon {
  font-size: 28px;
  color: #5a8f29;
  margin-bottom: 10px;
}

.tip-card h3 {
  color: #2b580c;
  margin-top: 0;
  margin-bottom: 10px;
  font-size: 16px;
}

.tip-card p {
  color: #666;
  font-size: 14px;
  margin: 0;
  line-height: 1.6;
}

/* 考试弹窗样式 - 优化版 */
.exam-dialog {
  --el-dialog-padding-primary: 0;
  --el-dialog-bg-color: #f5f9f0;
}

.exam-dialog .el-dialog__header {
  display: none; /* 隐藏默认标题栏 */
}

.exam-container {
  padding: 30px;
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f5f9f0;
}

/* 考试头部优化 */
.exam-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding: 15px 20px;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  position: sticky;
  top: 0;
  z-index: 10;
}

.exam-info h2 {
  color: #2b580c;
  margin: 0;
  font-size: 22px;
  font-weight: 600;
  display: flex;
  align-items: center;
}

.exam-info h2::before {
  content: "";
  display: inline-block;
  width: 4px;
  height: 18px;
  background-color: #5a8f29;
  margin-right: 10px;
  border-radius: 2px;
}

.exam-meta {
  margin-top: 8px;
  font-size: 14px;
  color: #666;
  display: flex;
  gap: 15px;
  align-items: center;
}

.exam-type {
  background-color: #f0f7e6;
  color: #5a8f29;
  padding: 4px 10px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 500;
  display: inline-flex;
  align-items: center;
}

.exam-type::before {
  content: "⚡";
  margin-right: 5px;
  font-size: 14px;
}

.exam-timer {
  display: flex;
  align-items: center;
  font-size: 18px;
  color: #2b580c;
  font-weight: 600;
  background-color: #f0f7e6;
  padding: 8px 15px;
  border-radius: 20px;
  transition: all 0.3s;
}

.exam-timer.warning {
  color: #c62828;
  background-color: #ffebee;
  animation: pulse 1.5s infinite;
}

@keyframes pulse {
  0% { transform: scale(1); }
  50% { transform: scale(1.05); }
  100% { transform: scale(1); }
}

.exam-timer .el-icon {
  margin-right: 8px;
  font-size: 20px;
}

.time-text {
  font-family: 'Courier New', monospace;
  letter-spacing: 1px;
}

/* 进度条优化 */
.progress-container {
  margin-bottom: 25px;
  background-color: white;
  padding: 15px 20px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.progress-bar {
  height: 10px;
  background-color: #f0f0f0;
  border-radius: 5px;
  overflow: hidden;
  margin-bottom: 10px;
  box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #a8d672 0%, #5a8f29 100%);
  border-radius: 5px;
  transition: width 0.5s ease-out;
  position: relative;
  overflow: hidden;
}

.progress-fill::after {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(
    90deg,
    rgba(255, 255, 255, 0.2) 0%,
    rgba(255, 255, 255, 0.8) 50%,
    rgba(255, 255, 255, 0.2) 100%
  );
  animation: progressShine 2s infinite linear;
}

@keyframes progressShine {
  0% { transform: translateX(-100%); }
  100% { transform: translateX(100%); }
}

.progress-text {
  display: flex;
  justify-content: space-between;
  font-size: 14px;
  color: #666;
}

.progress-text span:first-child {
  font-weight: 500;
  color: #2b580c;
}

/* 题目容器优化 */
.question-container {
  flex: 1;
  overflow-y: auto;
  margin-bottom: 30px;
  padding-right: 10px;
  display: grid;
  gap: 20px;
}

.question-item {
  padding: 25px;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  border: 1px solid #e8f1d9;
  transition: transform 0.3s, box-shadow 0.3s;
}

.question-item:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
}

.question-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 15px;
  border-bottom: 1px dashed #eaeaea;
}

.question-number {
  font-weight: 600;
  color: #2b580c;
  font-size: 16px;
  display: flex;
  align-items: center;
}

.question-number::before {
  content: "Q";
  display: inline-block;
  width: 22px;
  height: 22px;
  line-height: 22px;
  text-align: center;
  background-color: #5a8f29;
  color: white;
  border-radius: 50%;
  margin-right: 10px;
  font-size: 12px;
}

.question-difficulty {
  font-size: 12px;
  padding: 4px 12px;
  border-radius: 20px;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.difficulty-easy {
  background-color: #e6f7e6;
  color: #2e7d32;
  border: 1px solid #c8e6c9;
}

.difficulty-medium {
  background-color: #fff8e1;
  color: #ff8f00;
  border: 1px solid #ffe0b2;
}

.difficulty-hard {
  background-color: #ffebee;
  color: #c62828;
  border: 1px solid #ffcdd2;
}

.question-text {
  margin: 0 0 25px 0;
  color: #333;
  line-height: 1.7;
  font-size: 16px;
  font-weight: 500;
  position: relative;
  padding-left: 15px;
}

.question-text::before {
  content: "";
  position: absolute;
  left: 0;
  top: 6px;
  bottom: 6px;
  width: 3px;
  background-color: #d4e8b5;
  border-radius: 3px;
}

/* 选项组优化 - 解决内容溢出问题 */
.options-group {
  width: 100%;
  display: grid;
  gap: 12px;
}

.option {
  display: flex;
  align-items: flex-start;
  padding: 15px;
  border-radius: 8px;
  transition: all 0.3s;
  width: 100%;
  height: 55px;
  border: 1px solid #eaeaea;
  background-color: #fafafa;
  margin-right: 0 !important;
  box-sizing: border-box; /* 确保padding计算在内 */
  word-break: break-word; /* 允许单词内断行 */
  overflow-wrap: break-word; /* 处理长单词或URL */
}

.option:hover {
  background-color: #f5f9f0;
  border-color: #d4e8b5;
}

.option.is-checked {
  background-color: #f0f7e6;
  border-color: #5a8f29;
  box-shadow: 0 2px 8px rgba(90, 143, 41, 0.2);
}

.option-label {
  display: inline-block;
  min-width: 26px; /* 改为min-width防止挤压 */
  height: 26px;
  line-height: 26px;
  text-align: center;
  background-color: #e8f1d9;
  color: #5a8f29;
  border-radius: 50%;
  margin-right: 15px;
  font-weight: 600;
  flex-shrink: 0; /* 防止被压缩 */
  transition: all 0.3s;
}

.option.is-checked .option-label {
  background-color: #5a8f29;
  color: white;
}

.option-text {
  flex: 1;
  text-align: left;
  line-height: 1.6;
  white-space: normal; /* 确保正常换行 */
  overflow: visible; /* 允许内容扩展 */
  min-width: 0; /* 解决flex项目溢出问题 */
}

/* 针对Element UI radio的额外调整 */
.el-radio__input {
  display: none; /* 隐藏原生radio控件 */
}

.el-radio__label {
  display: flex !important;
  align-items: flex-start;
  width: 100%;
  padding-left: 0 !important;
}

/* 标记按钮优化 */
.question-footer {
  margin-top: 20px;
  text-align: right;
}

.mark-button {
  background: none;
  border: none;
  color: #666;
  font-size: 14px;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  padding: 8px 15px;
  border-radius: 20px;
  transition: all 0.3s;
  background-color: #f5f5f5;
}

.mark-button:hover {
  background-color: #e0e0e0;
}

.mark-button svg {
  width: 16px;
  height: 16px;
  fill: #666;
  margin-right: 8px;
  transition: all 0.3s;
}

.marked-button {
  background-color: #fff8e1;
  color: #ff8f00;
}

.marked-button svg {
  fill: #ff8f00;
}

/* 考试底部优化 */
.exam-footer {
  text-align: center;
  padding: 20px;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
  display: flex;
  justify-content: center;
  gap: 20px;
  position: sticky;
  bottom: 0;
  z-index: 10;
}

.exit-button {
  padding: 12px 30px;
  border-radius: 8px;
  font-weight: 500;
  transition: all 0.3s;
  border: 1px solid #eaeaea;
}

.exit-button:hover {
  background-color: #f5f5f5;
  border-color: #ddd;
}

.submit-button {
  padding: 12px 30px;
  border-radius: 8px;
  font-weight: 500;
  background-color: #5a8f29;
  border: none;
  display: flex;
  align-items: center;
  gap: 10px;
  transition: all 0.3s;
}

.submit-button:hover {
  background-color: #4a7c20;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(90, 143, 41, 0.3);
}

.submit-button:disabled {
  background-color: #cccccc;
  transform: none;
  box-shadow: none;
  cursor: not-allowed;
}

.submit-button svg {
  width: 18px;
  height: 18px;
  fill: white;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .page-title {
    font-size: 26px;
  }

  .intro-card {
    flex-direction: column;
    text-align: center;
  }

  .intro-icon {
    margin-right: 0;
    margin-bottom: 15px;
  }

  .exam-container {
    padding: 15px;
  }
  
  .exam-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 15px;
    padding: 15px;
  }
  
  .exam-timer {
    width: 100%;
    justify-content: center;
  }
  
  .question-item {
    padding: 20px;
  }
  
  .exam-footer {
    flex-direction: column;
    gap: 12px;
    padding: 15px;
  }
  
  .exit-button,
  .submit-button {
    width: 100%;
  }

  .option-card {
    padding: 20px;
  }

  .option {
    padding: 12px;
    flex-direction: column;
    align-items: flex-start;
  }
  
  .option-label {
    margin-right: 0;
    margin-bottom: 10px;
  }
  
  .el-radio__label {
    flex-direction: column;
  }
}

@media (max-width: 480px) {
  .page-title {
    font-size: 22px;
  }

  .section-title {
    font-size: 20px;
  }

  .test-options {
    grid-template-columns: 1fr;
  }

  .exam-container {
    padding: 15px;
  }

  .question-item {
    padding: 15px;
  }

  .exam-footer {
    flex-direction: column;
    gap: 10px;
  }

  .exit-button,
  .submit-button {
    width: 100%;
  }
  .question-text {
    font-size: 15px;
  }
  
  .option {
    padding: 12px;
  }
  
  .option-label {
    width: 22px;
    height: 22px;
    line-height: 22px;
    margin-right: 10px;
  }
}
</style>
