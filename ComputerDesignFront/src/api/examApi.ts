import axios from 'axios'

const apiClient = axios.create({
  baseURL: import.meta.env.VITE_API_URL,
  withCredentials: false,
  headers: {
    Accept: 'application/json',
    'Content-Type': 'application/json',
  },
})

export default {
  submitExam(examData) {
    return apiClient.post('/api/exams', examData)
  },
  async getUserExamHistory(userId, search) {
    try {
      const response = await apiClient.get('/api/exams/history', {
        params: { userId, search },
      })
      console.log(response)

      // 检查响应结构
      if (typeof response.data === 'string') {
        // 处理意外的字符串响应
        try {
          return JSON.parse(response.data)
        } catch (e) {
          throw new Error(`无效的响应格式: ${response.data}`)
        }
      }

      return response.data
    } catch (error) {
      console.error('API调用失败:', error)
      throw error
    }
  },

  getExamDetail(id) {
    return apiClient.get(`/api/exams/history/${id}`)
  },
}
