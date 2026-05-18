<template>
  <div class="question-management">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <h2>题目列表</h2>
          <el-button type="primary" @click="goToAddQuestion">添加题目</el-button>
        </div>
      </template>

      <!-- 搜索和筛选区域 -->
      <div class="filter-area">
        <el-input
          v-model="searchQuery"
          placeholder="搜索题目内容"
          clearable
          style="width: 300px"
          @clear="handleSearchClear"
          @keyup.enter="fetchQuestions"
        >
          <template #append>
            <el-button icon="el-icon-search" @click="fetchQuestions" />
          </template>
        </el-input>

        <el-select
          v-model="activeFilter"
          placeholder="状态筛选"
          clearable
          style="width: 120px; margin-left: 10px"
          @change="fetchQuestions"
        >
          <el-option label="已启用" value="true" />
          <el-option label="已禁用" value="false" />
        </el-select>
      </div>

      <!-- 题目表格 -->
      <el-table :data="questions" border style="width: 100%" v-loading="loading">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column label="题目内容" min-width="200">
          <template #default="{ row }">
            <div class="question-content" v-html="formatQuestion(row.question)" />
          </template>
        </el-table-column>
        <el-table-column label="选项" width="300">
          <template #default="{ row }">
            <div class="options">
              <div>A. {{ row.optionA }}</div>
              <div>B. {{ row.optionB }}</div>
              <div>C. {{ row.optionC }}</div>
              <div>D. {{ row.optionD }}</div>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="correctAnswer" label="正确答案" width="100" />
        <el-table-column label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.isActive ? 'success' : 'danger'">
              {{ row.isActive ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createdAt" label="创建时间" width="180">
          <template #default="{ row }">
            {{ new Date(row.createdAt).toLocaleString() }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="180" fixed="right">
          <template #default="{ row }">
            <el-button size="small" @click="handleEdit(row)">编辑</el-button>
            <el-button
              size="small"
              :type="row.isActive ? 'danger' : 'success'"
              @click="toggleQuestionStatus(row)"
            >
              {{ row.isActive ? '禁用' : '启用' }}
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination">
        <el-pagination
          v-model:current-page="currentPage"
          v-model:page-size="pageSize"
          :total="total"
          :page-sizes="[10, 20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="fetchQuestions"
          @current-change="fetchQuestions"
        />
      </div>
    </el-card>

    <!-- 编辑对话框 -->
    <el-dialog v-model="editDialogVisible" title="编辑题目" width="60%">
      <QuestionForm
        v-if="editDialogVisible"
        :question-data="currentQuestion"
        mode="edit"
        @submit="handleUpdateQuestion"
        @cancel="editDialogVisible = false"
      />
    </el-dialog>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import QuestionForm from './QuestionForm.vue'

// 替换原来的mockApi为真实API调用
import api from '@/api/question'

export default {
  components: {
    QuestionForm,
  },
  setup() {
    const router = useRouter()

    // 数据
    const questions = ref([])
    const loading = ref(false)
    const currentPage = ref(1)
    const pageSize = ref(10)
    const total = ref(0)
    const searchQuery = ref('')
    const activeFilter = ref('true')

    // 编辑相关
    const editDialogVisible = ref(false)
    const currentQuestion = ref(null)

    // 模拟API调用
    // const mockApi = {
    //   getQuestions: (params) => {
    //     console.log('API调用参数:', params)
    //     return new Promise((resolve) => {
    //       setTimeout(() => {
    //         // 模拟数据
    //         const mockData = Array.from({ length: 50 }, (_, i) => ({
    //           id: i + 1,
    //           question: `中医针灸相关问题 ${i + 1}: 关于经络的说法哪个正确?`,
    //           optionA: `选项A内容 ${i + 1}`,
    //           optionB: `选项B内容 ${i + 1}`,
    //           optionC: `选项C内容 ${i + 1}`,
    //           optionD: `选项D内容 ${i + 1}`,
    //           correctAnswer: ['A', 'B', 'C', 'D'][i % 4],
    //           explanation: `这是题目 ${i + 1} 的解析内容`,
    //           isActive: i % 3 !== 0,
    //           createdAt: new Date(Date.now() - i * 3600000).toISOString(),
    //         }))

    //         // 模拟筛选
    //         let filteredData = [...mockData]
    //         if (params.search) {
    //           filteredData = filteredData.filter(
    //             (q) => q.question.includes(params.search) || q.explanation.includes(params.search),
    //           )
    //         }
    //         if (params.isActive) {
    //           filteredData = filteredData.filter((q) => String(q.isActive) === params.isActive)
    //         }

    //         // 模拟分页
    //         const start = (params.page - 1) * params.size
    //         const end = start + params.size
    //         const pageData = filteredData.slice(start, end)

    //         resolve({
    //           data: {
    //             content: pageData,
    //             totalElements: filteredData.length,
    //           },
    //         })
    //       }, 500)
    //     })
    //   },
    //   updateQuestion: (id, data) => {
    //     console.log('更新题目:', id, data)
    //     return new Promise((resolve) => {
    //       setTimeout(() => {
    //         resolve({ data: 'success' })
    //       }, 300)
    //     })
    //   },
    //   updateQuestionStatus: (id, isActive) => {
    //     console.log('更新状态:', id, isActive)
    //     return new Promise((resolve) => {
    //       setTimeout(() => {
    //         resolve({ data: 'success' })
    //       }, 300)
    //     })
    //   },
    // }

    // 获取题目列表
    // 修改fetchQuestions方法
    const fetchQuestions = async () => {
      try {
        loading.value = true
        const params = {
          page: currentPage.value,
          size: pageSize.value,
          search: searchQuery.value,
          isActive: activeFilter.value,
        }
        const res = await api.getQuestions(params)
        console.log(res)
        questions.value = res.data.content // Spring Data返回的数据结构
        total.value = res.data.totalElements
      } catch (error) {
        ElMessage.error('获取题目列表失败: ' + error.message)
      } finally {
        loading.value = false
      }
    }

    // 格式化题目内容
    const formatQuestion = (text) => {
      return text.replace(/\n/g, '<br>')
    }

    // 搜索清空
    const handleSearchClear = () => {
      searchQuery.value = ''
      fetchQuestions()
    }

    // 跳转到添加题目
    const goToAddQuestion = () => {
      router.push('/Manager/exam/AddQuestion')
    }

    // 编辑题目
    const handleEdit = (question) => {
      currentQuestion.value = { ...question }
      editDialogVisible.value = true
    }

    // 更新题目
    // 修改handleUpdateQuestion方法
    const handleUpdateQuestion = async (formData) => {
      try {
        await api.updateQuestion(currentQuestion.value.id, formData)
        ElMessage.success('题目更新成功')
        editDialogVisible.value = false
        fetchQuestions()
      } catch (error) {
        ElMessage.error('更新题目失败: ' + error.message)
      }
    }

    // 切换题目状态
    const toggleQuestionStatus = async (question) => {
      try {
        await ElMessageBox.confirm(
          `确定要${question.isActive ? '禁用' : '启用'}这个题目吗?`,
          '提示',
        )
        const newStatus = !question.isActive
        await api.updateQuestionStatus(question.id, newStatus)
        ElMessage.success(`题目已${newStatus ? '启用' : '禁用'}`)
        fetchQuestions()
      } catch (error) {
        if (error !== 'cancel') {
          ElMessage.error('操作失败: ' + error.message)
        }
      }
    }

    onMounted(() => {
      fetchQuestions()
    })

    return {
      questions,
      loading,
      currentPage,
      pageSize,
      total,
      searchQuery,
      activeFilter,
      editDialogVisible,
      currentQuestion,
      formatQuestion,
      handleSearchClear,
      goToAddQuestion,
      fetchQuestions,
      handleEdit,
      handleUpdateQuestion,
      toggleQuestionStatus,
    }
  },
}
</script>

<style scoped>
.question-management {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.filter-area {
  margin-bottom: 20px;
  display: flex;
}

.question-content {
  line-height: 1.5;
}

.options div {
  margin-bottom: 5px;
  line-height: 1.5;
}

.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}
</style>
