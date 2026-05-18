<template>
  <div class="chat-container">
    <div class="showanswer">
      <div v-for="(answer, index) in chatHistory" :key="index">
        {{ answer }}
      </div>
    </div>
    <div class="input-container">
      <el-input
        ref="inputRef"
        v-model="textarea"
        class="input-box"
        :autosize="{ minRows: 2, maxRows: 3 }"
        type="textarea"
        placeholder="Please input"
        @keyup.enter="sendQuestion"
      />
      <el-button @click="sendQuestion" type="success" round class="send-button"> 发送 </el-button>
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
.chat-container {
  display: flex;
  flex-direction: column; /* 垂直排列 */
  height: 70vh; /* 设置高度限制为 70vh */
  width: 20vw; /* 设置宽度限制为 30vw */
  border: 1px solid #ccc; /* 添加边框 */
  border-radius: 5px; /* 添加圆角 */
  background-color: #f9f9f9; /* 背景色 */
}

.showanswer {
  flex: 0.95; /* 让聊天记录区域占据剩余空间 */
  overflow-y: auto; /* 超出内容时添加垂直滚动条 */
  overflow-x: hidden; /* 隐藏水平滚动条（如果不需要） */
  margin-bottom: 10px; /* 增加聊天记录与输入区域之间的间距 */
  padding: 10px; /* 添加内边距 */
  color: black;
}
</style>
