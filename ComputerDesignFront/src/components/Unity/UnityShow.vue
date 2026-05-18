<template>
  <div class="digital-twin-container">
    <!-- 主界面 -->
    <div class="unity-viewport">
      <vue-unity :unity="unityContext" width="100%" height="100%" />
    </div>

    <!-- 控制面板 -->
    <div class="control-panel">
      <button class="holographic-btn" @click="toggleOverlay">
        <i class="icon-acupoint"></i>
        <span>穴位展示</span>
      </button>
      <button class="holographic-btn" @click="toggleOverlay_1">
        <i class="icon-quiz"></i>
        <span>题目测验</span>
      </button>
      <button class="holographic-btn" @click="toggleAIOverlay">
        <i class="icon-ai"></i>
        <span>AI问答</span>
      </button>
      <button class="holographic-btn" @click="toggleOverlay_2">
        <i class="icon-quiz"></i>
        <span>模拟测试</span>
      </button>
      <button class="holographic-btn" @click="toBackHome">
        <i class="icon-quiz"></i>
        <span>返回首页</span>
      </button>
    </div>

    <!-- 穴位信息面板 -->
    <div :class="['info-panel', { 'panel-active': isVisible }]">
      <div class="panel-header">
        <h2>穴位信息</h2>
        <button class="close-btn" @click="toggleOverlay">
          <i class="icon-close"></i>
        </button>
      </div>
      <div class="panel-content" v-if="acupointInfo.acupointName">
        <div class="info-item">
          <label>穴位名称</label>
          <div class="info-value">{{ acupointInfo.acupointName }}</div>
        </div>
        <div class="info-item">
          <label>经络</label>
          <div class="info-value">{{ acupointInfo.pulse }}</div>
        </div>
        <div class="info-item">
          <label>位置</label>
          <div class="info-value">{{ acupointInfo.orientation }}</div>
        </div>
        <div class="info-item">
          <label>描述</label>
          <div class="info-value">{{ acupointInfo.description }}</div>
        </div>
        <div class="info-item">
          <label>操作</label>
          <div class="info-value">{{ acupointInfo.operation }}</div>
        </div>
      </div>
      <div class="holographic-line"></div>
    </div>

    <!-- 测验面板 -->
    <div :class="['quiz-panel', { 'panel-active': isVisible_1 }]">
      <div class="panel-header">
        <h2>穴位测验</h2>
        <button class="close-btn" @click="toggleOverlay_1">
          <i class="icon-close"></i>
        </button>
      </div>
      <div class="panel-content">
        <div class="question">
          {{ correctAnswer.description }}
        </div>
        <div class="options-grid">
          <div
            v-for="(option, index) in [radio1, radio2, radio3, radio4]"
            :key="index"
            :class="['option-card', { selected: selectedAnswer === option.acupointName }]"
            @click="selectOption(option.acupointName)"
          >
            <div class="option-label">{{ String.fromCharCode(65 + index) }}</div>
            <div class="option-text">{{ option.acupointName }}</div>
          </div>
        </div>
        <div v-if="resultMessage" :class="['result-feedback', resultClass]">
          <i
            :class="[
              'feedback-icon',
              resultClass === 'correct' ? 'icon-correct' : 'icon-incorrect',
            ]"
          ></i>
          {{ resultMessage }}
        </div>
        <button class="next-btn" @click="next">
          <span>下一题</span>
          <i class="icon-next"></i>
        </button>
      </div>
      <div class="holographic-line"></div>
    </div>

    <!-- AI问答面板 -->
    <div :class="['ai-panel', { 'panel-active': isVisible_2 }]">
      <aianswer v-if="isVisible_2" ref="aiAnswerComponent" @mounted="focusAIInput" />
    </div>

    <!-- 模拟测试面板 -->
    <div :class="['info-panel', { 'panel-active': isVisible_3 }]">
      <div class="panel-header">
        <h2>模拟测试穴位信息</h2>
        <button class="close-btn" @click="toggleOverlay_2">
          <i class="icon-close"></i>
        </button>
      </div>
      <div class="panel-content" v-if="simulateacupoint">
        <div class="info-item">
          <label>穴位名称</label>
          <div class="info-value">{{ simulateacupoint }}</div>
        </div>
        <template v-if="showAngleDepthInputs">
          <div class="info-item">
            <label for="angle-input">针刺角度: {{ angle }}° (0-90度)</label>
            <div class="slider-container">
              <input
                id="angle-input"
                type="range"
                v-model.number="angle"
                min="0"
                max="90"
                step="1"
                class="holographic-slider"
                @input="validateAngle"
              />
              <input
                type="number"
                v-model.number="angle"
                min="0"
                max="90"
                class="holographic-input"
                @change="validateAngle"
              />
            </div>
          </div>
          <div class="info-item enhanced-slider">
            <label for="depth-input">
              针刺深度: <span class="value-display">{{ depth?.toFixed(1) || '0.0' }}mm</span>
              <span class="range-hint">(0.1-3.0mm)</span>
            </label>
            <div class="slider-complete-container">
              <input
                id="depth-input"
                type="range"
                v-model.number="depth"
                min="0.1"
                max="3.0"
                step="0.1"
                class="full-width-slider"
              />
              <div class="slider-ticks">
                <span>0.1</span>
                <span>1.5</span>
                <span>3.0</span>
              </div>
            </div>
          </div>

          <button @click="confirmInputs" class="holographic-btn confirm-btn">
            <i class="icon-confirm"></i>确认参数
          </button>
        </template>
        <template v-if="isShowNextProblem">
          <button @click="showNextProblem" class="holographic-btn confirm-btn">
            <i class="icon-confirm"></i>下一题
          </button>
        </template>
      </div>
      <div class="holographic-line"></div>
    </div>

    <!-- 数字孪生效果元素 -->
    <div class="digital-effects">
      <div class="grid-lines"></div>
      <div class="particles"></div>
      <div class="glow-effect"></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { shallowRef, ref, onMounted, onUnmounted, onBeforeUnmount, Transition, nextTick } from 'vue'
import axios, { AxiosResponse, AxiosError } from 'axios'
// import OverlayBox from './OverlayBox.vue'
import UnityWebgl from 'unity-webgl'
import VueUnity from 'unity-webgl/vue'
import aianswer from './aianswer.vue'
import type { AianswerExpose } from './aianswer.vue'
import { useRouter } from 'vue-router'

const router = useRouter()

var radio1 = ref({
  id: null,
  acupointName: '',
  pulse: '',
  orientation: '',
  description: '',
  operation: '',
})

var radio2 = ref({
  id: null,
  acupointName: '',
  pulse: '',
  orientation: '',
  description: '',
  operation: '',
})

var radio3 = ref({
  id: null,
  acupointName: '',
  pulse: '',
  orientation: '',
  description: '',
  operation: '',
})

var radio4 = ref({
  id: null,
  acupointName: '',
  pulse: '',
  orientation: '',
  description: '',
  operation: '',
})

const unityUrl = '/src/public/check/index.html' // Unity构建文件的路径
const modelName = ref('') // 用于存储从Unity发送的词语
const unityInstance = ref<any>(null)
const isUnityLoaded = ref(false)

const isVisible = ref(false) // 控制 OverlayBox 的显示状态
const isVisible_1 = ref(false) // 控制 OverlayBox 的显示状态
const isVisible_2 = ref(false)
const isVisible_3 = ref(false)
const showAngleDepthInputs = ref(true)
const isShowNextProblem = ref(false)
const aiAnswerComponent = ref<AianswerExpose | null>(null)

const isshowproblem = ref(false)
const isshowsimulateacupoint = ref(false)

// 正确答案
var correctAnswer = ref({
  id: null,
  acupointName: '',
  pulse: '',
  orientation: '',
  description: '',
  operation: '',
}) // 设置正确答案

var simulateacupoint = ref('')

var selectedAnswer = ref() // 用户选择的答案
var resultMessage = ref('') // 显示结果的消息
var resultClass = ref('') // 结果的样式类

var angle = ref(45)
var depth = ref(0.5)

const acupointInfo = ref({
  id: null,
  acupointName: '',
  pulse: '',
  orientation: '',
  description: '',
  operation: '',
})
const selectOption = (optionName: string) => {
  selectedAnswer.value = optionName
  validateAnswer()
}

const validateAnswer = () => {
  // 清空之前的结果消息
  resultMessage.value = ''

  // 验证答案
  if (selectedAnswer.value === correctAnswer.value.acupointName) {
    resultMessage.value = '正确答案！'
    resultClass.value = 'correct' // 设置样式类
    const result = selectedAnswer.value.replace('穴', '')
    // toggleHighlight(result);
    // unityContext.send('人体', 'ReceiveMessage', selectedAnswer.value)
  } else {
    resultMessage.value = '错误答案，重新选择！'
    resultClass.value = 'incorrect' // 设置样式类
  }
}

const selectedObject = ref('')

const unityContext = new UnityWebgl({
  loaderUrl: '/public/check/Build/check.loader.js',
  dataUrl: '/public/check/Build/check.data',
  frameworkUrl: '/public/check/Build/check.framework.js',
  codeUrl: '/public/check/Build/check.wasm',
})

// 模型状态管理
const modelList = ref(new Set())
const highlightedModel = ref(null)
var modelname = ref()

// 监听Unity模型点击事件
const handleModelClick = (event) => {
  const { name } = event.detail
  modelname = event.detail
  modelList.value.add(name)
  modelList.value = new Set([...modelList.value]) // 触发响应式更新
}

const unityFocusControl = {
  enable: () => {
    unityContext.send('FocusControl', 'OnUnityFocus')
    console.log('[DEBUG] 键盘捕获已启用 (可通过 unityFocusControl.disable() 关闭)')
  },
  disable: () => {
    unityContext.send('FocusControl', 'OnUnityBlur')
    console.log('[DEBUG] 键盘捕获已禁用 (可通过 unityFocusControl.enable() 开启)')
  },
  status: () => {
    const viewport = document.querySelector('.unity-viewport')
    console.log(`当前焦点状态: ${document.activeElement === viewport ? '已捕获' : '未捕获'}`)
    console.log(`控制方法:
      unityFocusControl.enable() - 强制捕获键盘
      unityFocusControl.disable() - 释放键盘控制`)
  },
}

// 暴露到全局（仅开发环境）
if (import.meta.env.DEV) {
  ;(window as any).unityFocusControl = unityFocusControl
}

const setupUnityFocusHandlers = () => {
  const unityViewport = document.querySelector('.unity-viewport') as HTMLElement

  if (!unityViewport) {
    console.warn('Unity viewport 元素未找到！')
    return
  }

  // 添加 tabindex 使元素可聚焦
  unityViewport.tabIndex = -1

  unityViewport.addEventListener('focus', unityFocusControl.enable)
  unityViewport.addEventListener('blur', unityFocusControl.disable)

  // 初始状态检查
  nextTick(() => {
    unityViewport.focus() // 默认自动获取焦点
  })
}
// 在 onMounted 中调用
onMounted(() => {
  // 你的现有监听器
  window.addEventListener('unity-model-click', handleModelClick)
  unityContext.on('error', console.error)

  // 初始化焦点控制（延迟确保DOM加载完成）
  setTimeout(setupUnityFocusHandlers, 500) // 适当延迟确保viewport已渲染
})

// 生命周期
onMounted(() => {
  window.addEventListener('unity-model-click', handleModelClick)
  unityContext.on('error', console.error)

  setTimeout(setupUnityFocusHandlers, 500) // 适当延迟确保viewport已渲染
})

onUnmounted(() => {
  window.removeEventListener('unity-model-click', handleModelClick)
})

const customOverlayStyle = {
  position: 'absolute',
  top: '20%',
  left: '-500px',
  width: '20%',
  height: '60%',
  backgroundColor: 'rgba(0, 0, 0, 0.5)', // 设置为半透明黑色背景
}

const customOverlayStyle_1 = {
  position: 'absolute',
  top: '20%',
  left: '80%',
  width: '20%',
  height: '60%',
  backgroundColor: 'rgba(0, 0, 0, 0.5)', // 设置为半透明黑色背景
}

const requireQuestion = async () => {
  const url = import.meta.env.VITE_API_URL + '/AcupuncturePoints/getProblem' // 使用 http 以避免 HTTPS 相关问题

  try {
    const response = await axios.get(url, {
      headers: {
        'Content-Type': 'application/json',
      },
    })

    if (response.data && response.data.success) {
      // 检查获取的数据格式
      // 确保 options 数组有足够的元素
      const options = response.data.data.options
      if (options.length >= 4) {
        radio1.value = options[0]
        radio2.value = options[1]
        radio3.value = options[2]
        radio4.value = options[3] // 确保有4个选项才赋值
      } else {
        console.error('选项数量不足:', options.length)
      }

      // 如果需要，处理正确答案 ID
      correctAnswer.value = response.data.data.answer

      console.log('请求成功')
    } else {
      console.error('请求成功但返回数据不匹配', response.data)
    }
  } catch (error) {
    // 增强的错误处理
    if (error.response) {
      console.error('服务器返回错误:', error.response.data)
    } else if (error.request) {
      console.error('请求未收到响应:', error.request)
    } else {
      console.error('请求出错:', error.message)
    }
  }
}

const requireAcupoint = async () => {
  // 要查询的腧⽳名称
  const acupointName = modelName.value + '穴'
  console.log(acupointName)
  // 定义请求的 URL
  const url = import.meta.env.VITE_API_URL + '/AcupuncturePoints/findByName'
  // 发送 POST 请求
  axios
    .post(url, acupointName, {
      headers: {
        'Content-Type': 'text/plain', // 请求头设置为纯⽂本
      },
    })
    .then((response: AxiosResponse) => {
      // 请求成功
      console.log('响应数据:', response.data)
      if (response.data.success) {
        acupointInfo.value = response.data.data.information // 正确访问信息
        console.log('acupointInfo:', acupointInfo.value)
        console.log('response.data.information:', response.data.data.information) // 第三次修正
      } else {
        console.error('查找失败:', response.data.errorMessage)
      }
      isVisible.value = true
    })
    .catch((error: AxiosError) => {
      // 请求失败
      if (error.response) {
        console.error('服务器返回错误:', error.response.data)
      } else if (error.request) {
        console.error('请求未收到响应:', error.request)
      } else {
        console.error('请求出错:', error.message)
      }
    })
}

const requireSimulateAcupoint = async () => {
  const url = import.meta.env.VITE_API_URL + '/AcupuncturePoints/getProblem' // 使用 http 以避免 HTTPS 相关问题

  try {
    const response = await axios.get(url, {
      headers: {
        'Content-Type': 'application/json',
      },
    })

    if (response.data && response.data.success) {
      simulateacupoint.value = response.data.data.answer.acupointName
      unityContext.send('人体', 'HandleIncomingData', simulateacupoint.value)

      console.log('simulateacupoint:', simulateacupoint.value)

      console.log('请求成功')
    } else {
      console.error('请求成功但返回数据不匹配', response.data)
    }
  } catch (error) {
    // 增强的错误处理
    if (error.response) {
      console.error('服务器返回错误:', error.response.data)
    } else if (error.request) {
      console.error('请求未收到响应:', error.request)
    } else {
      console.error('请求出错:', error.message)
    }
  }
}

const toggleOverlay = () => {
  if (isVisible_3) {
    isVisible.value = !isVisible.value // 切换显示状态
    isVisible_1.value = false
    isVisible_2.value = false
    isVisible_3.value = false
  }
}
const toggleOverlay_1 = () => {
  isVisible_1.value = !isVisible_1.value // 切换显示状态
  isVisible.value = false
  isVisible_2.value = false
  isVisible_3.value = false
  unityContext.send('人体', 'ReceiveMessage', 'ayin')
  if (radio1.value.id === null) {
    requireQuestion()
    unityContext.send('人体', 'ReceiveMessage', correctAnswer.value.acupointName)
  } else if (!isVisible_1.value) {
    radio1.value.id = null
  }
}

const toggleAIOverlay = async () => {
  isVisible_2.value = !isVisible_2.value
  isVisible.value = false
  isVisible_1.value = false
  isVisible_3.value = false
  if (isVisible_2.value) {
    await nextTick()
    // aiAnswerComponent.value?.focusInput()
  }
}

const toggleOverlay_2 = () => {
  isVisible_3.value = !isVisible_3.value
  isVisible.value = false
  isVisible_1.value = false
  isVisible_2.value = false
  if (isVisible_3.value) {
    requireSimulateAcupoint()
  } else {
    unityContext.send('人体', 'HandleIncomingData', 'ayin')
  }
}

const toBackHome = () => {
  router.push('/')
}

const showNextProblem = () => {
  isShowNextProblem.value = false
  requireSimulateAcupoint()
}

const compareStrings = async (str1: string, str2: string) => {
  if (str1 === str2) {
    showAngleDepthInputs.value = true
    // 这里不立即执行，等待用户点击确认按钮
  } else {
    console.log('字符串比对失败')
  }
}

const validateAngle = () => {
  angle.value = Math.max(0, Math.min(90, angle.value))
}

const validateDepth = () => {
  // 限制在0.1到3.0之间，并保留1位小数
  depth.value = parseFloat(Math.max(0.1, Math.min(3.0, depth.value)).toFixed(1))
}

const confirmInputs = () => {
  if (!angle.value || !depth.value) {
    console.log('请输入角度和深度')
    return
  }
  let targetName = simulateacupoint.value.slice(0, -1)
  console.log('處理後的 targetName:', targetName)

  unityContext.send(
    '人体',
    'PlayAnimation',
    JSON.stringify({
      targetName: targetName,
      angle: angle.value,
      depth: depth.value,
    }),
  )
  console.log('数据已发送')
  isShowNextProblem.value = true
}

const focusAIInput = () => {
  if (aiAnswerComponent.value && aiAnswerComponent.value.focusInput) {
    aiAnswerComponent.value.focusInput()
  }
}

const next = () => {
  console.log('下一题')
  resultMessage.value = ''
  selectedAnswer.value = ''
  requireQuestion()
}

// 处理接收到的消息
const handleMessage = (event) => {
  console.log('接收到消息，事件对象:', event)
  console.log('事件对象信息:', event.data)
  console.log('信息类型：', event.data.type)
  // 确保消息来自 Unity
  if (event.data) {
    // if (event.data) {
    console.log('接收到Unity消息，数据为:', event.data.data)

    // 更新词语
    modelName.value = event.data.data // 使用 .value 更新 ref 的值

    if (!isVisible_3.value) {
      console.log('可以执行')
      requireAcupoint()
    }
    compareStrings(modelName.value + '穴', simulateacupoint.value)
    console.log('isVisible_3', isVisible_3.value)
    isVisible_1.value = false
  } else {
    console.error('消息对象或数据无效:', event)
  }
}

// 组件挂载时设置事件监听器
onMounted(() => {
  console.log('Vue组件已加载，开始监听Unity消息...')
  window.addEventListener('message', handleMessage)
  console.log('消息监听器已注册，事件类型: message')
})

// 组件卸载前移除事件监听器
onBeforeUnmount(() => {
  console.log('Vue组件即将销毁，移除消息监听器...')
  window.removeEventListener('message', handleMessage)
})
</script>

<style scoped>
/* 基础样式 */
:root {
  --primary-color: rgba(0, 180, 255, 0.8);
  --secondary-color: rgba(0, 255, 180, 0.6);
  --accent-color: rgba(255, 100, 200, 0.8);
  --text-color: rgba(255, 255, 255, 0.9);
  --bg-color: rgba(10, 15, 25, 0.9);
  --panel-bg: rgba(20, 30, 40, 0.85);
  --border-color: rgba(0, 180, 255, 0.3);
  --correct-color: #00e676;
  --incorrect-color: #ff4081;
  --glow-effect: 0 0 15px var(--primary-color);
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
}

body,
html {
  width: 100%;
  height: 100%;
  overflow: hidden;
  background: #000;
}

.digital-twin-container {
  position: relative;
  width: 100vw;
  height: 100vh;
  overflow: hidden;
  color: var(--text-color);

  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: radial-gradient(circle at center, rgba(0, 50, 80, 0.2) 0%, rgba(0, 0, 0, 0.9) 70%);
    z-index: -1;
  }
}

.unity-viewport {
  position: absolute;
  width: 100%;
  height: 100%;
  z-index: 1;
}

/* 控制面板 */
.control-panel {
  position: absolute;
  bottom: 30px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 20px;
  z-index: 10;
  padding: 10px;
  background: rgba(0, 0, 0, 0.5);
  border-radius: 50px;
  backdrop-filter: blur(10px);
  box-shadow: 0 0 20px rgba(0, 180, 255, 0.3);
  border: 1px solid var(--border-color);
  color: rgb(74, 179, 202);
}

.holographic-btn {
  position: relative;
  padding: 12px 24px;
  background: linear-gradient(145deg, rgba(0, 50, 80, 0.5), rgba(0, 20, 40, 0.8));
  border: 1px solid var(--primary-color);
  color: var(--text-color);
  border-radius: 30px;
  cursor: pointer;
  font-size: 16px;
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 8px;
  transition: all 0.3s ease;
  overflow: hidden;
  box-shadow: 0 0 10px rgba(0, 180, 255, 0.2);

  &::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: linear-gradient(
      to bottom right,
      transparent 45%,
      var(--primary-color) 50%,
      transparent 55%
    );
    transform: rotate(30deg);
    opacity: 0;
    transition: all 0.5s ease;
  }

  &:hover {
    transform: translateY(-3px);
    box-shadow: 0 0 20px var(--primary-color);

    &::before {
      opacity: 0.5;
      animation: holographicEffect 2s linear infinite;
    }
  }

  i {
    font-size: 18px;
  }
}

/* 信息面板通用样式 */
.info-panel,
.quiz-panel,
.ai-panel {
  position: absolute;
  top: 20px;
  width: 350px;
  height: calc(100% - 40px);
  background: var(--panel-bg);
  backdrop-filter: blur(10px);
  border-radius: 15px;
  box-shadow: 0 0 30px rgba(0, 180, 255, 0.3);
  border: 1px solid var(--border-color);
  transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
  z-index: 10;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  color: rgb(74, 179, 202);

  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(
      135deg,
      rgba(0, 180, 255, 0.05) 0%,
      rgba(0, 180, 255, 0.02) 50%,
      rgba(0, 180, 255, 0.05) 100%
    );
    pointer-events: none;
  }
}

.info-panel {
  left: -400px;
}

.quiz-panel {
  right: -400px;
}

.ai-panel {
  right: -400px;
  width: 400px;
}

.panel-active {
  &.info-panel {
    left: 20px;
  }

  &.quiz-panel,
  &.ai-panel {
    right: 20px;
  }
}

.panel-header {
  padding: 15px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid var(--border-color);
  background: rgba(0, 0, 0, 0.3);

  h2 {
    font-size: 18px;
    font-weight: 600;
    color: var(--primary-color);
    text-shadow: 0 0 10px var(--primary-color);
  }
}

.close-btn {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid var(--border-color);
  color: var(--text-color);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;

  &:hover {
    background: rgba(255, 0, 0, 0.3);
    transform: rotate(90deg);
  }
}

.panel-content {
  padding: 20px;
  flex: 1;
  overflow-y: auto;
}

/* 穴位信息样式 */
.info-item {
  margin-bottom: 15px;

  label {
    display: block;
    font-size: 14px;
    color: var(--secondary-color);
    margin-bottom: 5px;
    font-weight: 500;
  }

  .info-value {
    padding: 10px;
    background: rgba(0, 0, 0, 0.3);
    border-radius: 8px;
    border-left: 3px solid var(--primary-color);
    font-size: 14px;
    line-height: 1.5;
  }
}

/* 测验面板样式 */
.question {
  font-size: 16px;
  line-height: 1.5;
  margin-bottom: 20px;
  padding: 15px;
  background: rgba(0, 0, 0, 0.3);
  border-radius: 10px;
  border-left: 3px solid var(--accent-color);
}

.options-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 15px;
  margin-bottom: 20px;
}

.option-card {
  padding: 15px;
  background: rgba(0, 0, 0, 0.3);
  border-radius: 10px;
  border: 1px solid var(--border-color);
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 10px;

  &:hover {
    transform: translateY(-3px);
    box-shadow: 0 5px 15px rgba(0, 180, 255, 0.2);
  }

  &.selected {
    background: rgba(0, 180, 255, 0.2);
    border-color: var(--primary-color);
    box-shadow: 0 0 15px rgba(0, 180, 255, 0.3);
  }
}

.option-label {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background: rgba(0, 180, 255, 0.2);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  color: var(--primary-color);
}

.option-text {
  flex: 1;
}

.result-feedback {
  padding: 12px;
  border-radius: 8px;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 10px;
  font-weight: 500;

  &.correct {
    background: rgba(0, 230, 118, 0.1);
    color: var(--correct-color);
    border-left: 3px solid var(--correct-color);
  }

  &.incorrect {
    background: rgba(255, 64, 129, 0.1);
    color: var(--incorrect-color);
    border-left: 3px solid var(--incorrect-color);
  }
}

.feedback-icon {
  font-size: 18px;

  &.icon-correct {
    color: var(--correct-color);
  }

  &.icon-incorrect {
    color: var(--incorrect-color);
  }
}

.next-btn {
  width: 100%;
  padding: 12px;
  background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
  border: none;
  border-radius: 8px;
  color: white;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  cursor: pointer;
  transition: all 0.3s ease;

  &:hover {
    transform: translateY(-3px);
    box-shadow: 0 5px 15px rgba(0, 180, 255, 0.4);
  }
}

/* 数字孪生效果 */
.digital-effects {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 0;
}

.grid-lines {
  position: absolute;
  width: 100%;
  height: 100%;
  background:
    linear-gradient(rgba(0, 180, 255, 0.05) 1px, transparent 1px),
    linear-gradient(90deg, rgba(0, 180, 255, 0.05) 1px, transparent 1px);
  background-size: 20px 20px;
}

.particles {
  position: absolute;
  width: 100%;
  height: 100%;

  &::before {
    content: '';
    position: absolute;
    width: 100%;
    height: 100%;
    background: radial-gradient(circle, var(--primary-color) 0%, transparent 70%);
    opacity: 0.05;
    animation: pulse 4s infinite alternate;
  }
}

.glow-effect {
  position: absolute;
  width: 100%;
  height: 100%;
  box-shadow: inset 0 0 100px rgba(0, 180, 255, 0.1);
}

.holographic-line {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 2px;
  background: linear-gradient(90deg, transparent, var(--primary-color), transparent);
  animation: scanline 3s linear infinite;
}

/* 滑块容器 */
.slider-container {
  display: flex;
  align-items: center;
  gap: 15px;
  margin: 8px 0;
}

/* 全息风格滑块 */
.holographic-slider {
  flex: 1;
  height: 6px;
  -webkit-appearance: none;
  background: rgba(0, 180, 255, 0.2);
  border-radius: 3px;
  outline: none;
  box-shadow:
    inset 0 1px 3px rgba(0, 0, 0, 0.4),
    0 0 5px var(--primary-color);
  transition: all 0.3s ease;
}

.holographic-slider:hover {
  box-shadow:
    inset 0 1px 3px rgba(0, 0, 0, 0.4),
    0 0 10px var(--primary-color);
}

/* 滑块拇指 */
.holographic-slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  width: 18px;
  height: 18px;
  border-radius: 50%;
  background: var(--primary-color);
  cursor: pointer;
  border: 2px solid rgba(255, 255, 255, 0.8);
  box-shadow:
    0 0 5px #fff,
    0 0 10px var(--primary-color);
  transition: all 0.3s ease;
}

.holographic-slider::-webkit-slider-thumb:hover {
  transform: scale(1.2);
  background: var(--accent-color);
  box-shadow:
    0 0 8px #fff,
    0 0 15px var(--accent-color);
}

/* 数字输入框 */
.holographic-input {
  width: 80px;
  padding: 8px 12px;
  background: rgba(20, 30, 40, 0.7);
  border: 1px solid var(--border-color);
  border-radius: 6px;
  color: var(--text-color);
  font-size: 14px;
  text-align: center;
  box-shadow:
    inset 0 0 10px rgba(0, 0, 0, 0.5),
    0 0 5px rgba(0, 180, 255, 0.3);
  transition: all 0.3s ease;
}

.holographic-input:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow:
    inset 0 0 10px rgba(0, 0, 0, 0.5),
    0 0 15px var(--primary-color);
}

/* 滑块标签 */
.slider-labels {
  display: flex;
  justify-content: space-between;
  margin-top: 5px;
  font-size: 12px;
  color: var(--secondary-color);
  opacity: 0.8;
}

/* 数值显示 */
.value-display {
  font-weight: bold;
  color: var(--accent-color);
  text-shadow: 0 0 8px var(--accent-color);
  min-width: 40px;
  display: inline-block;
  text-align: center;
}

.range-hint {
  font-size: 12px;
  color: var(--secondary-color);
  margin-left: 5px;
  opacity: 0.7;
}

/* 信息项样式 */
.info-item {
  margin-bottom: 20px;
  padding: 15px;
  background: rgba(20, 30, 40, 0.6);
  border-radius: 10px;
  border: 1px solid var(--border-color);
  box-shadow: 0 0 15px rgba(0, 180, 255, 0.2);
}

.info-item label {
  display: block;
  font-size: 14px;
  color: var(--secondary-color);
  margin-bottom: 10px;
  font-weight: 500;
  text-shadow: 0 0 5px rgba(0, 180, 255, 0.3);
}

/* 确认按钮 */
.confirm-btn {
  margin-top: 20px;
  padding: 12px 24px;
  background: linear-gradient(145deg, rgba(0, 50, 80, 0.7), rgba(0, 20, 40, 0.9));
  border: 1px solid var(--primary-color);
  color: var(--text-color);
  border-radius: 30px;
  font-size: 16px;
  font-weight: 500;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition: all 0.3s ease;
  box-shadow: 0 0 15px rgba(0, 180, 255, 0.3);
}

.confirm-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 20px var(--primary-color);
  background: linear-gradient(145deg, rgba(0, 80, 120, 0.7), rgba(0, 40, 60, 0.9));
}

.confirm-btn i {
  font-size: 18px;
  color: var(--accent-color);
}

/* 标签样式 */
.info-item label {
  display: block;
  font-size: 14px;
  color: var(--secondary-color);
  margin-bottom: 5px;
  font-weight: 500;
  text-shadow: 0 0 5px rgba(0, 180, 255, 0.3);
}

/* 修复滑块宽度问题的关键CSS */
.enhanced-slider {
  position: relative;
  width: 100%; /* 确保容器撑满 */
  padding: 15px;
  background: rgba(20, 30, 40, 0.6);
  border-radius: 10px;
  margin-bottom: 20px;
}

.slider-complete-container {
  width: 100%;
  position: relative;
  padding: 10px 0;
}

.full-width-slider {
  -webkit-appearance: none;
  width: 100% !important; /* 强制宽度 */
  height: 8px;
  margin: 15px 0;
  background: linear-gradient(90deg, var(--primary-color) 0%, rgba(0, 180, 255, 0.2) 100%);
  border-radius: 4px;
  outline: none;
}

/* 滑块轨道样式 (跨浏览器兼容) */
.full-width-slider::-webkit-slider-runnable-track {
  -webkit-appearance: none;
  width: 100%;
  height: 8px;
  background: transparent;
}

.full-width-slider::-moz-range-track {
  width: 100%;
  height: 8px;
  background: transparent;
}

/* 滑块拇指样式 */
.full-width-slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  width: 22px;
  height: 22px;
  margin-top: -7px; /* 垂直居中 */
  background: var(--accent-color);
  border: 2px solid white;
  border-radius: 50%;
  cursor: pointer;
  box-shadow: 0 0 10px rgba(0, 180, 255, 0.8);
}

.full-width-slider::-moz-range-thumb {
  width: 22px;
  height: 22px;
  background: var(--accent-color);
  border: 2px solid white;
  border-radius: 50%;
  cursor: pointer;
  box-shadow: 0 0 10px rgba(0, 180, 255, 0.8);
}

/* 刻度标记 */
.slider-ticks {
  display: flex;
  justify-content: space-between;
  padding: 5px 5px 0;
}

.slider-ticks span {
  font-size: 11px;
  color: var(--secondary-color);
  position: relative;
}

.slider-ticks span::before {
  content: '';
  position: absolute;
  top: -15px;
  left: 50%;
  width: 1px;
  height: 10px;
  background: rgba(0, 180, 255, 0.5);
}

/* 动画效果 */
@keyframes holographicEffect {
  0% {
    transform: rotate(30deg) translateX(-100%);
  }
  100% {
    transform: rotate(30deg) translateX(100%);
  }
}

@keyframes pulse {
  0% {
    transform: scale(0.8);
    opacity: 0.05;
  }
  100% {
    transform: scale(1.2);
    opacity: 0.1;
  }
}

@keyframes scanline {
  0% {
    transform: translateY(-100%);
  }
  100% {
    transform: translateY(100%);
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .info-panel,
  .quiz-panel,
  .ai-panel {
    width: 90%;
    height: 60%;
  }

  .panel-active {
    &.info-panel {
      left: 5%;
    }

    &.quiz-panel,
    &.ai-panel {
      right: 5%;
    }
  }

  .control-panel {
    flex-direction: column;
    left: 20px;
    transform: none;
    bottom: 20px;
  }
}
</style>
