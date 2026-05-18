<template>
  <div class="holographic-chat-container">
    <div class="chat-display-panel">
      <div class="message-scroll-area">
        <div
          v-for="(answer, index) in chatHistory"
          :key="index"
          class="message-bubble"
          :class="{ 'ai-message': index % 2 === 0, 'user-message': index % 2 !== 0 }"
        >
          <div class="message-content">{{ answer }}</div>
          <!-- <div class="message-time">{{ formatTime(index) }}</div> -->
        </div>
      </div>
    </div>

    <div class="chat-input-panel">
      <div class="input-wrapper">
        <el-input
          ref="inputRef"
          v-model="textarea"
          class="holographic-input"
          :autosize="{ minRows: 2, maxRows: 3 }"
          type="textarea"
          placeholder="输入您的问题..."
          @keyup.enter="sendQuestion"
        />
        <el-button @click="sendQuestion" type="primary" class="send-button">
          <i class="fas fa-paper-plane"></i>
          <span>发送</span>
        </el-button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import axios, { AxiosResponse, AxiosError } from 'axios'
import { ref } from 'vue'

const textarea = ref('')
const chatHistory = ref<string[]>([]) // 用于存储聊天记录
const inputRef = ref(null) // 修改类型为 null

// 定义请求的 URL
const url = import.meta.env.VITE_API_URL + '/api/ask'

// 发送问题到 AI
const sendQuestion = () => {
  const question = textarea.value.trim() // 获取用户输入的问题并去除首尾空格
  if (!question) return // 如果问题为空，则不发送请求

  console.log('问题是：', question)

  // 发送 POST 请求
  axios
    .post(url, question, {
      headers: {
        'Content-Type': 'text/plain', // 请求体是纯字符串
      },
    })
    .then((response: AxiosResponse) => {
      // 请求成功
      console.log('响应数据:', response.data)
      if (response.data.success) {
        console.log('AI 回复:', response.data.data.iflyAnswer)
        // 更新聊天记录
        chatHistory.value.push(`用户: ${question}`)
        chatHistory.value.push(`AI: ${response.data.data.iflyAnswer}`)
        textarea.value = '' // 清空输入框
        // 让输入框重新获得焦点
        inputRef.value?.focus()
      } else {
        console.error('请求失败:', response.data.message)
      }
    })
    .catch((error: AxiosError) => {
      // 请求失败
      if (error.response) {
        console.error('服务器返回错误:', error.response.data.message)
      } else if (error.request) {
        console.error('请求未收到响应:', error.request)
      } else {
        console.error('请求出错:', error.message)
      }
    })
}
</script>

<style scoped>
.holographic-chat-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: rgba(20, 30, 40, 0.7);
  border-radius: 12px;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(0, 180, 255, 0.3);
  box-shadow: 0 0 20px rgba(0, 180, 255, 0.2);
  overflow: hidden;
}

.chat-display-panel {
  flex: 1;
  padding: 20px;
  overflow: hidden;
  position: relative;
}

.message-scroll-area {
  height: 100%;
  overflow-y: auto;
  padding-right: 10px;
}

/* 自定义滚动条 */
.message-scroll-area::-webkit-scrollbar {
  width: 6px;
}

.message-scroll-area::-webkit-scrollbar-thumb {
  background: rgba(0, 180, 255, 0.5);
  border-radius: 3px;
}

.message-scroll-area::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.2);
}

.message-bubble {
  margin-bottom: 15px;
  max-width: 80%;
  position: relative;
  padding: 12px 15px;
  border-radius: 12px;
  line-height: 1.5;
  animation: fadeIn 0.3s ease-out;
}

.ai-message {
  align-self: flex-start;
  background: rgba(0, 50, 80, 0.5);
  border-left: 3px solid var(--primary-color);
  margin-right: auto;
}

.user-message {
  align-self: flex-end;
  background: rgba(0, 80, 50, 0.5);
  border-right: 3px solid var(--secondary-color);
  margin-left: auto;
}

.message-content {
  font-size: 14px;
  color: rgba(255, 255, 255, 0.9);
}

.message-time {
  font-size: 10px;
  color: rgba(255, 255, 255, 0.5);
  text-align: right;
  margin-top: 5px;
}

.chat-input-panel {
  padding: 15px;
  background: rgba(0, 0, 0, 0.3);
  border-top: 1px solid rgba(0, 180, 255, 0.2);
}

.input-wrapper {
  display: flex;
  gap: 10px;
  align-items: flex-end;
}

.holographic-input {
  flex: 1;

  :deep(.el-textarea__inner) {
    background: rgba(10, 20, 30, 0.7) !important;
    border: 1px solid rgba(0, 180, 255, 0.3) !important;
    color: rgba(255, 255, 255, 0.9) !important;
    border-radius: 12px !important;
    padding: 12px 15px !important;
    box-shadow: 0 0 10px rgba(0, 180, 255, 0.1) !important;
    transition: all 0.3s ease !important;

    &:focus {
      border-color: var(--primary-color) !important;
      box-shadow: 0 0 15px var(--primary-color) !important;
    }

    &::placeholder {
      color: rgba(255, 255, 255, 0.4) !important;
    }
  }
}

.send-button {
  height: 44px;
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)) !important;
  border: none !important;
  border-radius: 12px !important;
  color: white !important;
  font-weight: 500 !important;
  transition: all 0.3s ease !important;
  box-shadow: 0 0 10px rgba(0, 180, 255, 0.3) !important;

  &:hover {
    transform: translateY(-2px) !important;
    box-shadow: 0 0 20px var(--primary-color) !important;
  }

  i {
    margin-right: 6px;
  }
}

/* 动画效果 */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .message-bubble {
    max-width: 90%;
  }

  .input-wrapper {
    flex-direction: column;
  }

  .send-button {
    width: 100%;
  }
}
</style>
