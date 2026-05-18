import axios from 'axios'

export default {
  // 获取随机题目
  getRandomQuestions(count) {
    return axios.get('/api/questions/random', {
      params: { count },
    })
  },
  // 获取分页题目列表
  getQuestions(params) {
    return axios.get('/api/questions/list', {
      params: {
        search: params.search,
        isActive: params.isActive,
        page: params.page - 1, // Spring分页从0开始
        size: params.size,
      },
    })
  },

  // 添加题目
  addQuestion(question) {
    return axios.post('/api/questions', question)
  },

  // 更新题目
  updateQuestion(id, question) {
    return axios.put(`/api/questions/${id}`, question)
  },

  // 更新题目状态
  updateQuestionStatus(id, isActive) {
    return axios.patch(`/api/questions/${id}/status?isActive=${isActive}`)
  },
}
