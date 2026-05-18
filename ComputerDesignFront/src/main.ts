import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import axios from 'axios'
import '@fortawesome/fontawesome-free/css/all.min.css'

const app = createApp(App)

// 配置 Axios 基础 URL（根据你的实际后端地址）
axios.defaults.baseURL = import.meta.env.VITE_API_URL

// 请求拦截器 - 添加 Token
axios.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => {
    return Promise.reject(error)
  },
)

// 响应拦截器 - 处理错误
axios.interceptors.response.use(
  (response) => {
    return response
  },
  (error) => {
    if (error.response?.status === 401) {
      // Token 无效或过期
      localStorage.removeItem('token')
      localStorage.removeItem('user')
      router.push('/login')
    }
    return Promise.reject(error)
  },
)

// 将 axios 挂载到全局属性
app.config.globalProperties.$axios = axios

// 使用插件
app.use(router)
app.use(ElementPlus)

app.mount('#app')
