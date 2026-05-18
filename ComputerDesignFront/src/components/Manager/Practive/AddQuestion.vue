<template>
  <div class="add-question">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <h2>添加新题目</h2>
          <el-button @click="goBack">返回列表</el-button>
        </div>
      </template>

      <QuestionForm mode="add" @submit="handleAddQuestion" @cancel="goBack" />
    </el-card>
  </div>
</template>

<script>
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import QuestionForm from './QuestionForm.vue'
import api from '@/api/question'

export default {
  components: {
    QuestionForm,
  },
  setup() {
    const router = useRouter()

    // 模拟API调用
    const mockApi = {
      addQuestion: (data) => {
        console.log('添加题目:', data)
        return new Promise((resolve) => {
          setTimeout(() => {
            resolve({ data: 'success' })
          }, 300)
        })
      },
    }

    // 添加题目
    const handleAddQuestion = async (formData) => {
      try {
        await api.addQuestion(formData)
        ElMessage.success('题目添加成功')
        router.push('/Manager/exam/EditQuestion')
      } catch (error) {
        ElMessage.error('添加题目失败: ' + error.message)
      }
    }

    // 返回列表
    const goBack = () => {
      router.push('/Manager/exam/EditQuestion')
    }

    return {
      handleAddQuestion,
      goBack,
    }
  },
}
</script>

<style scoped>
.add-question {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
