<template>
  <div class="acupoint-management">
    <div class="header-section">
      <h2>穴位管理</h2>
      <div class="search-container">
        <div class="search-wrapper">
          <input
            v-model.trim="searchQuery"
            type="search"
            placeholder="输入穴位名称、经络路径等..."
            class="search-box"
            @input="handleSearchInput"
          />
          <button
            v-if="searchQuery"
            @click="clearSearch"
            class="clear-search-btn"
            aria-label="清除搜索"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
      </div>

      <div v-if="searchQuery" class="search-status">
        找到 {{ filteredAcupoints.length }} 条匹配 "{{ searchQuery }}" 的结果
        <button v-if="filteredAcupoints.length === 0" @click="clearSearch" class="text-link">
          清除搜索
        </button>
      </div>
    </div>

    <div class="table-container">
      <table class="acupoint-table">
        <thead>
          <tr>
            <th class="name-col">穴位名称</th>
            <th class="path-col">经络路径</th>
            <th class="position-col">世界坐标</th>
            <th class="local-col">局部坐标</th>
            <th class="actions-col">操作</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="acupoint in paginatedAcupoints" :key="acupoint.id">
            <td class="name-col">
              <div class="acupoint-name">{{ acupoint.modelName }}</div>
            </td>
            <td class="path-col">
              <div class="meridian-path">{{ acupoint.path }}</div>
            </td>
            <td class="position-col">
              <div class="coordinates">
                <span>X: {{ acupoint.position.x.toFixed(6) }}</span>
                <span>Y: {{ acupoint.position.y.toFixed(6) }}</span>
                <span>Z: {{ acupoint.position.z.toFixed(6) }}</span>
              </div>
            </td>
            <td class="local-col">
              <div class="coordinates">
                <span>X: {{ acupoint.localPosition.x.toFixed(6) }}</span>
                <span>Y: {{ acupoint.localPosition.y.toFixed(6) }}</span>
                <span>Z: {{ acupoint.localPosition.z.toFixed(6) }}</span>
              </div>
            </td>
            <td class="actions-col">
              <div class="action-buttons">
                <button @click="openEditModal(acupoint)" class="action-btn edit">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="14"
                    height="14"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                    <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                  </svg>
                </button>
                <button @click="confirmDelete(acupoint.id)" class="action-btn delete">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="14"
                    height="14"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <polyline points="3 6 5 6 21 6"></polyline>
                    <path
                      d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                    ></path>
                  </svg>
                </button>
              </div>
            </td>
          </tr>
          <tr v-if="filteredAcupoints.length === 0">
            <td colspan="5" class="no-results">
              {{ searchQuery ? '没有找到匹配的穴位' : '暂无穴位数据' }}
              <button v-if="searchQuery" @click="clearSearch" class="text-link">
                清除搜索条件
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="pagination-container" v-if="totalPages > 1">
      <button
        @click="currentPage = Math.max(1, currentPage - 1)"
        :disabled="currentPage === 1"
        class="pagination-nav"
      >
        上一页
      </button>

      <div class="page-numbers">
        <button
          v-for="page in visiblePages"
          :key="page"
          @click="currentPage = page"
          :class="{ active: currentPage === page }"
          class="page-btn"
        >
          {{ page }}
        </button>
      </div>

      <button
        @click="currentPage = Math.min(totalPages, currentPage + 1)"
        :disabled="currentPage === totalPages"
        class="pagination-nav"
      >
        下一页
      </button>
    </div>

    <!-- 编辑模态框 -->
    <div v-if="isEditModalOpen" class="modal-overlay" @click.self="closeEditModal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>编辑穴位</h3>
          <button @click="closeEditModal" class="close-modal-btn">&times;</button>
        </div>

        <div class="form-grid">
          <div class="form-group">
            <label>穴位名称</label>
            <input
              v-model="currentEditAcupoint.modelName"
              type="text"
              class="form-input"
              placeholder="如：璇玑"
            />
          </div>

          <div class="form-group">
            <label>经络路径</label>
            <input
              v-model="currentEditAcupoint.path"
              type="text"
              class="form-input"
              placeholder="如：人体/任脉/璇玑"
            />
          </div>

          <div class="position-section">
            <h4>世界坐标</h4>
            <div class="coord-grid">
              <div class="coord-input">
                <label>X</label>
                <input
                  v-model.number="currentEditAcupoint.position.x"
                  type="number"
                  step="0.000001"
                />
              </div>
              <div class="coord-input">
                <label>Y</label>
                <input
                  v-model.number="currentEditAcupoint.position.y"
                  type="number"
                  step="0.000001"
                />
              </div>
              <div class="coord-input">
                <label>Z</label>
                <input
                  v-model.number="currentEditAcupoint.position.z"
                  type="number"
                  step="0.000001"
                />
              </div>
            </div>
          </div>

          <div class="position-section">
            <h4>局部坐标</h4>
            <div class="coord-grid">
              <div class="coord-input">
                <label>X</label>
                <input
                  v-model.number="currentEditAcupoint.localPosition.x"
                  type="number"
                  step="0.000001"
                />
              </div>
              <div class="coord-input">
                <label>Y</label>
                <input
                  v-model.number="currentEditAcupoint.localPosition.y"
                  type="number"
                  step="0.000001"
                />
              </div>
              <div class="coord-input">
                <label>Z</label>
                <input
                  v-model.number="currentEditAcupoint.localPosition.z"
                  type="number"
                  step="0.000001"
                />
              </div>
            </div>
          </div>

          <div class="rotation-section">
            <h4>旋转参数</h4>
            <div class="coord-grid">
              <div class="coord-input">
                <label>X</label>
                <input
                  v-model.number="currentEditAcupoint.rotation.x"
                  type="number"
                  step="0.000001"
                />
              </div>
              <div class="coord-input">
                <label>Y</label>
                <input
                  v-model.number="currentEditAcupoint.rotation.y"
                  type="number"
                  step="0.000001"
                />
              </div>
              <div class="coord-input">
                <label>Z</label>
                <input
                  v-model.number="currentEditAcupoint.rotation.z"
                  type="number"
                  step="0.000001"
                />
              </div>
              <div class="coord-input">
                <label>W</label>
                <input
                  v-model.number="currentEditAcupoint.rotation.w"
                  type="number"
                  step="0.000001"
                />
              </div>
            </div>
          </div>

          <div class="scale-section">
            <h4>缩放比例</h4>
            <div class="coord-grid">
              <div class="coord-input">
                <label>X</label>
                <input v-model.number="currentEditAcupoint.scale.x" type="number" step="0.000001" />
              </div>
              <div class="coord-input">
                <label>Y</label>
                <input v-model.number="currentEditAcupoint.scale.y" type="number" step="0.000001" />
              </div>
              <div class="coord-input">
                <label>Z</label>
                <input v-model.number="currentEditAcupoint.scale.z" type="number" step="0.000001" />
              </div>
            </div>
          </div>
        </div>

        <div class="modal-footer">
          <button @click="closeEditModal" class="btn cancel-btn">取消</button>
          <button @click="updateAcupoint()" class="btn save-btn" :disabled="isSaving">
            <span v-if="isSaving">保存中...</span>
            <span v-else>保存</span>
          </button>
        </div>

        <div v-if="errorMessage" class="error-message">
          {{ errorMessage }}
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue'
import axios from 'axios'

interface Position {
  x: number
  y: number
  z: number
}

interface Rotation {
  x: number
  y: number
  z: number
  w: number
}

interface Scale {
  x: number
  y: number
  z: number
}

interface Acupoint {
  id?: number
  modelName: string
  path: string
  position: Position
  localPosition: Position
  rotation: Rotation
  localRotation: Rotation
  scale: Scale
}

// Reactive data
const acupoints = ref<Acupoint[]>([])
const searchQuery = ref('')
const currentPage = ref(1)
const itemsPerPage = 10
const isLoading = ref(false)
const errorMessage = ref('')
const isEditModalOpen = ref(false)
const currentEditAcupoint = ref<Acupoint | null>(null)
const isSaving = ref(false)

// API configuration - 更新为你的后端路由
const API_BASE = import.meta.env.VITE_API_URL // 根据你的实际后端地址调整
const API_ENDPOINTS = {
  GET_ACUPOINTS: `/api/unity/points/with-id`,
  UPDATE_ACUPOINT: (id: number) => `/api/unity/points/${id}`,
  DELETE_ACUPOINT: (id: number) => `/api/unity/points/${id}`,
  ADD_ACUPOINT: `/api/unity/points`,
}

// 获取穴位列表
const fetchAcupoints = async () => {
  isLoading.value = true
  errorMessage.value = ''
  try {
    const response = await axios.get(API_ENDPOINTS.GET_ACUPOINTS)
    // 后端返回的是包含models字段的wrapper对象
    acupoints.value = response.data.models || []
  } catch (error) {
    if (axios.isAxiosError(error)) {
      errorMessage.value = error.response?.data?.message || '获取穴位列表失败，请稍后重试'
    } else {
      errorMessage.value = '获取穴位列表失败，请稍后重试'
    }
    console.error('Error fetching acupoints:', error)
    acupoints.value = []
  } finally {
    isLoading.value = false
  }
}

// 添加新穴位
const addAcupoint = async () => {
  if (!currentEditAcupoint.value) return

  isSaving.value = true
  errorMessage.value = ''

  try {
    const response = await axios.post(
      API_ENDPOINTS.ADD_ACUPOINT,
      convertToBackendFormat(currentEditAcupoint.value),
    )

    if (!response.data?.success) {
      throw new Error(response.data?.message || '添加穴位失败')
    }

    await fetchAcupoints()
    closeEditModal()
  } catch (error) {
    if (axios.isAxiosError(error)) {
      errorMessage.value = error.response?.data?.message || '添加穴位失败'
    } else {
      errorMessage.value = error instanceof Error ? error.message : '添加穴位失败'
    }
    console.error('Error adding acupoint:', error)
  } finally {
    isSaving.value = false
  }
}

// 更新穴位
const updateAcupoint = async () => {
  if (!currentEditAcupoint.value?.id) return

  isSaving.value = true
  errorMessage.value = ''

  try {
    const response = await axios.put(
      API_ENDPOINTS.UPDATE_ACUPOINT(currentEditAcupoint.value.id),
      convertToBackendFormat(currentEditAcupoint.value),
    )

    if (!response.data?.success) {
      throw new Error(response.data?.message || '更新失败')
    }

    await fetchAcupoints()
    closeEditModal()
  } catch (error) {
    if (axios.isAxiosError(error)) {
      errorMessage.value = error.response?.data?.message || '更新穴位失败'
    } else {
      errorMessage.value = error instanceof Error ? error.message : '更新穴位失败'
    }
    console.error('Error updating acupoint:', error)
  } finally {
    isSaving.value = false
  }
}

// 删除穴位
const confirmDelete = async (id: number) => {
  if (!confirm('确定要删除这个穴位吗？此操作不可恢复。')) return

  isLoading.value = true
  errorMessage.value = ''

  try {
    const response = await axios.delete(API_ENDPOINTS.DELETE_ACUPOINT(id))

    if (!response.data?.success) {
      throw new Error(response.data?.message || '删除穴位失败')
    }

    await fetchAcupoints()
  } catch (error) {
    if (axios.isAxiosError(error)) {
      errorMessage.value = error.response?.data?.message || '删除穴位失败'
    } else {
      errorMessage.value = error instanceof Error ? error.message : '删除穴位失败'
    }
    console.error('Error deleting acupoint:', error)
  } finally {
    isLoading.value = false
  }
}

// 将前端数据结构转换为后端需要的格式
const convertToBackendFormat = (acupoint: Acupoint): any => {
  return {
    modelName: acupoint.modelName,
    path: acupoint.path,
    positionX: acupoint.position.x,
    positionY: acupoint.position.y,
    positionZ: acupoint.position.z,
    localPositionX: acupoint.localPosition.x,
    localPositionY: acupoint.localPosition.y,
    localPositionZ: acupoint.localPosition.z,
    rotationX: acupoint.rotation.x,
    rotationY: acupoint.rotation.y,
    rotationZ: acupoint.rotation.z,
    rotationW: acupoint.rotation.w,
    localRotationX: acupoint.localRotation.x,
    localRotationY: acupoint.localRotation.y,
    localRotationZ: acupoint.localRotation.z,
    localRotationW: acupoint.localRotation.w,
    scaleX: acupoint.scale.x,
    scaleY: acupoint.scale.y,
    scaleZ: acupoint.scale.z,
  }
}

// 打开编辑模态框 - 添加默认值处理
const openEditModal = (acupoint?: Acupoint) => {
  currentEditAcupoint.value = acupoint
    ? JSON.parse(JSON.stringify(acupoint))
    : {
        modelName: '',
        path: '',
        position: { x: 0, y: 0, z: 0 },
        localPosition: { x: 0, y: 0, z: 0 },
        rotation: { x: 0, y: 0, z: 0, w: 1 },
        localRotation: { x: 0, y: 0, z: 0, w: 1 },
        scale: { x: 1, y: 1, z: 1 },
      }
  isEditModalOpen.value = true
}

// 关闭模态框
const closeEditModal = () => {
  isEditModalOpen.value = false
  currentEditAcupoint.value = null
  errorMessage.value = ''
}

// 搜索和分页逻辑
const filteredAcupoints = computed(() => {
  const query = searchQuery.value.toLowerCase().trim()
  if (!query) return acupoints.value

  return acupoints.value.filter(
    (ap) => ap.modelName.toLowerCase().includes(query) || ap.path.toLowerCase().includes(query),
  )
})

const paginatedAcupoints = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage
  return filteredAcupoints.value.slice(start, start + itemsPerPage)
})

const totalPages = computed(() => {
  return Math.ceil(filteredAcupoints.value.length / itemsPerPage)
})

const visiblePages = computed(() => {
  const maxVisible = 5
  const half = Math.floor(maxVisible / 2)
  let start = Math.max(1, currentPage.value - half)
  let end = Math.min(totalPages.value, start + maxVisible - 1)

  if (end - start + 1 < maxVisible) {
    start = Math.max(1, end - maxVisible + 1)
  }

  const pages = []
  for (let i = start; i <= end; i++) {
    pages.push(i)
  }
  return pages
})

const clearSearch = () => {
  searchQuery.value = ''
  currentPage.value = 1
}

const handleSearchInput = () => {
  currentPage.value = 1
}

// 初始化组件
onMounted(() => {
  fetchAcupoints()
})

// 搜索条件变化时重置页码
watch(searchQuery, () => {
  currentPage.value = 1
})
</script>

<style scoped>
.acupoint-management {
  font-family:
    'Inter',
    -apple-system,
    BlinkMacSystemFont,
    sans-serif;
  color: #2d3748;
  padding: 24px;
  max-width: 1200px;
  margin: 0 auto;
}

.header-section {
  display: flex;
  flex-direction: column;
  gap: 20px;
  margin-bottom: 24px;
}

h2 {
  color: #1a365d;
  font-size: 24px;
  font-weight: 600;
  margin: 0;
}

.search-container {
  display: flex;
  gap: 16px;
  align-items: center;
}

.search-wrapper {
  position: relative;
  flex-grow: 1;
  max-width: 400px;
}

.search-box {
  width: 100%;
  padding: 10px 16px;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  font-size: 14px;
  transition: all 0.2s ease;
}

.search-box:focus {
  outline: none;
  border-color: #3182ce;
  box-shadow: 0 0 0 2px rgba(49, 130, 206, 0.2);
}

.clear-search-btn {
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  cursor: pointer;
  color: #a0aec0;
}

.clear-search-btn:hover {
  color: #718096;
}

.add-acupoint-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 16px;
  background-color: #3182ce;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.add-acupoint-btn:hover {
  background-color: #2c5282;
}

.search-status {
  font-size: 14px;
  color: #4a5568;
  margin-top: 8px;
}

.text-link {
  background: none;
  border: none;
  color: #3182ce;
  text-decoration: underline;
  cursor: pointer;
  font-size: 14px;
}

.table-container {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.acupoint-table {
  width: 100%;
  border-collapse: collapse;
}

.acupoint-table th {
  background-color: #f7fafc;
  padding: 12px 16px;
  text-align: left;
  font-size: 14px;
  font-weight: 600;
  color: #4a5568;
  border-bottom: 1px solid #e2e8f0;
}

.acupoint-table td {
  padding: 12px 16px;
  font-size: 14px;
  color: #2d3748;
  border-bottom: 1px solid #edf2f7;
}

.acupoint-table tr:last-child td {
  border-bottom: none;
}

.acupoint-name {
  font-weight: 500;
}

.meridian-path {
  color: #4a5568;
}

.coordinates {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.coordinates span {
  font-family: 'Roboto Mono', monospace;
  font-size: 13px;
  color: #4a5568;
}

.action-buttons {
  display: flex;
  gap: 8px;
}

.action-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.action-btn svg {
  width: 14px;
  height: 14px;
}

.edit {
  background-color: #f6e05e;
  color: #975a16;
}

.edit:hover {
  background-color: #ecc94b;
}

.delete {
  background-color: #fc8181;
  color: #9b2c2c;
}

.delete:hover {
  background-color: #f56565;
}

.view-3d {
  background-color: #90cdf4;
  color: #2c5282;
}

.view-3d:hover {
  background-color: #63b3ed;
}

.no-results {
  text-align: center;
  padding: 24px;
  color: #718096;
}

.pagination-container {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 8px;
  margin-top: 24px;
}

.pagination-nav {
  padding: 8px 12px;
  border: 1px solid #e2e8f0;
  background-color: white;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.pagination-nav:hover:not(:disabled) {
  background-color: #f7fafc;
}

.pagination-nav:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.page-numbers {
  display: flex;
  gap: 4px;
}

.page-btn {
  padding: 8px 12px;
  border: 1px solid #e2e8f0;
  background-color: white;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.page-btn:hover {
  background-color: #f7fafc;
}

.page-btn.active {
  background-color: #3182ce;
  color: white;
  border-color: #3182ce;
}

.modal-overlay {
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

.modal-content {
  background-color: white;
  border-radius: 8px;
  width: 90%;
  max-width: 800px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 24px;
  border-bottom: 1px solid #edf2f7;
}

.modal-header h3 {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
  color: #1a365d;
}

.close-modal-btn {
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #a0aec0;
}

.close-modal-btn:hover {
  color: #718096;
}

.form-grid {
  padding: 24px;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-group label {
  font-size: 14px;
  font-weight: 500;
  color: #4a5568;
}

.form-input {
  padding: 10px 12px;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  font-size: 14px;
  transition: all 0.2s ease;
}

.form-input:focus {
  outline: none;
  border-color: #3182ce;
  box-shadow: 0 0 0 2px rgba(49, 130, 206, 0.2);
}

.position-section,
.rotation-section,
.scale-section {
  grid-column: span 2;
  padding: 16px;
  background-color: #f7fafc;
  border-radius: 6px;
}

.position-section h4,
.rotation-section h4,
.scale-section h4 {
  margin: 0 0 12px 0;
  font-size: 15px;
  font-weight: 500;
  color: #4a5568;
}

.coord-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 12px;
}

.coord-input {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.coord-input label {
  font-size: 13px;
  color: #718096;
}

.coord-input input {
  padding: 8px 12px;
  border: 1px solid #e2e8f0;
  border-radius: 4px;
  font-family: 'Roboto Mono', monospace;
  font-size: 13px;
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  padding: 16px 24px;
  border-top: 1px solid #edf2f7;
}

.btn {
  padding: 10px 16px;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.cancel-btn {
  background-color: #f7fafc;
  border: 1px solid #e2e8f0;
  color: #4a5568;
}

.cancel-btn:hover {
  background-color: #edf2f7;
}

.save-btn {
  background-color: #3182ce;
  border: none;
  color: white;
}

.save-btn:hover {
  background-color: #2c5282;
}

.save-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.error-message {
  margin-top: 16px;
  padding: 12px;
  background-color: #fff5f5;
  border: 1px solid #fed7d7;
  border-radius: 4px;
  color: #e53e3e;
  font-size: 14px;
}

@media (max-width: 768px) {
  .form-grid {
    grid-template-columns: 1fr;
  }

  .coord-grid {
    grid-template-columns: 1fr;
  }

  .search-container {
    flex-direction: column;
    align-items: flex-start;
  }

  .add-acupoint-btn {
    width: 100%;
    justify-content: center;
  }
}
</style>
