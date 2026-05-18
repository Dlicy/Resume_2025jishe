<template>
  <div class="drug-list-container">
    <div class="list-header">
      <h2>药物百科列表</h2>
      <div class="search-box">
        <input
          v-model="searchInput"
          type="search"
          placeholder="搜索药物名称或别称"
          @keyup.enter="handleSearch"
          class="search-input"
        />
        <button @click="handleSearch" class="refresh-btn">
          <span class="search-icon">🔍</span> 搜索
        </button>
        <button @click="refreshList" class="refresh-btn">
          <span class="refresh-icon">↻</span> 刷新
        </button>
      </div>
    </div>

    <div v-if="loading" class="loading-indicator">
      <div class="spinner"></div>
      加载中...
    </div>

    <div v-else-if="errorMessage" class="error-message">
      {{ errorMessage }}
      <button @click="fetchDrugs" class="retry-btn">重试</button>
    </div>

    <template v-else>
      <div v-if="drugs.length === 0" class="empty-state">
        <!-- <img src="@/assets/no-data.svg" alt="无数据" class="empty-image" /> -->
        <p>暂无药物数据</p>
      </div>

      <div v-else class="drug-grid">
        <div v-for="drug in filteredDrugs" :key="drug.id" class="drug-card">
          <div class="drug-image-container">
            <img
              v-if="drug.imageUrl"
              :src="drug.imageUrl"
              :alt="drug.mainName"
              class="drug-image"
            />
            <div v-else class="image-placeholder">暂无图片</div>
          </div>
          <div class="drug-info">
            <h3 class="drug-name">{{ drug.mainName }}</h3>
            <p class="drug-alias" v-if="drug.subName">别名：{{ drug.subName }}</p>
            <div class="drug-categories">
              <span class="category-badge">{{ drug.drugCategories }}</span>
              <span class="category-badge">{{ drug.drugCategory }}</span>
            </div>
            <div class="drug-actions">
              <button @click="viewDrugDetails(drug)" class="action-btn view">
                <i class="icon-eye"></i> 详情
              </button>
              <button @click="editDrug(drug)" class="action-btn edit">
                <i class="icon-edit"></i> 编辑
              </button>
              <button @click="confirmDeleteDrug(drug)" class="action-btn delete">
                <i class="icon-delete"></i> 删除
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="pagination-container">
        <div class="pagination-info">
          显示 {{ startItem }}-{{ endItem }} 条，共 {{ totalItems }} 条
        </div>
        <div class="pagination-controls">
          <button
            @click="changePage(currentPage - 1)"
            :disabled="currentPage === 1"
            class="page-btn"
          >
            上一页
          </button>
          <button
            v-for="page in visiblePages"
            :key="page"
            @click="changePage(page)"
            :class="{ active: currentPage === page }"
            class="page-btn"
          >
            {{ page }}
          </button>
          <button
            @click="changePage(currentPage + 1)"
            :disabled="currentPage === totalPages"
            class="page-btn"
          >
            下一页
          </button>
        </div>
      </div>
    </template>

    <!-- 药物详情对话框 -->
    <div v-if="showDetailDialog" class="dialog-overlay">
      <div class="dialog-content">
        <div class="dialog-header">
          <h3>药物详情</h3>
          <button @click="closeDrugDetailDialog" class="close-btn">&times;</button>
        </div>
        <div class="dialog-body">
          <div class="detail-image-container">
            <img
              v-if="currentDrug.imageUrl"
              :src="currentDrug.imageUrl"
              :alt="currentDrug.mainName"
              class="detail-image"
            />
            <div v-else class="image-placeholder">暂无图片</div>
          </div>
          <div class="detail-info">
            <div class="detail-row">
              <span class="detail-label">药物名称:</span>
              <span class="detail-value">{{ currentDrug.mainName }}</span>
            </div>
            <div class="detail-row" v-if="currentDrug.subName">
              <span class="detail-label">别名:</span>
              <span class="detail-value">{{ currentDrug.subName }}</span>
            </div>
            <div class="detail-row">
              <span class="detail-label">大类:</span>
              <span class="detail-value">{{ currentDrug.drugCategories }}</span>
            </div>
            <div class="detail-row">
              <span class="detail-label">小类:</span>
              <span class="detail-value">{{ currentDrug.drugCategory }}</span>
            </div>
            <div class="detail-row" v-if="currentDrug.description">
              <span class="detail-label">描述:</span>
              <span class="detail-value">{{ currentDrug.description }}</span>
            </div>
            <div class="detail-row" v-if="currentDrug.usage">
              <span class="detail-label">用法用量:</span>
              <span class="detail-value">{{ currentDrug.usage }}</span>
            </div>
            <div class="detail-row" v-if="currentDrug.sideEffects">
              <span class="detail-label">副作用:</span>
              <span class="detail-value">{{ currentDrug.sideEffects }}</span>
            </div>
          </div>
        </div>
        <div class="dialog-footer">
          <button @click="closeDrugDetailDialog" class="dialog-btn close">关闭</button>
        </div>
      </div>
    </div>

    <!-- 删除确认对话框 -->
    <div v-if="showDeleteDialog" class="dialog-overlay">
      <div class="dialog-content">
        <div class="dialog-header">
          <h3>确认删除</h3>
          <button @click="closeDeleteDialog" class="close-btn">&times;</button>
        </div>
        <div class="dialog-body">
          <p>确定要删除药物 "{{ currentDrug.mainName }}" 吗？此操作不可撤销。</p>
        </div>
        <div class="dialog-footer">
          <button @click="closeDeleteDialog" class="dialog-btn cancel">取消</button>
          <button @click="deleteDrug" class="dialog-btn delete">确认删除</button>
        </div>
      </div>
    </div>

    <!-- 编辑药物对话框 -->
    <div v-if="showEditDialog" class="dialog-overlay">
      <div class="dialog-content">
        <div class="dialog-header">
          <h3>编辑药物信息</h3>
          <button @click="closeDrugEditDialog" class="close-btn">&times;</button>
        </div>
        <div class="dialog-body">
          <form @submit.prevent="submitEditForm" class="edit-form">
            <div class="form-group">
              <label for="mainName">药物名称</label>
              <input id="mainName" v-model="editForm.mainName" type="text" required />
            </div>
            <div class="form-group">
              <label for="subName">别名</label>
              <input id="subName" v-model="editForm.subName" type="text" />
            </div>
            <div class="form-group">
              <label for="drugCategories">大类</label>
              <input id="drugCategories" v-model="editForm.drugCategories" type="text" required />
            </div>
            <div class="form-group">
              <label for="drugCategory">小类</label>
              <input id="drugCategory" v-model="editForm.drugCategory" type="text" required />
            </div>
            <div class="form-group">
              <label for="source">来源</label>
              <textarea id="description" v-model="editForm.source" rows="3"></textarea>
            </div>
            <div class="form-group">
              <label for="natureAndFlavor">性味</label>
              <textarea id="natureAndFlavor" v-model="editForm.natureAndFlavor" rows="3"></textarea>
            </div>
            <div class="form-group">
              <label for="processing">炮制</label>
              <textarea id="processing" v-model="editForm.processing" rows="3"></textarea>
            </div>
            <div class="form-group">
              <label for="characters">性状</label>
              <textarea id="characters" v-model="editForm.characters" rows="3"></textarea>
            </div>
            <div class="form-group">
              <label for="efficacy">功效</label>
              <textarea id="efficacy" v-model="editForm.efficacy" rows="3"></textarea>
            </div>
            <div class="form-group">
              <label for="meridians">经脉</label>
              <textarea id="meridians" v-model="editForm.meridians" rows="3"></textarea>
            </div>
            <div class="form-group">
              <label for="indications">主治</label>
              <textarea id="indications" v-model="editForm.indications" rows="3"></textarea>
            </div>
            <div class="form-group">
              <label for="usageAndDosage">用法用量</label>
              <textarea id="usageAndDosage" v-model="editForm.usageAndDosage" rows="3"></textarea>
            </div>
            <div class="form-group">
              <label for="contraindications">注意禁忌</label>
              <textarea
                id="contraindications"
                v-model="editForm.contraindications"
                rows="3"
              ></textarea>
            </div>
            <div class="form-group">
              <label for="formulas">药方</label>
              <textarea id="formulas" v-model="editForm.formulas" rows="3"></textarea>
            </div>
            <div class="form-group">
              <label for="imageUrl">图片URL</label>
              <input id="imageUrl" v-model="editForm.imageUrl" type="text" />
            </div>
            <div class="form-actions">
              <button @click="closeDrugEditDialog" class="dialog-btn cancel">取消</button>
              <button type="submit" class="dialog-btn submit">保存</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from 'axios'
import { ElAlert } from 'element-plus'

const api = axios.create({
  baseURL: 'http://localhost:8105/Encyclopedia',
})

// 数据状态
const drugs = ref([])
const loading = ref(true)
const errorMessage = ref('')
const searchInput = ref('') // 修改变量名为searchInput以匹配后端参数
const currentPage = ref(1)
const totalItems = ref(0)
const itemsPerPage = 9

// 详情和编辑相关状态
const showDetailDialog = ref(false)
const showEditDialog = ref(false)
const currentDrug = ref({})
const editForm = ref({
  id: '',
  mainName: '',
  subName: '',
  drugCategories: '',
  drugCategory: '',
  usageAndDosage: '',
  imageUrl: '',
  characters: '',
  contraindications: '',
  efficacy: '',
  formulas: '',
  meridians: '',
  natureAndFlavor: '',
  processing: '',
  source: '',
})

// 计算属性
const filteredDrugs = computed(() => {
  //   if (!searchInput.value) return drugs.value
  //   const query = searchInput.value.toLowerCase()
  //   return drugs.value.filter(
  //     (drug) =>
  //       drug.mainName.toLowerCase().includes(query) ||
  //       (drug.subName && drug.subName.toLowerCase().includes(query)),
  //   )
  return drugs.value
})

const totalPages = computed(() => Math.ceil(totalItems.value / itemsPerPage))
const startItem = computed(() => (currentPage.value - 1) * itemsPerPage + 1)
const endItem = computed(() => Math.min(currentPage.value * itemsPerPage, totalItems.value))

const visiblePages = computed(() => {
  const pages = []
  const maxVisible = 5
  let start = Math.max(1, currentPage.value - Math.floor(maxVisible / 2))
  let end = Math.min(totalPages.value, start + maxVisible - 1)

  if (end - start + 1 < maxVisible) {
    start = Math.max(1, end - maxVisible + 1)
  }

  for (let i = start; i <= end; i++) {
    pages.push(i)
  }
  return pages
})

// 方法
const fetchDrugs = async () => {
  try {
    loading.value = true
    errorMessage.value = ''
    const response = await axios.get('/Encyclopedia/getMaxHerbslists', {
      params: { page: currentPage.value },
    })

    if (response.data && response.data.success) {
      drugs.value = response.data.data.lists
      totalItems.value = response.data.data.total
    } else {
      throw new Error(response.data?.message || '获取数据失败')
    }
  } catch (error) {
    console.error('获取药物列表失败:', error)
    errorMessage.value = error.message || '获取药物列表失败，请稍后重试'
    drugs.value = []
  } finally {
    loading.value = false
  }
}

// 修改搜索方法
const handleSearch = async () => {
  try {
    loading.value = true
    errorMessage.value = ''

    const response = await axios.get('/Encyclopedia/Managersearch', {
      params: {
        input: searchInput.value,
      },
    })

    if (response.data && response.data.success) {
      drugs.value = response.data.data.lists
      totalItems.value = response.data.data.total
      currentPage.value = 1 // 搜索后重置到第一页
    } else {
      throw new Error(response.data?.message || '搜索失败')
    }
  } catch (error) {
    console.error('搜索药物失败:', error)
    errorMessage.value = error.message || '搜索药物失败，请稍后重试'
    drugs.value = []
  } finally {
    loading.value = false
  }
}

// 修改refreshList方法
const refreshList = () => {
  searchInput.value = ''
  currentPage.value = 1
  fetchDrugs()
}

const changePage = (page) => {
  if (page >= 1 && page <= totalPages.value) {
    currentPage.value = page
    fetchDrugs()
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }
}

// const viewDrugDetails = (drug) => {
//   // 实现查看详情逻辑
//   console.log('查看药物详情:', drug)
// }

// const editDrug = (drug) => {
//   // 实现编辑逻辑
//   console.log('编辑药物:', drug)
// }

// // 新增详情相关方法
// const viewDrugDetails = (drug) => {
//   currentDrug.value = { ...drug }
//   showDetailDialog.value = true
// }
// 新增详情相关方法
// 详情相关方法
const viewDrugDetails = (drug) => {
  currentDrug.value = { ...drug }
  showDetailDialog.value = true
}

const closeDrugDetailDialog = () => {
  showDetailDialog.value = false
}

// 编辑相关方法
const editDrug = (drug) => {
  currentDrug.value = drug
  editForm.value = {
    id: drug.id,
    mainName: drug.mainName,
    subName: drug.subName || '',
    drugCategories: drug.drugCategories || '',
    drugCategory: drug.drugCategory || '',
    imageUrl: drug.imageUrl || '',
    characters: drug.characters || '',
    contraindications: drug.contraindications || '',
    efficacy: drug.efficacy || '',
    formulas: drug.formulas || '',
    usageAndDosage: drug.usageAndDosage || '',
    meridians: drug.meridians || '',
    natureAndFlavor: drug.natureAndFlavor || '',
    processing: drug.processing || '',
    source: drug.source || '',
    indications: drug.indications || '',
  }
  showEditDialog.value = true
}

const closeDrugEditDialog = () => {
  showEditDialog.value = false
}

const submitEditForm = async () => {
  try {
    loading.value = true
    const response = await axios.put('/Encyclopedia/updateHerb', editForm.value)

    if (response.data && response.data.success) {
      // 更新本地数据
      const index = drugs.value.findIndex((d) => d.id === editForm.value.id)
      if (index !== -1) {
        drugs.value[index] = { ...editForm.value }
      }
      closeDrugEditDialog()
    } else {
      throw new Error(response.data?.message || '更新失败')
    }
  } catch (error) {
    console.error('更新药物失败:', error)
    errorMessage.value = error.message || '更新药物失败，请稍后重试'
  } finally {
    loading.value = false
  }
}

// 删除相关状态
const showDeleteDialog = ref(false)

// 删除相关方法
const confirmDeleteDrug = (drug) => {
  currentDrug.value = drug
  showDeleteDialog.value = true
}

const closeDeleteDialog = () => {
  showDeleteDialog.value = false
}

const deleteDrug = async () => {
  try {
    loading.value = true
    console.log('正在删除...')
    const response = await axios.delete(`/Encyclopedia/deleteHerb/${currentDrug.value.id}`)

    if (response.data && response.data.success) {
      // 从本地列表中移除
      drugs.value = drugs.value.filter((d) => d.id !== currentDrug.value.id)
      closeDeleteDialog()
    } else {
      throw new Error(response.data?.message || '删除失败')
    }
  } catch (error) {
    console.error('删除药物失败:', error)
    errorMessage.value = error.message || '删除药物失败，请稍后重试'
  } finally {
    loading.value = false
  }
}

// 生命周期钩子
onMounted(() => {
  fetchDrugs()
})
</script>

<style scoped>
.search-icon {
  font-size: 16px;
}
.drug-list-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 24px;
}

.list-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  flex-wrap: wrap;
  gap: 16px;
}

.search-box {
  display: flex;
  gap: 12px;
}

.search-input {
  padding: 10px 16px;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  font-size: 14px;
  width: 300px;
  transition: all 0.2s;
}

.search-input:focus {
  border-color: #4299e1;
  box-shadow: 0 0 0 2px rgba(66, 153, 225, 0.2);
  outline: none;
}

.refresh-btn {
  padding: 10px 16px;
  background-color: #f8fafc;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
  display: flex;
  align-items: center;
  gap: 6px;
}

.refresh-btn:hover {
  background-color: #edf2f7;
}

.refresh-icon {
  font-size: 16px;
}

.loading-indicator {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px;
  color: #718096;
}

.spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #e2e8f0;
  border-top: 4px solid #4299e1;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 16px;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

.error-message {
  padding: 20px;
  background-color: #fff5f5;
  color: #e53e3e;
  border-radius: 8px;
  text-align: center;
  margin: 20px 0;
}

.retry-btn {
  margin-top: 12px;
  padding: 8px 16px;
  background-color: #e53e3e;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px;
  color: #718096;
}

.empty-image {
  width: 150px;
  height: 150px;
  margin-bottom: 16px;
}

.drug-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 24px;
  margin-bottom: 32px;
}

/* 更新药物卡片样式 */
.drug-card {
  background: white;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  transition:
    transform 0.2s,
    box-shadow 0.2s;
  display: flex;
  flex-direction: column;
  height: 100%; /* 确保所有卡片高度一致 */
}

.drug-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
}

.drug-card:hover .drug-image {
  transform: scale(1.05);
}

.drug-info {
  padding: 16px;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.drug-name {
  margin: 0 0 8px;
  font-size: 18px;
  color: #2d3748;
  line-height: 1.3;
}

.drug-alias {
  margin: 0 0 12px;
  font-size: 14px;
  color: #718096;
  line-height: 1.4;
}

.drug-categories {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 16px;
}

.drug-actions {
  display: flex;
  gap: 8px;
  margin-top: auto; /* 将按钮推到卡片底部 */
  padding-top: 12px;
  border-top: 1px solid #f0f0f0;
}

.action-btn {
  flex: 1;
  padding: 8px 12px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.2s;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  white-space: nowrap;
}

.action-btn.view {
  background-color: #4299e1;
  color: white;
}

.action-btn.edit {
  background-color: #38a169;
  color: white;
}

.action-btn.delete {
  background-color: #e53e3e;
  color: white;
}

.dialog-btn.delete {
  background-color: #e53e3e;
  color: white;
  border: none;
}

.dialog-btn.delete:hover {
  background-color: #c53030;
}

/* 确保网格布局中卡片高度一致 */
.drug-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 24px;
  margin-bottom: 32px;
  align-items: stretch; /* 确保卡片拉伸填充 */
}

/* 图片容器保持固定比例 */
.drug-image-container {
  height: 180px;
  background-color: #f8fafc;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
}

.drug-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s;
}

.image-placeholder {
  color: #a0aeca;
  font-size: 14px;
}

/* 限制文本行数 */
.drug-name {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.drug-alias {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.category-badge {
  padding: 4px 8px;
  background-color: #ebf8ff;
  color: #3182ce;
  border-radius: 4px;
  font-size: 12px;
}

.drug-actions {
  display: flex;
  gap: 8px;
}

.action-btn {
  flex: 1;
  padding: 8px 12px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.2s;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
}

.action-btn.view {
  background-color: #4299e1;
  color: white;
}

.action-btn.edit {
  background-color: #38a169;
  color: white;
}

.action-btn:hover {
  opacity: 0.9;
}

.pagination-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 24px;
  flex-wrap: wrap;
  gap: 16px;
}

.pagination-info {
  color: #718096;
  font-size: 14px;
}

.pagination-controls {
  display: flex;
  gap: 8px;
}

.page-btn {
  padding: 8px 12px;
  border: 1px solid #e2e8f0;
  background-color: white;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s;
  min-width: 40px;
}

.page-btn:hover:not(:disabled) {
  background-color: #f8fafc;
}

.page-btn.active {
  background-color: #4299e1;
  color: white;
  border-color: #4299e1;
}

.page-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

@media (max-width: 768px) {
  .list-header {
    flex-direction: column;
    align-items: stretch;
  }

  .search-box {
    width: 100%;
  }

  .search-input {
    width: 100%;
  }

  .drug-grid {
    grid-template-columns: 1fr;
  }

  .pagination-container {
    flex-direction: column;
  }

  .pagination-controls {
    flex-wrap: wrap;
    justify-content: center;
  }
}

.dialog-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.dialog-content {
  background-color: white;
  border-radius: 8px;
  width: 90%;
  max-width: 800px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
}

.dialog-header {
  padding: 16px 24px;
  border-bottom: 1px solid #e2e8f0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.dialog-header h3 {
  margin: 0;
  font-size: 20px;
  color: #2d3748;
}

.close-btn {
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #718096;
  padding: 4px;
}

.close-btn:hover {
  color: #2d3748;
}

.dialog-body {
  padding: 24px;
}

.dialog-footer {
  padding: 16px 24px;
  border-top: 1px solid #e2e8f0;
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}

.dialog-btn {
  padding: 8px 16px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.2s;
}

.dialog-btn.close,
.dialog-btn.cancel {
  background-color: #f8fafc;
  border: 1px solid #e2e8f0;
  color: #2d3748;
}

.dialog-btn.close:hover,
.dialog-btn.cancel:hover {
  background-color: #edf2f7;
}

.dialog-btn.submit {
  background-color: #4299e1;
  color: white;
  border: none;
}

.dialog-btn.submit:hover {
  background-color: #3182ce;
}

/* 详情样式 */
.detail-image-container {
  width: 100%;
  height: 300px;
  margin-bottom: 20px;
  background-color: #f8fafc;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 8px;
  overflow: hidden;
}

.detail-image {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
}

.detail-info {
  display: grid;
  grid-template-columns: 1fr;
  gap: 16px;
}

.detail-row {
  display: flex;
  gap: 12px;
}

.detail-label {
  font-weight: 600;
  color: #2d3748;
  min-width: 80px;
}

.detail-value {
  color: #4a5568;
  flex: 1;
}

/* 编辑表单样式 */
.edit-form {
  display: grid;
  grid-template-columns: 1fr;
  gap: 16px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-group label {
  font-weight: 500;
  color: #2d3748;
}

.form-group input,
.form-group textarea {
  padding: 10px 12px;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  font-size: 14px;
  transition: all 0.2s;
}

.form-group input:focus,
.form-group textarea:focus {
  border-color: #4299e1;
  box-shadow: 0 0 0 2px rgba(66, 153, 225, 0.2);
  outline: none;
}

.form-group textarea {
  resize: vertical;
  min-height: 80px;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  margin-top: 16px;
}

@media (max-width: 768px) {
  .dialog-content {
    width: 95%;
  }

  .detail-row {
    flex-direction: column;
    gap: 4px;
  }

  .detail-label {
    min-width: auto;
  }
}
</style>
