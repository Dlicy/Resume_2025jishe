<template>
  <div class="digital-twin-medical" @click.self="closeDashboard">
    <!-- 初始对话弹窗 -->
    <transition name="fade">
      <div class="welcome-dialog" v-if="showWelcomeDialog">
        <div class="dialog-content">
          <div class="dialog-header">
            <h3>针灸数字孪生教学系统</h3>
            <div class="avatar">
              <!-- <img src="@/assets/ai-avatar.png" alt="AI助手"> -->
            </div>
          </div>
          
          <div class="dialog-messages" ref="messagesContainer">
            <div 
              v-for="(message, index) in currentMessages" 
              :key="index"
              class="message"
              :class="{
                'ai-message': message.sender === 'ai', 
                'user-message': message.sender === 'user',
                'typing': message.typing
              }"
            >
              <span v-if="!message.typing">{{ message.text }}</span>
              <div v-else class="typing-indicator">
                <span></span><span></span><span></span>
              </div>
            </div>
          </div>
          
          <transition name="fade">
            <div class="dialog-options" v-if="showOptions && !isProcessing">
              <button
                v-for="(option, index) in currentOptions"
                :key="index"
                @click="selectOption(option)"
                class="option-button"
                :disabled="isProcessing"
              >
                {{ option.text }}
              </button>
            </div>
          </transition>
          
          <transition name="fade">
            <button 
              v-if="showStartButton && !isProcessing"
              @click="startTreatment"
              class="start-button"
            >
              <i class="icon-play"></i> 开始针灸治疗
            </button>
          </transition>
        </div>
      </div>
    </transition>


    <!-- 3D Visualization Viewport -->
    <div class="visualization-viewport">
      <vue-unity :unity="unityContext" width="100%" height="100%" />
    </div>

    <!-- Main Control Panel -->
    <div class="main-control-panel">
      <button 
        v-for="(control, index) in mainControls" 
        :key="index"
        class="holo-control-btn"
        :class="{ active: control.active }"
        @click.stop="activateControl(control.action)"
      >
        <i :class="control.icon"></i>
        <span>{{ control.label }}</span>
        <div class="pulse-effect" v-if="control.notification"></div>
      </button>
    </div>

    <!-- Performance Dashboard -->
    <transition name="fade">
      <div 
        class="performance-dashboard" 
        v-show="showDashboard"
        @click.stop
      >
        <performance-metrics 
          @update:currentStep="handleStepChange"
          @update:form="handleFormUpdate"
          @complete="handleTreatmentComplete"
          :can-proceed="canProceed"
          v-model:currentStep="currentStep"
          v-model:angle="angle"
          v-model:depth="depth"
        />
      </div>
    </transition>

<!-- Feedback Score Display -->
<transition name="slide-up">
  <div class="feedback-score-display" v-if="showFeedback">
    <div class="score-card" :class="feedbackResult.grade.toLowerCase()">
      <div class="score-header">
        <h3>操作评分结果</h3>
        <button class="close-btn" @click="showFeedback = false">
          <span class="close-icon">×</span>
        </button>
      </div>
      
      <div class="score-main">
        <div class="total-score">
          <span class="score-value">{{ feedbackResult.score }}</span>
          <span class="score-max">/{{ feedbackResult.fullScore }}</span>
        </div>
        <div class="grade-badge">{{ feedbackResult.grade }}</div>
      </div>
      
      <div class="score-feedback">
        <h4>反馈建议：</h4>
        <ul>
          <li v-for="(item, index) in feedbackResult.feedback" :key="index">{{ item }}</li>
        </ul>
      </div>
    </div>
  </div>
</transition>

    <!-- Holographic UI Elements -->
    <div class="holographic-ui">
      <div class="grid-overlay"></div>
      <div class="particle-effects"></div>
      <div class="focus-highlight" v-if="highlightedElement"></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted, computed, reactive, nextTick, watch } from 'vue'
import PerformanceMetrics from './PerformanceMetrics.vue'
import UnityWebgl from 'unity-webgl'
import VueUnity from 'unity-webgl/vue'
import { useRouter } from 'vue-router'

// Component Options
defineOptions({
  name: 'DigitalTwinMedical'
})

// Unity Context
const unityContext = new UnityWebgl({
  loaderUrl: '/public/联系/Build/check.loader.js',
  dataUrl: '/public/联系/Build/check.data',
  frameworkUrl: '/public/联系/Build/check.framework.js',
  codeUrl: '/public/联系/Build/check.wasm',
})

// Reactive Data
const form = reactive({
  position: '',
  selectedPoints: [],
  hasAshiPoint: false,
  disinfectionConfirmed: false,
  needleType: 'filiform',
  needleLength: '1.5',
  needleDiameter: '0.25',
  insertionAngle: 0,
  manipulationTechnique: 'lifting-thrusting',
  manipulationIntensity: 2,
  retentionTime: 20,
  reinReduction: 'none',
  withdrawalOrder: {},
  postWithdrawal: 'none'
})

const modelList = ref(new Set())
const highlightedModel = ref(null)
const modelname = ref()
const router = useRouter()
const highlightedElement = ref(null)
const showDashboard = ref(false)
const currentStep = ref(0)
const angle = ref(45)
const depth = ref(0.5)
const showFeedback = ref(false)
const feedbackResult = ref(null)

// 对话相关状态
const showWelcomeDialog = ref(true)
const currentMessages = ref([])
const currentOptions = ref([])
const showOptions = ref(false)
const showStartButton = ref(false)
const isProcessing = ref(false)
const messagesContainer = ref(null)

// 更自然的对话流程配置
const dialogConfig = {
  steps: [
    {
      type: 'message',
      content: '欢迎使用针灸数字孪生教学系统',
      delay: 800
    },
    {
      type: 'message',
      content: '我是您的AI针灸助手，将引导您完成颈椎病治疗的完整流程',
      delay: 1000
    },
    {
      type: 'options',
      question: '您想先了解什么？',
      options: [
        { 
          text: '了解系统功能', 
          responses: [
            { type: 'message', content: '本系统提供以下创新功能：', delay: 600 },
            { type: 'message', content: '1. 3D人体模型实时交互操作', delay: 600 },
            { type: 'message', content: '2. 针灸全流程标准化指导', delay: 600 },
            { type: 'message', content: '3. 智能操作评分与实时反馈', delay: 600 },
            { type: 'message', content: '4. 临床典型病例模拟训练', delay: 600 }
          ]
        },
        { 
          text: '查看病例信息',
          responses: [
            { type: 'message', content: '当前病例：张先生，45岁', delay: 600 },
            { type: 'message', content: '主诉：颈肩疼痛伴头晕3个月', delay: 600 },
            { type: 'message', content: '诊断：气滞血瘀型颈椎病', delay: 600 },
            { type: 'message', content: '治疗目标：疏通经络，行气活血', delay: 600 }
          ]
        },
        {
          text: '直接开始治疗',
          action: 'start'
        }
      ],
      delay: 1200
    }
  ]
}

// 显示消息（带打字机效果）
const showMessage = async (text, delay = 0) => {
  isProcessing.value = true
  const message = { 
    sender: 'ai', 
    text: '', 
    typing: true 
  }
  currentMessages.value.push(message)
  await scrollToBottom()
  
  // 模拟打字效果
  let i = 0
  const typingInterval = setInterval(() => {
    if (i < text.length) {
      message.text += text.charAt(i)
      i++
      scrollToBottom()
    } else {
      clearInterval(typingInterval)
      message.typing = false
      isProcessing.value = false
    }
  }, 30)
  
  await new Promise(resolve => setTimeout(resolve, delay))
}

// 显示选项
const showQuestionWithOptions = async (question, options) => {
  await showMessage(question)
  currentOptions.value = options
  showOptions.value = true
}

// 滚动到底部
const scrollToBottom = async () => {
  await nextTick()
  if (messagesContainer.value) {
    messagesContainer.value.scrollTop = messagesContainer.value.scrollHeight
  }
}

// 选择选项
const selectOption = async (option) => {
  isProcessing.value = true
  showOptions.value = false
  
  // 添加用户选择的消息
  currentMessages.value.push({
    sender: 'user',
    text: option.text,
    typing: false
  })
  await scrollToBottom()
  
  if (option.action === 'start') {
    await proceedToStart()
  } else if (option.responses) {
    for (const response of option.responses) {
      await showMessage(response.content, response.delay)
    }
    await showMainOptions()
  }
  
  isProcessing.value = false
}

// 返回主选项
const showMainOptions = async () => {
  const mainStep = dialogConfig.steps.find(step => step.type === 'options')
  await showQuestionWithOptions(mainStep.question, mainStep.options)
}

// 进入开始治疗流程
const proceedToStart = async () => {
  await showMessage('让我们开始治疗吧！', 800)
  await showMessage('系统已准备好颈椎病治疗案例，将逐步引导您完成操作', 1000)
  showStartButton.value = true
  await scrollToBottom()
}

// 开始治疗
const startTreatment = () => {
  showWelcomeDialog.value = false
  showDashboard.value = true
  // 可以在这里初始化3D场景等
}

// 初始化对话流程
const initDialog = async () => {
  for (const step of dialogConfig.steps) {
    switch (step.type) {
      case 'message':
        await showMessage(step.content, step.delay)
        break
      case 'options':
        await showQuestionWithOptions(step.question, step.options)
        break
    }
  }
}




const mainControls = ref([
  { icon: 'icon-performance', label: '开始诊断', action: 'performance', active: false, notification: false },
  { icon: 'icon-performance', label: '返回首页', action: 'backToHome', active: false, notification: false }
])

// Computed Properties
const canProceed = computed(() => {
  switch(currentStep.value) {
    case 0: return form.position !== ''
    case 1: return form.selectedPoints.length > 0
    case 2: return form.disinfectionConfirmed
    case 3: return form.needleType !== ''
    case 4: return form.insertionAngle > 0
    case 5: return form.retentionTime >= 5
    case 6: return true
    default: return false
  }
})

// Methods
const activateControl = (action) => {
  mainControls.value.forEach(control => {
    control.active = control.action === action
  })
  
  switch(action) {
    case 'performance':
      showDashboard.value = !showDashboard.value
      break
    case 'backToHome':
      router.push('/')
      break
    case 'showDashboard':
      showDashboard.value = true
      break
  }
}

const handleModelClick = (event) => {
  const { name } = event.detail
  modelname.value = event.detail
  modelList.value.add(name)
  modelList.value = new Set([...modelList.value])
}

const handleMessage = (event) => {
  if (event.data) {
    if (event.data.data === '酒精点击') {
      currentStep.value = 3
      form.disinfectionConfirmed = true
      showDashboard.value = true
    } else if (event.data.data === '针点击') {
      form.needleType = '针'
      currentStep.value = 4
      showDashboard.value = true
    }
  }
}

const handleStepChange = (step) => {
  currentStep.value = step
}

const handleFormUpdate = (newFormData) => {
  Object.assign(form, newFormData)
}

const handleTreatmentComplete = (finalData) => {
  feedbackResult.value = calculatePunctureFeedback(finalData)
  showFeedback.value = true
  console.log('治疗完成，评分结果:', feedbackResult.value)
}

const calculatePunctureFeedback = (formData) => {
  let score = 100
  const feedback = []
  
  // 体位评分
  const positionScores = {
    '仰卧位': 10, '俯卧位': 8, '侧卧位': 6, '坐位': 4
  }
  const positionScore = positionScores[formData.position] || 5
  score -= (10 - positionScore)
  if (positionScore < 10) {
    feedback.push(`体位选择${formData.position}较为合适，但${positionScore < 8 ? '不是最佳选择' : '可以进一步优化'}`)
  }

  // 选点评分
  if (formData.selectedPoints.length === 0) {
    score -= 30
    feedback.push('未选择任何穿刺点')
  } else {
    if (formData.hasAshiPoint) {
      score += 5
      feedback.push('正确识别了穴')
    }
    if (formData.selectedPoints.length > 3) {
      score -= 10
      feedback.push('穿刺点数量过多，建议精简')
    }
  }


  // 确保分数范围
  score = Math.max(0, Math.min(100, score))

  // 评分等级
  let grade
  if (score >= 90) grade = '优秀'
  else if (score >= 75) grade = '良好'
  else if (score >= 60) grade = '合格'
  else grade = '需改进'

  return {
    score,
    grade,
    feedback,
    fullScore: 100,
    details: {
      positionScore,
      disinfectionScore: formData.disinfectionConfirmed ? 20 : 0,
      pointsScore: formData.selectedPoints.length > 0 ? 30 : 0
    }
  }
}


const unityFocusControl = {
  enable: () => {
    unityContext.send("FocusControl", "OnUnityFocus");
    console.log("[DEBUG] 键盘捕获已启用 (可通过 unityFocusControl.disable() 关闭)");
  },
  disable: () => {
    unityContext.send("FocusControl", "OnUnityBlur");
    console.log("[DEBUG] 键盘捕获已禁用 (可通过 unityFocusControl.enable() 开启)");
  },
  status: () => {
    const viewport = document.querySelector(".unity-viewport");
    console.log(`当前焦点状态: ${document.activeElement === viewport ? "已捕获" : "未捕获"}`);
    console.log(`控制方法: 
      unityFocusControl.enable() - 强制捕获键盘
      unityFocusControl.disable() - 释放键盘控制`);
  }
};

// 暴露到全局（仅开发环境）
if (import.meta.env.DEV) {
  (window as any).unityFocusControl = unityFocusControl;
}

const setupUnityFocusHandlers = () => {
  const unityViewport = document.querySelector(".unity-viewport") as HTMLElement;
  
  if (!unityViewport) {
    console.warn("Unity viewport 元素未找到！");
    return;
  }

  // 添加 tabindex 使元素可聚焦
  unityViewport.tabIndex = -1; 

  unityViewport.addEventListener("focus", unityFocusControl.enable);
  unityViewport.addEventListener("blur", unityFocusControl.disable);

  // 初始状态检查
  nextTick(() => {
    unityViewport.focus(); // 默认自动获取焦点
  });
};
// 在 onMounted 中调用
onMounted(() => {
  // 你的现有监听器
  window.addEventListener('unity-model-click', handleModelClick);
  unityContext.on('error', console.error);
  
  // 初始化焦点控制（延迟确保DOM加载完成）
  setTimeout(setupUnityFocusHandlers, 500); // 适当延迟确保viewport已渲染
});




// Lifecycle Hooks
onMounted(() => {
  window.addEventListener('unity-model-click', handleModelClick)
  unityContext.on('error', console.error)
  window.addEventListener('message', handleMessage)
  initDialog()
})

onUnmounted(() => {
  window.removeEventListener('unity-model-click', handleModelClick)
  window.removeEventListener('message', handleMessage)
})
</script>
  
<style scoped>
/* 增强版基础样式 - 更明亮的科技感 */
.digital-twin-medical {
  position: relative;
  width: 100%;
  height: 100vh;
  overflow: hidden;
  background: 
    radial-gradient(ellipse at 20% 20%, #1a3a4a 0%, #0c1d25 70%),
    linear-gradient(160deg, #0f2027 0%, #1d3e4d 50%, #2a5d6e 100%);
  color: #f0faff;
  font-family: 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
}

/* 超大3D视图区 */
.visualization-viewport {
  position: absolute;
  width: 100%;
  height: 100%;
  z-index: 1;
  filter: brightness(1.1) contrast(1.15);
}

/* 巨型控制面板 */
.main-control-panel {
  position: absolute;
  bottom: 50px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 20px;
  z-index: 10;
  background: rgba(18, 40, 50, 0.92);
  backdrop-filter: blur(20px);
  border-radius: 32px;
  padding: 18px 36px;
  box-shadow: 
    0 12px 50px rgba(0, 230, 255, 0.25),
    inset 0 2px 4px rgba(255, 255, 255, 0.15),
    0 -8px 24px rgba(0, 0, 0, 0.4);
  border: 1.5px solid rgba(0, 230, 255, 0.3);
  transition: all 0.4s cubic-bezier(0.22, 1, 0.36, 1);
}

/* 超大按钮设计 */
.holo-control-btn {
  position: relative;
  min-width: 120px;
  height: 60px;
  background: 
    linear-gradient(145deg, 
      rgba(40, 80, 90, 0.8) 0%, 
      rgba(20, 45, 55, 0.9) 100%);
  border: 1.5px solid rgba(0, 230, 255, 0.4);
  color: #f0faff;
  padding: 0 28px;
  border-radius: 30px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
  font-weight: 600;
  font-size: 18px;
  letter-spacing: 0.8px;
  text-shadow: 0 0 12px rgba(0, 230, 255, 0.4);
  overflow: hidden;
}

/* 按钮悬浮光效 */
.holo-control-btn::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: 
    radial-gradient(circle, 
      rgba(0, 230, 255, 0.15) 0%, 
      transparent 70%);
  transform: scale(0);
  transition: transform 0.6s ease;
}

.holo-control-btn:hover {
  transform: translateY(-5px) scale(1.05);
  background: 
    linear-gradient(145deg, 
      rgba(50, 100, 110, 0.9) 0%, 
      rgba(30, 65, 75, 1) 100%);
  box-shadow: 
    0 15px 40px rgba(0, 230, 255, 0.4),
    inset 0 0 20px rgba(0, 230, 255, 0.2);
}

.holo-control-btn:hover::before {
  transform: scale(1);
}

/* 激活状态光效 */
.holo-control-btn.active {
  background: 
    linear-gradient(145deg, 
      rgba(0, 230, 255, 0.25) 0%, 
      rgba(0, 180, 220, 0.2) 100%);
  border-color: rgba(0, 230, 255, 0.8);
  box-shadow: 
    0 0 30px rgba(0, 230, 255, 0.6),
    inset 0 0 25px rgba(0, 230, 255, 0.3);
}

/* 超大仪表板 */
.performance-dashboard {
  position: absolute;
  right: 40px;
  top: 40px;
  width: 500px;
  min-height: 500px;
  background: rgba(18, 40, 50, 0.96);
  border: 2px solid rgba(0, 230, 255, 0.35);
  border-radius: 24px;
  padding: 30px;
  backdrop-filter: blur(20px);
  z-index: 10;
  box-shadow: 
    0 20px 60px rgba(0, 0, 0, 0.4),
    inset 0 2px 4px rgba(255, 255, 255, 0.15),
    0 -10px 30px rgba(0, 0, 0, 0.3);
}

/* 巨型评分卡片 */
.feedback-score-display {
  position: absolute;
  bottom: 120px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 20;
  width: 500px;
  perspective: 1200px;
}

.score-card {
  background: rgba(18, 40, 50, 0.98);
  border: 2px solid rgba(0, 230, 255, 0.35);
  border-radius: 24px;
  padding: 36px;
  box-shadow: 
    0 25px 60px rgba(0, 180, 220, 0.35),
    inset 0 2px 4px rgba(255, 255, 255, 0.15),
    0 -12px 30px rgba(0, 0, 0, 0.35);
  backdrop-filter: blur(15px);
  transition: all 0.5s cubic-bezier(0.22, 1, 0.36, 1);
}

/* 超大评分数字 */
.total-score {
  font-size: 4rem;
  font-weight: 800;
  color: rgba(50, 100, 110, 0.9) 0%;
  display: flex;
  align-items: baseline;
  text-shadow: 0 0 20px rgba(76, 175, 80, 0.5);
  margin: 10px 0;
}

.score-max {
  font-size: 2rem;
  color: rgba(240, 250, 255, 0.7);
  margin-left: 8px;
}

/* 超大评级徽章 */
.grade-badge {
  padding: 10px 28px;
  border-radius: 28px;
  font-weight: 700;
  font-size: 1.2rem;
  letter-spacing: 1px;
  background: rgba(50, 100, 110, 0.9) 0%;
  color: white;
  box-shadow: 0 5px 20px rgba(76, 175, 80, 0.4);
}

/* 增强全息效果 */
.grid-overlay {
  position: absolute;
  width: 100%;
  height: 100%;
  background: 
    linear-gradient(rgba(0, 230, 255, 0.05) 1px, transparent 1px),
    linear-gradient(90deg, rgba(0, 230, 255, 0.05) 1px, transparent 1px);
  background-size: 60px 60px;
  animation: grid-move 80s linear infinite;
}


/* 欢迎对话框优化样式 */
.welcome-dialog {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 20, 30, 0.9);
  backdrop-filter: blur(8px);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
  padding: 20px;
  box-sizing: border-box;
}

.dialog-content {
  width: 700px;
  max-width: 95%;
  max-height: 80vh;
  background: linear-gradient(145deg, #0f2027 0%, #1a3642 100%);
  border-radius: 20px;
  padding: 30px;
  box-shadow: 0 0 50px rgba(0, 200, 255, 0.4);
  border: 1px solid rgba(0, 200, 255, 0.4);
  display: flex;
  flex-direction: column;
  position: relative;
  overflow: hidden;
}

.dialog-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 15px;
  border-bottom: 1px solid rgba(0, 200, 255, 0.3);
}

.dialog-header h3 {
  margin: 0;
  color: #00e6ff;
  font-size: 24px;
  font-weight: 600;
}

.avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  overflow: hidden;
  border: 2px solid rgba(0, 200, 255, 0.5);
}

.avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.dialog-messages {
  flex: 1;
  overflow-y: auto;
  margin-bottom: 20px;
  padding-right: 10px;
  scroll-behavior: smooth;
}

.message {
  padding: 15px 20px;
  margin-bottom: 15px;
  border-radius: 18px;
  line-height: 1.6;
  max-width: 85%;
  animation: messageAppear 0.3s ease;
  font-size: 16px;
  position: relative;
  opacity: 0;
  animation: messageAppear 0.3s forwards;
}

@keyframes messageAppear {
  to { opacity: 1; }
}

.ai-message {
  background: rgba(32, 70, 85, 0.8);
  border: 1px solid rgba(0, 200, 255, 0.3);
  align-self: flex-start;
  border-top-left-radius: 5px;
  animation-delay: 0.1s;
}

.user-message {
  background: rgba(0, 150, 200, 0.4);
  border: 1px solid rgba(0, 200, 255, 0.5);
  align-self: flex-end;
  border-top-right-radius: 5px;
  animation-delay: 0.1s;
}

.typing-indicator {
  display: inline-flex;
  align-items: center;
  height: 20px;
}

.typing-indicator span {
  display: inline-block;
  width: 8px;
  height: 8px;
  background: rgba(255, 255, 255, 0.7);
  border-radius: 50%;
  margin-right: 5px;
  animation: typingAnimation 1.4s infinite ease-in-out;
}

.typing-indicator span:nth-child(2) {
  animation-delay: 0.2s;
}

.typing-indicator span:nth-child(3) {
  animation-delay: 0.4s;
  margin-right: 0;
}

@keyframes typingAnimation {
  0%, 60%, 100% { transform: translateY(0); }
  30% { transform: translateY(-5px); }
}

.dialog-options {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 15px;
  margin-top: 20px;
  animation: fadeIn 0.5s ease;
}

.option-button {
  padding: 14px 20px;
  background: rgba(32, 70, 85, 0.9);
  border: 1px solid rgba(0, 200, 255, 0.5);
  border-radius: 10px;
  color: #e0f7fa;
  cursor: pointer;
  transition: all 0.3s ease;
  text-align: center;
  font-size: 15px;
}

.option-button:hover:not(:disabled) {
  background: rgba(44, 95, 115, 1);
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(0, 200, 255, 0.2);
}

.option-button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.start-button {
  padding: 16px 40px;
  background: linear-gradient(135deg, rgba(0, 230, 255, 0.9), rgba(0, 180, 220, 0.9));
  border: none;
  border-radius: 30px;
  color: #0f2027;
  font-weight: 600;
  font-size: 18px;
  cursor: pointer;
  margin: 30px auto 0;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 10px;
}

.start-button:hover:not(:disabled) {
  transform: scale(1.05);
  box-shadow: 0 0 25px rgba(0, 230, 255, 0.6);
}

.start-button i {
  font-size: 20px;
}

.blur-effect {
  filter: blur(5px);
  transition: filter 0.5s ease;
}

/* 过渡动画 */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.score-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 20px;
  position: relative;
}

.close-btn {
  position: absolute;
  top: -15px;
  right: -15px;
  background: rgba(0, 230, 255, 0.1);
  border: 1px solid rgba(0, 230, 255, 0.4);
  cursor: pointer;
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
  border-radius: 50%;
  backdrop-filter: blur(2px);
  box-shadow: 
    0 0 10px rgba(0, 230, 255, 0.1),
    inset 0 0 5px rgba(255, 255, 255, 0.1);
  z-index: 1;
}

.close-btn:hover {
  background: rgba(0, 230, 255, 0.2);
  border-color: rgba(0, 230, 255, 0.8);
  box-shadow: 
    0 0 20px rgba(0, 230, 255, 0.3),
    inset 0 0 10px rgba(255, 255, 255, 0.2);
  transform: scale(1.1);
}

.close-icon {
  font-size: 20px;
  line-height: 1;
  color: rgba(0, 230, 255, 0.8);
  text-shadow: 0 0 8px rgba(0, 230, 255, 0.5);
  transition: all 0.3s ease;
}

.close-btn:hover .close-icon {
  color: #fff;
  text-shadow: 0 0 12px rgba(0, 230, 255, 0.8);
}

/* 响应式调整 */
@media (max-width: 768px) {
  .dialog-content {
    padding: 20px;
  }
  
  .dialog-header h3 {
    font-size: 20px;
  }
  
  .avatar {
    width: 50px;
    height: 50px;
  }
  
  .message {
    padding: 12px 16px;
    font-size: 15px;
  }
  
  .option-button {
    padding: 12px 15px;
    font-size: 14px;
  }
  
  .start-button {
    padding: 14px 30px;
    font-size: 16px;
  }
}

@media (max-width: 480px) {
  .dialog-options {
    grid-template-columns: 1fr;
  }
}

/* 响应式调整 */
@media (max-width: 1024px) {
  .main-control-panel {
    padding: 16px 30px;
    border-radius: 28px;
  }
  
  .holo-control-btn {
    min-width: 100px;
    height: 54px;
    font-size: 16px;
  }
  
  .performance-dashboard {
    width: 380px;
    right: 30px;
  }
  
  .feedback-score-display {
    width: 450px;
  }
}

@media (max-width: 768px) {
  .main-control-panel {
    bottom: 30px;
    width: 90%;
    flex-wrap: wrap;
    justify-content: center;
  }
  
  .holo-control-btn {
    min-width: 45%;
    height: 50px;
    margin: 5px 0;
  }
  
  .performance-dashboard {
    width: 90%;
    right: 5%;
    top: 30px;
  }
  
  .feedback-score-display {
    width: 90%;
    bottom: 100px;
  }
  
  .total-score {
    font-size: 3.2rem;
  }
}
</style>