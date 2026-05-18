<template>
  <div class="formula-form-container">
    <div class="formula-form-grid">
      <!-- 第一列 - 基础信息 -->
      <div class="form-column">
        <div class="form-section">
          <h3 class="section-title">基础信息</h3>

          <div class="form-group">
            <label for="formula-name">方剂名称</label>
            <input
              v-model="formData.name"
              id="formula-name"
              type="text"
              class="form-input"
              placeholder="请输入方剂名称"
            />
          </div>

          <div class="form-row">
            <div class="form-group">
              <label for="main-category">所属大类</label>
              <select
                v-model="formData.mainCategory"
                id="main-category"
                class="form-input"
                @change="handleMainCategoryChange"
              >
                <option value="" disabled selected>请选择大类</option>
                <option v-for="item in mainCategories" :key="item.value" :value="item.value">
                  {{ item.label }}
                </option>
              </select>
            </div>

            <div class="form-group">
              <label for="sub-category">所属小类</label>
              <select
                v-model="formData.subCategory"
                id="sub-category"
                class="form-input"
                :disabled="!formData.mainCategory"
              >
                <option value="" disabled selected>请选择小类</option>
                <option v-for="item in subCategories" :key="item.value" :value="item.value">
                  {{ item.label }}
                </option>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label for="formula-source">方剂出处</label>
            <input
              v-model="formData.source"
              id="formula-source"
              type="text"
              class="form-input"
              placeholder="例如：《伤寒论》"
            />
          </div>

          <div class="form-group">
            <label for="formula-classification">方剂分类</label>
            <input
              v-model="formData.classification"
              id="formula-classification"
              type="text"
              class="form-input"
            />
          </div>
        </div>
      </div>

      <!-- 第二列 - 核心内容 -->
      <div class="form-column">
        <div class="form-section">
          <h3 class="section-title">核心内容</h3>

          <div class="form-group">
            <label for="formula-composition">组成药材及用量</label>
            <textarea
              v-model="formData.composition"
              id="formula-composition"
              class="form-textarea"
              placeholder="请输入药材及用量，例如：当归10g、川芎8g"
              rows="3"
            ></textarea>
          </div>

          <div class="form-group">
            <label for="formula-explanation">方剂解释</label>
            <textarea
              v-model="formData.explanation"
              id="formula-explanation"
              class="form-textarea"
              rows="3"
            ></textarea>
          </div>
        </div>
      </div>
    </div>

    <!-- 全宽度部分 - 功能主治 -->
    <div class="form-section full-width">
      <h3 class="section-title">功能主治</h3>
      <div class="supplemental-grid">
        <div class="form-group">
          <label for="formula-functions">方剂功用</label>
          <textarea
            v-model="formData.functions"
            id="formula-functions"
            class="form-textarea"
            rows="2"
          ></textarea>
        </div>

        <div class="form-group">
          <label for="formula-indications">主治</label>
          <textarea
            v-model="formData.indications"
            id="formula-indications"
            class="form-textarea"
            placeholder="例如：营血虚滞证。症见头晕目眩，心悸失眠..."
            rows="3"
          ></textarea>
        </div>

        <div class="form-group">
          <label for="formula-usage">用法</label>
          <textarea
            v-model="formData.usageMethod"
            id="formula-usage"
            class="form-textarea"
            placeholder="例如：水煎服，一日一剂，分两次服用"
            rows="2"
          ></textarea>
        </div>
      </div>
    </div>

    <!-- 注意事项 -->
    <div class="form-section full-width">
      <h3 class="section-title">注意事项</h3>
      <div class="form-group">
        <textarea
          v-model="formData.precautions"
          class="form-textarea"
          placeholder="例如：阴虚火旺者慎用，孕妇禁用"
          rows="3"
        ></textarea>
      </div>
    </div>

    <!-- 操作按钮 -->
    <div class="form-actions">
      <button class="submit-button" @click="submitForm">提交方剂</button>
      <button class="reset-button" @click="resetForm">重置表单</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { ElMessage } from 'element-plus'
import axios from 'axios'

// 表单数据类型
interface FormulaForm {
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

// 表单数据
const formData = reactive<FormulaForm>({
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

// 分类选项数据
const mainCategories = ref([
  { value: '补益剂', label: '补益剂' },
  { value: '解表剂', label: '解表剂' },
  { value: '清热剂', label: '清热剂' },
  { value: '祛湿剂', label: '祛湿剂' },
  { value: '理气剂', label: '理气剂' },
])

const subCategories = ref<{ value: string; label: string }[]>([])

// 大类变化时加载对应小类 - 修复后的完整实现
const handleMainCategoryChange = (event: Event) => {
  const target = event.target as HTMLSelectElement
  const value = target.value
  formData.subCategory = '' // 清空之前选的小类

  // 根据大类动态加载小类
  const subCategoryMap: Record<string, Array<{ value: string; label: string }>> = {
    补益剂: [
      { value: '补气剂', label: '补气剂' },
      { value: '补血剂', label: '补血剂' },
      { value: '补阴剂', label: '补阴剂' },
      { value: '补阳剂', label: '补阳剂' },
    ],
    解表剂: [
      { value: '辛温解表剂', label: '辛温解表剂' },
      { value: '辛凉解表剂', label: '辛凉解表剂' },
    ],
    清热剂: [
      { value: '清气分热剂', label: '清气分热剂' },
      { value: '清热解毒剂', label: '清热解毒剂' },
      { value: '清脏腑热剂', label: '清脏腑热剂' },
    ],
    祛湿剂: [
      { value: '燥湿和胃剂', label: '燥湿和胃剂' },
      { value: '清热祛湿剂', label: '清热祛湿剂' },
      { value: '利水渗湿剂', label: '利水渗湿剂' },
    ],
    理气剂: [
      { value: '行气剂', label: '行气剂' },
      { value: '降气剂', label: '降气剂' },
    ],
  }

  subCategories.value = subCategoryMap[value] || []
}

// 提交表单
const submitForm = async () => {
  try {
    // 基本验证
    if (!formData.name) {
      ElMessage.error('请输入方剂名称')
      return
    }
    if (!formData.mainCategory) {
      ElMessage.error('请选择所属大类')
      return
    }
    if (!formData.composition) {
      ElMessage.error('请输入组成药材')
      return
    }
    if (!formData.functions) {
      ElMessage.error('请输入方剂功用')
      return
    }

    // 发送请求
    const response = await axios.post('/encyclopedia/formulas/addFormula', formData)

    if (response.data.success) {
      ElMessage.success('添加成功！')
      resetForm()
    } else {
      ElMessage.error(response.data.errorMessage || '添加失败')
    }
  } catch (error) {
    ElMessage.error('提交出错，请检查表单')
    console.error('提交出错:', error)
  }
}

// 重置表单
const resetForm = () => {
  Object.keys(formData).forEach((key) => {
    formData[key] = ''
  })
  subCategories.value = []
}
</script>

<style scoped>
.formula-form-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 24px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.formula-form-grid {
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

.form-row {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 16px;
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

.reset-button {
  padding: 12px 24px;
  background-color: #fff;
  color: #4a5568;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  font-size: 15px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.reset-button:hover {
  background-color: #f8fafc;
  border-color: #cbd5e0;
}

/* 响应式设计 */
@media (max-width: 900px) {
  .formula-form-grid {
    grid-template-columns: 1fr;
  }

  .supplemental-grid {
    grid-template-columns: 1fr;
  }

  .form-row {
    grid-template-columns: 1fr;
  }
}
</style>
