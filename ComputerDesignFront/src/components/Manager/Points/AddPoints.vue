<template>
  <div class="acupoint-management">
    <h2>穴位管理</h2>
    <div class="acupoint-form">
      <div class="form-grid">
        <!-- 基础信息 -->
        <div class="form-group">
          <label for="model-name">穴位名称</label>
          <input
            id="model-name"
            v-model="acupointData.modelName"
            type="text"
            placeholder="如：璇玑"
            required
            class="form-input"
          />
        </div>

        <div class="form-group">
          <label for="meridian-path">经络路径</label>
          <input
            id="meridian-path"
            v-model="acupointData.path"
            type="text"
            placeholder="如：人体/任脉/璇玑"
            required
            class="form-input"
          />
        </div>

        <!-- 位置信息 -->
        <div class="position-section">
          <h3>空间位置</h3>
          <div class="position-grid">
            <!-- 世界坐标 -->
            <div class="position-group">
              <h4>世界坐标</h4>
              <div class="coord-input">
                <label>X</label>
                <input v-model.number="acupointData.positionX" type="number" step="0.000001" />
              </div>
              <div class="coord-input">
                <label>Y</label>
                <input v-model.number="acupointData.positionY" type="number" step="0.000001" />
              </div>
              <div class="coord-input">
                <label>Z</label>
                <input v-model.number="acupointData.positionZ" type="number" step="0.000001" />
              </div>
            </div>

            <!-- 局部坐标 -->
            <div class="position-group">
              <h4>局部坐标</h4>
              <div class="coord-input">
                <label>X</label>
                <input v-model.number="acupointData.localPositionX" type="number" step="0.000001" />
              </div>
              <div class="coord-input">
                <label>Y</label>
                <input v-model.number="acupointData.localPositionY" type="number" step="0.000001" />
              </div>
              <div class="coord-input">
                <label>Z</label>
                <input v-model.number="acupointData.localPositionZ" type="number" step="0.000001" />
              </div>
            </div>
          </div>
        </div>

        <!-- 旋转信息 -->
        <div class="rotation-section">
          <h3>旋转参数</h3>
          <div class="rotation-grid">
            <!-- 世界旋转 -->
            <div class="rotation-group">
              <h4>世界旋转</h4>
              <div class="coord-input">
                <label>X</label>
                <input v-model.number="acupointData.rotationX" type="number" step="0.000001" />
              </div>
              <div class="coord-input">
                <label>Y</label>
                <input v-model.number="acupointData.rotationY" type="number" step="0.000001" />
              </div>
              <div class="coord-input">
                <label>Z</label>
                <input v-model.number="acupointData.rotationZ" type="number" step="0.000001" />
              </div>
              <div class="coord-input">
                <label>W</label>
                <input v-model.number="acupointData.rotationW" type="number" step="0.000001" />
              </div>
            </div>

            <!-- 局部旋转 -->
            <div class="rotation-group">
              <h4>局部旋转</h4>
              <div class="coord-input">
                <label>X</label>
                <input v-model.number="acupointData.localRotationX" type="number" step="0.000001" />
              </div>
              <div class="coord-input">
                <label>Y</label>
                <input v-model.number="acupointData.localRotationY" type="number" step="0.000001" />
              </div>
              <div class="coord-input">
                <label>Z</label>
                <input v-model.number="acupointData.localRotationZ" type="number" step="0.000001" />
              </div>
              <div class="coord-input">
                <label>W</label>
                <input v-model.number="acupointData.localRotationW" type="number" step="0.000001" />
              </div>
            </div>
          </div>
        </div>

        <!-- 缩放信息 -->
        <div class="scale-section">
          <h3>缩放比例</h3>
          <div class="scale-grid">
            <div class="coord-input">
              <label>X</label>
              <input v-model.number="acupointData.scaleX" type="number" step="0.000001" />
            </div>
            <div class="coord-input">
              <label>Y</label>
              <input v-model.number="acupointData.scaleY" type="number" step="0.000001" />
            </div>
            <div class="coord-input">
              <label>Z</label>
              <input v-model.number="acupointData.scaleZ" type="number" step="0.000001" />
            </div>
          </div>
        </div>
      </div>

      <!-- 提交按钮 -->
      <div class="button-container">
        <button type="button" class="submit-button" @click="submitAcupoint">
          <span>保存穴位数据</span>
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
            <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path>
            <polyline points="17 21 17 13 7 13 7 21"></polyline>
            <polyline points="7 3 7 8 15 8"></polyline>
          </svg>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, watch, reactive } from 'vue'
import axios from 'axios'

interface Acupoint {
  id?: number
  modelName: string
  path: string
  positionX: number
  positionY: number
  positionZ: number
  localPositionX: number
  localPositionY: number
  localPositionZ: number
  rotationX: number
  rotationY: number
  rotationZ: number
  rotationW: number
  localRotationX: number
  localRotationY: number
  localRotationZ: number
  localRotationW: number
  scaleX: number
  scaleY: number
  scaleZ: number
}

// Reactive data
const acupoints = ref<Acupoint[]>([])
const acupointData = reactive({
  modelName: '',
  path: '',
  positionX: 0,
  positionY: 0,
  positionZ: 0,
  localPositionX: 0,
  localPositionY: 0,
  localPositionZ: 0,
  rotationX: 0,
  rotationY: 0,
  rotationZ: 0,
  rotationW: 1,
  localRotationX: 0,
  localRotationY: 0,
  localRotationZ: 0,
  localRotationW: 1,
  scaleX: 1,
  scaleY: 1,
  scaleZ: 1,
})
const searchQuery = ref('')
const currentPage = ref(1)
const itemsPerPage = 10
const isLoading = ref(false)
const errorMessage = ref('')
const isEditModalOpen = ref(false)
const currentEditAcupoint = ref<Acupoint | null>(null)

// API configuration
const API_BASE = import.meta.env.VITE_API_URL
const API_ENDPOINTS = {
  // GET_ACUPOINTS: `/api/unity/points`,
  ADD_ACUPOINT: `/api/unity/points`,
  UPDATE_ACUPOINT: (id: number) => `/api/acupoints/${id}`,
  DELETE_ACUPOINT: (id: number) => `/api/acupoints/${id}`,
}

// 提交穴位数据
const submitAcupoint = async () => {
  if (!validateForm()) return

  isLoading.value = true
  errorMessage.value = ''

  try {
    // 构造符合后端接口的请求数据
    const requestData = {
      modelName: acupointData.modelName,
      path: acupointData.path,
      positionX: Number(acupointData.positionX),
      positionY: Number(acupointData.positionY),
      positionZ: Number(acupointData.positionZ),
      localPositionX: Number(acupointData.localPositionX),
      localPositionY: Number(acupointData.localPositionY),
      localPositionZ: Number(acupointData.localPositionZ),
      rotationX: Number(acupointData.rotationX),
      rotationY: Number(acupointData.rotationY),
      rotationZ: Number(acupointData.rotationZ),
      rotationW: Number(acupointData.rotationW),
      localRotationX: Number(acupointData.localRotationX),
      localRotationY: Number(acupointData.localRotationY),
      localRotationZ: Number(acupointData.localRotationZ),
      localRotationW: Number(acupointData.localRotationW),
      scaleX: Number(acupointData.scaleX),
      scaleY: Number(acupointData.scaleY),
      scaleZ: Number(acupointData.scaleZ),
    }

    const response = await axios.post(API_ENDPOINTS.ADD_ACUPOINT, requestData)

    if (!response.data?.success) {
      throw new Error(response.data?.message || '请求失败')
    }

    alert('穴位添加成功！')
    resetForm()
  } catch (error) {
    if (axios.isAxiosError(error)) {
      errorMessage.value = error.response?.data?.message || '保存穴位失败'
    } else {
      errorMessage.value = error instanceof Error ? error.message : '保存穴位失败'
    }
    console.error('Error:', error)
  } finally {
    isLoading.value = false
  }
}

// 表单验证
const validateForm = (): boolean => {
  const requiredFields = [
    { field: acupointData.modelName, message: '请输入穴位名称' },
    { field: acupointData.path, message: '请输入经络路径' },
  ]

  for (const { field, message } of requiredFields) {
    if (!field?.toString().trim()) {
      errorMessage.value = message
      return false
    }
  }

  // 验证数值范围
  const scaleValues = [acupointData.scaleX, acupointData.scaleY, acupointData.scaleZ]
  if (scaleValues.some((v) => v <= 0)) {
    errorMessage.value = '缩放比例必须大于0'
    return false
  }

  return true
}

// 重置表单
const resetForm = () => {
  Object.assign(acupointData, {
    modelName: '',
    path: '',
    positionX: 0,
    positionY: 0,
    positionZ: 0,
    localPositionX: 0,
    localPositionY: 0,
    localPositionZ: 0,
    rotationX: 0,
    rotationY: 0,
    rotationZ: 0,
    rotationW: 1,
    localRotationX: 0,
    localRotationY: 0,
    localRotationZ: 0,
    localRotationW: 1,
    scaleX: 1,
    scaleY: 1,
    scaleZ: 1,
  })
  errorMessage.value = ''
}

// 其他方法保持不变...
const updateAcupoint = async () => {
  if (!currentEditAcupoint.value?.id) return

  isLoading.value = true
  errorMessage.value = ''

  try {
    const response = await axios.put(
      API_ENDPOINTS.UPDATE_ACUPOINT(currentEditAcupoint.value.id),
      currentEditAcupoint.value,
    )

    if (!response.data?.success) {
      throw new Error(response.data?.message || '更新穴位失败')
    }

    // await fetchAcupoints()
    // closeEditModal()
  } catch (error) {
    if (axios.isAxiosError(error)) {
      errorMessage.value = error.response?.data?.message || '更新穴位失败'
    } else {
      errorMessage.value = error instanceof Error ? error.message : '更新穴位失败'
    }
    console.error('Error updating acupoint:', error)
  } finally {
    isLoading.value = false
  }
}

const deleteAcupoint = async (id: number) => {
  if (!confirm('确定要删除这个穴位吗？')) return

  isLoading.value = true
  errorMessage.value = ''

  try {
    const response = await axios.delete(API_ENDPOINTS.DELETE_ACUPOINT(id))

    if (!response.data?.success) {
      throw new Error(response.data?.message || '删除穴位失败')
    }

    // await fetchAcupoints()
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

// 分页和搜索功能保持不变...
const paginatedAcupoints = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage
  const end = start + itemsPerPage
  return filteredAcupoints.value.slice(start, end)
})

const filteredAcupoints = computed(() => {
  if (!searchQuery.value) return acupoints.value
  const query = searchQuery.value.toLowerCase()
  return acupoints.value.filter(
    (ap) => ap.modelName.toLowerCase().includes(query) || ap.path.toLowerCase().includes(query),
  )
})

const totalPages = computed(() => Math.ceil(filteredAcupoints.value.length / itemsPerPage))

watch(searchQuery, () => {
  currentPage.value = 1
})

onMounted(() => {
  // fetchAcupoints()
})
</script>

<style scoped>
/* 基础样式 */
.acupoint-management {
  font-family:
    'Inter',
    -apple-system,
    BlinkMacSystemFont,
    sans-serif;
  color: #2d3748;
  font-size: 1.05rem;
  padding: 2rem;
}

h2 {
  color: #1a365d;
  margin-bottom: 2rem;
  font-weight: 700;
  font-size: 2rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #e2e8f0;
  position: relative;
}

h2::after {
  content: '';
  position: absolute;
  left: 0;
  bottom: -1px;
  width: 80px;
  height: 3px;
  background: #4299e1;
}

h3 {
  color: #2b6cb0;
  font-size: 1.5rem;
  margin: 1.5rem 0 1rem;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid #ebf8ff;
}

h4 {
  color: #4a5568;
  font-size: 1.1rem;
  margin-bottom: 1rem;
}

/* 表单容器 */
.acupoint-form {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2.5rem;
  background: white;
  border-radius: 12px;
  box-shadow:
    0 4px 6px -1px rgba(0, 0, 0, 0.05),
    0 2px 4px -1px rgba(0, 0, 0, 0.03);
}

/* 表单网格布局 */
.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
  gap: 2rem;
}

/* 基础表单组样式 */
.form-group {
  margin-bottom: 0;
  padding: 1.25rem;
  background: #f8fafc;
  border-radius: 8px;
  transition: all 0.25s ease;
}

.form-group:hover {
  background: #f0f5ff;
}

.form-group label {
  display: block;
  margin-bottom: 0.75rem;
  font-weight: 500;
  color: #4a5568;
  font-size: 1.05rem;
}

/* 坐标输入组 */
.position-section,
.rotation-section,
.scale-section {
  grid-column: 1 / -1;
  margin-top: 1.5rem;
  padding: 1.5rem;
  background: #f8fafc;
  border-radius: 12px;
  box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.02);
}

.position-grid,
.rotation-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 1.5rem;
  margin-top: 1rem;
}

.scale-grid {
  display: flex;
  gap: 1.5rem;
  margin-top: 1rem;
}

.coord-group {
  padding: 1.25rem;
  background: white;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.coord-input {
  display: flex;
  align-items: center;
  margin-bottom: 1rem;
}

.coord-input label {
  width: 40px;
  font-weight: 600;
  color: #4a5568;
  margin-right: 1rem;
}

/* 输入控件 */
.form-input,
.coord-input input {
  width: 100%;
  padding: 0.9rem 1rem;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  font-size: 1rem;
  background: white;
  transition: all 0.25s ease;
}

.coord-input input {
  flex: 1;
  padding: 0.8rem 1rem;
}

.form-input:hover,
.coord-input input:hover {
  border-color: #cbd5e0;
}

.form-input:focus,
.coord-input input:focus {
  border-color: #4299e1;
  box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
  outline: none;
}

/* 按钮容器 */
.button-container {
  grid-column: 1 / -1;
  display: flex;
  justify-content: flex-end;
  padding: 1.5rem;
  background: #f8fafc;
  border-radius: 8px;
  margin-top: 1.5rem;
}

/* 提交按钮 */
.submit-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 1rem 2.5rem;
  background-color: #4299e1;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 1.1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.25s ease;
  box-shadow: 0 2px 4px rgba(66, 153, 225, 0.2);
}

.submit-button:hover {
  background-color: #3182ce;
  transform: translateY(-1px);
  box-shadow: 0 4px 6px rgba(66, 153, 225, 0.25);
}

.submit-button svg {
  margin-left: 0.75rem;
  width: 18px;
  height: 18px;
  stroke-width: 2.5;
}

/* 响应式调整 */
@media (max-width: 1024px) {
  .acupoint-form {
    padding: 2rem;
  }

  .form-grid {
    grid-template-columns: 1fr;
  }

  .position-grid,
  .rotation-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .acupoint-management {
    padding: 1.5rem;
  }

  h2 {
    font-size: 1.75rem;
  }

  .coord-group {
    padding: 1rem;
  }

  .button-container {
    padding: 1.25rem;
  }
}

@media (max-width: 480px) {
  .acupoint-form {
    padding: 1.5rem;
  }

  .form-input,
  .coord-input input {
    padding: 0.8rem;
  }

  .submit-button {
    width: 100%;
    padding: 1rem;
  }

  .scale-grid {
    flex-direction: column;
    gap: 1rem;
  }
}
</style>
