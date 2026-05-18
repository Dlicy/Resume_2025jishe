import axios from 'axios'

// 最简单配置（只需设置baseURL）
const axio = axios.create({
  baseURL: import.meta.env.VITE_API_URL,
  
})

export default axio
