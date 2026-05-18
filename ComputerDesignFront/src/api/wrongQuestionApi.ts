// src/api/wrongQuestionApi.ts
import examApi from './examApi'

export default {
  /**
   * 从考试历史中获取错题
   */
  async getWrongQuestions() {
    try {
      const user = JSON.parse(localStorage.getItem('user') || '{}')
      const exams = await examApi.getUserExamHistory(user.id)

      // 从所有考试中提取错题
      const wrongQuestions = []
      exams.forEach((exam) => {
        exam.answers?.forEach((answer) => {
          if (!answer.isCorrect) {
            wrongQuestions.push({
              ...answer.question,
              examId: exam.id,
              userAnswer: answer.userAnswer,
              wrongTime: exam.submissionTime,
              wrongTimes: 1, // 初始值，实际可以从历史数据统计
            })
          }
        })
      })
      console.log(wrongQuestions)

      return wrongQuestions
    } catch (error) {
      console.error('获取错题失败:', error)
      throw error
    }
  },
}
