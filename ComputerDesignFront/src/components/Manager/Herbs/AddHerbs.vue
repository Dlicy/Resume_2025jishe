<template>
  <div class="drug-form-container">
    <div class="drug-form-grid">
      <!-- 第一列 - 基本信息 -->
      <div class="form-column">
        <div class="form-section">
          <h3 class="section-title">基本信息</h3>
          <div class="form-group">
            <label for="drug-categories">药物大类</label>
            <input
              v-model="newDrug.drugCategories"
              id="drug-categories"
              type="text"
              class="form-input"
            />
          </div>

          <div class="form-group">
            <label for="drug-category">药物小类</label>
            <input
              v-model="newDrug.drugCategory"
              id="drug-category"
              type="text"
              class="form-input"
            />
          </div>

          <div class="form-group">
            <label for="main-name">药物名称</label>
            <input v-model="newDrug.mainName" id="main-name" type="text" class="form-input" />
          </div>

          <div class="form-group">
            <label for="sub-name">药物别称</label>
            <input v-model="newDrug.subName" id="sub-name" type="text" class="form-input" />
          </div>
        </div>

        <!-- 药物特性 -->
        <div class="form-section">
          <h3 class="section-title">药物特性</h3>
          <div class="form-group">
            <label for="nature-flavor">药物性味</label>
            <input
              v-model="newDrug.natureAndFlavor"
              id="nature-flavor"
              type="text"
              class="form-input"
            />
          </div>

          <div class="form-group">
            <label for="meridians">药物归经</label>
            <input v-model="newDrug.meridians" id="meridians" type="text" class="form-input" />
          </div>

          <div class="form-group">
            <label for="processing">加工方法</label>
            <textarea v-model="newDrug.processing" id="processing" class="form-textarea"></textarea>
          </div>
        </div>
      </div>

      <!-- 第二列 - 临床应用 -->
      <div class="form-column">
        <div class="form-section">
          <h3 class="section-title">临床应用</h3>
          <div class="form-group">
            <label for="efficacy">药物功效</label>
            <textarea v-model="newDrug.efficacy" id="efficacy" class="form-textarea"></textarea>
          </div>

          <div class="form-group">
            <label for="indications">适应症</label>
            <textarea
              v-model="newDrug.indications"
              id="indications"
              class="form-textarea"
            ></textarea>
          </div>

          <div class="form-group">
            <label for="usage">用法用量</label>
            <textarea v-model="newDrug.usageAndDosage" id="usage" class="form-textarea"></textarea>
          </div>

          <div class="form-group">
            <label for="contraindications">禁忌</label>
            <textarea
              v-model="newDrug.contraindications"
              id="contraindications"
              class="form-textarea"
            ></textarea>
          </div>
        </div>
      </div>
    </div>

    <!-- 补充信息 - 全宽度 -->
    <div class="form-section full-width">
      <h3 class="section-title">补充信息</h3>
      <div class="supplemental-grid">
        <div class="form-group">
          <label for="source">药物来源</label>
          <textarea v-model="newDrug.source" id="source" class="form-textarea"></textarea>
        </div>

        <div class="form-group">
          <label for="characters">性状特征</label>
          <textarea v-model="newDrug.characters" id="characters" class="form-textarea"></textarea>
        </div>

        <div class="form-group">
          <label for="formulas">方剂</label>
          <textarea v-model="newDrug.formulas" id="formulas" class="form-textarea"></textarea>
        </div>
      </div>
    </div>

    <!-- 图片上传 -->
    <div class="form-section full-width">
      <h3 class="section-title">药物图片</h3>
      <div class="file-upload-card">
        <label for="drug-image" class="file-upload-label">
          <span class="upload-icon">+</span>
          <span class="upload-text">点击上传药物图片</span>
          <span class="file-requirements">支持 JPG/PNG 格式，最大5MB</span>
          <input
            type="file"
            id="drug-image"
            accept="image/*"
            @change="handleImageUpload"
            class="hidden-file-input"
          />
        </label>
        <div v-if="drugImage" class="file-preview">
          已选择: {{ drugImage.name }}
          <button @click="clearImage" class="clear-button">×</button>
        </div>
      </div>
    </div>

    <!-- 提交按钮 -->
    <div class="form-actions">
      <button class="submit-button" @click="submitForm" :disabled="isLoading">
        {{ isLoading ? '提交中...' : '提交药物信息' }}
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'

// 初始化药物数据
const newDrug = ref({
  drugCategories: '',
  drugCategory: '',
  mainName: '',
  subName: '',
  natureAndFlavor: '',
  processing: '',
  meridians: '',
  efficacy: '',
  indications: '',
  usageAndDosage: '',
  contraindications: '',
  source: '',
  characters: '',
  formulas: '',
})

const drugImage = ref(null)
const isLoading = ref(false)
const errorMessage = ref('')

// 创建axios实例
const api = axios.create({
  baseURL: 'http://localhost:8105/Encyclopedia',
  timeout: 10000,
})

// 图片上传处理
const handleImageUpload = (event) => {
  const file = event.target.files[0]
  if (!file) return

  // 验证图片
  const validTypes = ['image/jpeg', 'image/png']
  const maxSize = 5 * 1024 * 1024 // 5MB

  if (!validTypes.includes(file.type)) {
    errorMessage.value = '请上传 JPG 或 PNG 格式的图片'
    return
  }

  if (file.size > maxSize) {
    errorMessage.value = '图片大小不能超过 5MB'
    return
  }

  drugImage.value = file
  errorMessage.value = ''
}

// 上传图片到服务器
const uploadImage = async (file) => {
  const formData = new FormData()
  formData.append('image', file)

  return axios.post('/Encyclopedia/upload', formData, {
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  })
}

// 提交药物信息
const createHerb = (herbData) => {
  console.log(herbData)
  return axios.post('/Encyclopedia/herbs', herbData)
}

// 表单提交
const submitForm = async () => {
  if (isLoading.value) return

  // 基础验证
  if (!newDrug.value.mainName) {
    errorMessage.value = '药物名称不能为空'
    return
  }

  isLoading.value = true
  errorMessage.value = ''

  try {
    // 1. 上传图片（如果有）
    let imageUrl = null
    if (drugImage.value) {
      const uploadRes = await uploadImage(drugImage.value)
      console.log('照片存储路径', uploadRes)
      console.log(uploadRes)
      imageUrl = uploadRes.data.data // 这里改为直接赋值
      console.log('上传后返回的 imageUrl:', imageUrl)
      console.log(imageUrl)
      // newDrug.value.imageUrl = uploadRes.data.data.imageUrl
    }

    // 2. 提交药物数据
    const herbData = {
      ...newDrug.value,
      imageUrl: imageUrl,
    }

    console.log('要发送到后端的 herbData:', herbData)

    await createHerb(herbData)

    alert('药物信息添加成功！')
    resetForm()
  } catch (error) {
    console.error('提交失败:', error)
    errorMessage.value = error.response?.data?.message || error.message || '提交失败'
  } finally {
    isLoading.value = false
  }
}

// 重置表单
const resetForm = () => {
  Object.keys(newDrug.value).forEach((key) => {
    newDrug.value[key] = ''
  })
  drugImage.value = null
  document.getElementById('drug-image').value = ''
}
</script>
<style scoped>
.drug-form-container {
  /* max-width: 1200px; */
  margin: 0 auto;
  padding: 24px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.drug-form-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 32px;
  margin-bottom: 24px;
}

.form-column {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.form-section {
  background: #f8fafc;
  padding: 20px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
}

.section-title {
  font-size: 16px;
  color: #2d3748;
  margin-top: 0;
  margin-bottom: 16px;
  padding-bottom: 8px;
  border-bottom: 1px solid #e2e8f0;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 16px;
}

.form-group:last-child {
  margin-bottom: 0;
}

.form-group label {
  font-size: 14px;
  color: #4a5568;
  font-weight: 500;
}

.form-input {
  padding: 10px 12px;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  font-size: 14px;
  transition: all 0.2s ease;
  background-color: #fff;
  width: 100%;
  box-sizing: border-box;
}

.form-textarea {
  padding: 10px 12px;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  font-size: 14px;
  transition: all 0.2s ease;
  background-color: #fff;
  width: 100%;
  min-height: 100px;
  resize: vertical;
  font-family: inherit;
  line-height: 1.5;
  box-sizing: border-box;
}

.form-input:focus,
.form-textarea:focus {
  outline: none;
  border-color: #4299e1;
  box-shadow: 0 0 0 2px rgba(66, 153, 225, 0.2);
}

.full-width {
  grid-column: 1 / -1;
}

.supplemental-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}

/* 文件上传区域样式 */
.file-upload-card {
  border: 2px dashed #cbd5e0;
  border-radius: 8px;
  padding: 20px;
  text-align: center;
  transition: all 0.2s ease;
  background-color: #f8fafc;
  position: relative;
}

.file-upload-card:hover {
  border-color: #4299e1;
  background-color: rgba(66, 153, 225, 0.05);
}

.file-upload-label {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.hidden-file-input {
  position: absolute;
  width: 0.1px;
  height: 0.1px;
  opacity: 0;
  overflow: hidden;
  z-index: -1;
}

.upload-icon {
  font-size: 28px;
  color: #4299e1;
  margin-bottom: 8px;
}

.upload-text {
  font-size: 15px;
  color: #2d3748;
  font-weight: 500;
  margin-bottom: 4px;
}

.file-requirements {
  font-size: 12px;
  color: #718096;
}

.file-preview {
  margin-top: 12px;
  padding: 10px;
  background-color: #edf2f7;
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.clear-button {
  background: none;
  border: none;
  color: #e53e3e;
  font-size: 16px;
  cursor: pointer;
  padding: 0 6px;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 24px;
}

.submit-button {
  padding: 12px 24px;
  background-color: #4299e1;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 15px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.submit-button:hover {
  background-color: #3182ce;
}

/* 响应式设计 */
@media (max-width: 900px) {
  .drug-form-grid {
    grid-template-columns: 1fr;
  }

  .supplemental-grid {
    grid-template-columns: 1fr;
  }
}
</style>
