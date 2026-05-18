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
  import OverlayBox from './OverlayBox.vue'
  import UnityWebgl from 'unity-webgl'
  import VueUnity from 'unity-webgl/vue'
  import aianswer from './aianswer.vue'
  import type { AianswerExpose } from './aianswer.vue'
  
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
  const aiAnswerComponent = ref<AianswerExpose | null>(null)
  // 正确答案
  var correctAnswer = ref({
    id: null,
    acupointName: '',
    pulse: '',
    orientation: '',
    description: '',
    operation: '',
  }) // 设置正确答案
  
  var selectedAnswer = ref() // 用户选择的答案
  var resultMessage = ref('') // 显示结果的消息
  var resultClass = ref('') // 结果的样式类
  
  const acupointInfo = ref({
    id: null,
    acupointName: '',
    pulse: '',
    orientation: '',
    description: '',
    operation: '',
  })
  
  const validateAnswer = () => {
    // 清空之前的结果消息
    resultMessage.value = ''
  
    // 验证答案
    if (selectedAnswer.value === correctAnswer.value.acupointName) {
      resultMessage.value = '正确答案！'
      resultClass.value = 'correct' // 设置样式类
      const result = selectedAnswer.value.replace('穴', '')
      // toggleHighlight(result);
      unityContext.send('人体', 'ReceiveMessage', selectedAnswer.value)
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
  
  // 监听Unity模型点击事件
  const handleModelClick = (event) => {
    const { name } = event.detail
    modelList.value.add(name)
    modelList.value = new Set([...modelList.value]) // 触发响应式更新
  }
  
  // 高亮切换
  const toggleHighlight = (modelName) => {
    if (highlightedModel.value === modelName) {
      unityContext.send(modelName, 'SetHighlight', '0')
      highlightedModel.value = null
    } else {
      if (highlightedModel.value) {
        unityContext.send(highlightedModel.value, 'SetHighlight', '0')
      }
      unityContext.send(modelName, 'SetHighlight', '1')
      highlightedModel.value = modelName
    }
  }
  
  // 生命周期
  onMounted(() => {
    window.addEventListener('unity-model-click', handleModelClick)
    unityContext.on('error', console.error)
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
    const url = 'http://192.168.1.12:8088/AcupuncturePoints/getProblem' // 使用 http 以避免 HTTPS 相关问题
  
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
    const url = 'http://192.168.1.12:8088/AcupuncturePoints/findByName'
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
  
  const toggleOverlay = () => {
    isVisible.value = !isVisible.value // 切换显示状态
    isVisible_1.value = false
    isVisible_2.value = false
  }
  const toggleOverlay_1 = () => {
    isVisible_1.value = !isVisible_1.value // 切换显示状态
    isVisible.value = false
    isVisible_2.value = false
    if (radio1.value.id === null) {
      requireQuestion()
    }
  }
  
  const toggleAIOverlay = async () => {
    isVisible_2.value = !isVisible_2.value
    isVisible.value = false
    isVisible_1.value = false
    if (isVisible_2.value) {
      await nextTick()
      aiAnswerComponent.value?.focusInput()
    }
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
      requireAcupoint()
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
  