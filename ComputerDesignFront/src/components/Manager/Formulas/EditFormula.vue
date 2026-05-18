<template>
  <div class="formula-management-container">
    <!-- 搜索区域 -->
    <el-card class="search-card">
      <el-form :inline="true" :model="searchForm">
        <el-form-item label="关键词搜索">
          <el-input
            v-model="searchForm.keyword"
            placeholder="输入方剂名称/组成药材"
            clearable
            @clear="handleSearch"
          />
        </el-form-item>
        <el-form-item label="所属大类">
          <el-select
            v-model="searchForm.mainCategory"
            placeholder="选择大类"
            clearable
            @change="handleSearch"
          >
            <el-option
              v-for="item in mainCategories"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 数据表格 -->
    <el-card class="table-card">
      <el-table :data="tableData" border stripe v-loading="loading" style="width: 100%">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="name" label="方剂名称" width="180" />
        <el-table-column prop="mainCategory" label="大类" width="120" />
        <el-table-column prop="subCategory" label="小类" width="120" />
        <el-table-column prop="composition" label="组成药材" show-overflow-tooltip />
        <el-table-column label="操作" width="180" fixed="right">
          <template #default="scope">
            <el-button size="small" type="primary" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button size="small" type="danger" @click="handleDelete(scope.row.id)"
              >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination">
        <el-pagination
          v-model:current-page="pagination.currentPage"
          v-model:page-size="pagination.pageSize"
          :total="pagination.total"
          :page-sizes="[10, 20, 50]"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="fetchData"
          @current-change="fetchData"
        />
      </div>
    </el-card>

    <!-- 编辑对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="800px"
      @closed="handleDialogClosed"
    >
      <el-form ref="editForm" :model="editFormData" :rules="formRules" label-width="120px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="方剂名称" prop="name">
              <el-input v-model="editFormData.name" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="所属大类" prop="mainCategory">
              <el-select v-model="editFormData.mainCategory" @change="updateSubCategories">
                <el-option
                  v-for="item in mainCategories"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="所属小类" prop="subCategory">
              <el-select v-model="editFormData.subCategory">
                <el-option
                  v-for="item in subCategories"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="方剂出处" prop="source">
              <el-input v-model="editFormData.source" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="组成药材" prop="composition">
          <el-input v-model="editFormData.composition" type="textarea" :rows="3" />
        </el-form-item>

        <el-form-item label="方剂解释" prop="explanation">
          <el-input v-model="editFormData.explanation" type="textarea" :rows="3" />
        </el-form-item>

        <el-form-item label="方剂功用" prop="functions">
          <el-input v-model="editFormData.functions" type="textarea" :rows="2" />
        </el-form-item>

        <el-form-item label="主治" prop="indications">
          <el-input v-model="editFormData.indications" type="textarea" :rows="3" />
        </el-form-item>

        <el-form-item label="用法" prop="usageMethod">
          <el-input v-model="editFormData.usageMethod" />
        </el-form-item>

        <el-form-item label="注意事项" prop="precautions">
          <el-input v-model="editFormData.precautions" type="textarea" :rows="2" />
        </el-form-item>
      </el-form>

      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitEdit">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>
<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox, type FormInstance, type FormRules } from 'element-plus'
import axios from 'axios'

// 类型定义
interface Formula {
  id: number
  name: string
  mainCategory: string
  subCategory: string
  source: string
  classification: string
  composition: string
  explanation: string
  functions: string
  indications: string
  usageMethod: string
  precautions: string
}

// 表单类型（新增/编辑共用）
type FormulaForm = Partial<Formula> & {
  id?: number
}

interface SearchParams {
  keyword?: string
  mainCategory?: string
}

// 数据状态
const loading = ref(false)
const tableData = ref<Formula[]>([])
const dialogVisible = ref(false)
const dialogTitle = ref('')
const editForm = ref<FormInstance>()
const isEditMode = ref(false)
const currentEditId = ref<number | null>(null)

// 表单数据
const searchForm = reactive<SearchParams>({
  keyword: '',
  mainCategory: '',
})

const editFormData = reactive<FormulaForm>({
  name: '',
  mainCategory: '',
  subCategory: '',
  source: '',
  classification: '',
  composition: '',
  explanation: '',
  functions: '',
  indications: '',
  usageMethod: '',
  precautions: '',
})

// 分页
const pagination = reactive({
  currentPage: 1,
  pageSize: 10,
  total: 0,
})

// 分类选项
const mainCategories = ref([
  { value: '补益剂', label: '补益剂' },
  { value: '解表剂', label: '解表剂' },
  { value: '清热剂', label: '清热剂' },
  { value: '祛湿剂', label: '祛湿剂' },
])

const subCategories = ref<{ value: string; label: string }[]>([])

// 表单验证规则
const formRules = reactive<FormRules<FormulaForm>>({
  name: [{ required: true, message: '请输入方剂名称', trigger: 'blur' }],
  mainCategory: [{ required: true, message: '请选择所属大类', trigger: 'change' }],
  composition: [{ required: true, message: '请输入组成药材', trigger: 'blur' }],
})

// 生命周期钩子
onMounted(() => {
  fetchData()
})

// 获取数据
const fetchData = async () => {
  try {
    loading.value = true
    const params = {
      page: pagination.currentPage - 1,
      size: pagination.pageSize,
      input: searchForm.keyword,
      main_category: searchForm.mainCategory,
    }

    const response = await axios.get('/encyclopedia/formulas/searchFormulas', { params })
    if (response.data.success) {
      tableData.value = response.data.data.content
      pagination.total = response.data.data.totalElements
    }
  } catch (error) {
    ElMessage.error('获取数据失败')
    console.error(error)
  } finally {
    loading.value = false
  }
}

// 搜索处理
const handleSearch = () => {
  pagination.currentPage = 1
  fetchData()
}

// 重置搜索
const resetSearch = () => {
  searchForm.keyword = ''
  searchForm.mainCategory = ''
  handleSearch()
}

// 打开编辑对话框
const handleEdit = (row: Formula) => {
  isEditMode.value = true
  dialogTitle.value = '编辑方剂'
  currentEditId.value = row.id
  Object.assign(editFormData, row)
  updateSubCategories()
  dialogVisible.value = true
}

// 提交编辑
const submitEdit = async () => {
  try {
    await editForm.value?.validate()

    if (isEditMode.value) {
      if (!currentEditId.value) {
        ElMessage.error('缺少方剂ID')
        return
      }
      // 更新逻辑
      await axios.put(`/encyclopedia/formulas/updateFormula/${currentEditId.value}`, editFormData)
      ElMessage.success('更新成功')
    } else {
      // 新增逻辑
      await axios.post('/encyclopedia/formulas/addFormula', editFormData)
      ElMessage.success('添加成功')
    }

    dialogVisible.value = false
    fetchData()
  } catch (error) {
    ElMessage.error('提交失败')
    console.error(error)
  }
}

// 删除处理
const handleDelete = (id: number) => {
  ElMessageBox.confirm('确定要删除此方剂吗？', '警告', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  })
    .then(async () => {
      try {
        await axios.delete(`/encyclopedia/formulas/deleteFormula/${id}`)
        ElMessage.success('删除成功')
        fetchData()
      } catch (error) {
        ElMessage.error('删除失败')
      }
    })
    .catch(() => {})
}

// 更新小类选项
const updateSubCategories = () => {
  const mainCategory = editFormData.mainCategory
  const subCategoryMap: Record<string, Array<{ value: string; label: string }>> = {
    补益剂: [
      { value: '补气剂', label: '补气剂' },
      { value: '补血剂', label: '补血剂' },
    ],
    解表剂: [
      { value: '辛温解表剂', label: '辛温解表剂' },
      { value: '辛凉解表剂', label: '辛凉解表剂' },
    ],
  }
  subCategories.value = subCategoryMap[mainCategory] || []
}

// 对话框关闭处理
const handleDialogClosed = () => {
  editForm.value?.resetFields()
  currentEditId.value = null
  Object.assign(editFormData, {
    name: '',
    mainCategory: '',
    subCategory: '',
    source: '',
    classification: '',
    composition: '',
    explanation: '',
    functions: '',
    indications: '',
    usageMethod: '',
    precautions: '',
  })
  isEditMode.value = false
}
</script>

<style scoped>
.formula-management-container {
  padding: 20px;
}

.search-card {
  margin-bottom: 20px;
}

.table-card {
  margin-bottom: 20px;
}

.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}

.el-form-item {
  margin-bottom: 18px;
}
</style>
