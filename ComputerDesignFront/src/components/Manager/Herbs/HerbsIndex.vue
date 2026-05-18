<template>
  <div class="container">
    <div class="content">
      <h2>药物百科管理</h2>

      <div class="drug-form-container">
        <!-- 表单网格区域 -->
        <div class="drug-form-grid">
          <!-- 第一列 -->
          <div class="form-column">
            <div class="form-group">
              <label for="drug-categories">药物大类</label>
              <input
                v-model="newDrug.drugCategories"
                id="drug-categories"
                type="text"
                class="form-input"
                required
              />
            </div>

            <div class="form-group">
              <label for="main-name">药物名称</label>
              <input
                v-model="newDrug.mainName"
                id="main-name"
                type="text"
                class="form-input"
                required
              />
            </div>

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
              <label for="efficacy">药物功效</label>
              <input v-model="newDrug.efficacy" id="efficacy" type="text" class="form-input" />
            </div>

            <div class="form-group">
              <label for="indications">适应症</label>
              <input
                v-model="newDrug.indications"
                id="indications"
                type="text"
                class="form-input"
              />
            </div>
          </div>

          <!-- 第二列 -->
          <div class="form-column">
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
              <label for="sub-name">药物别称</label>
              <input v-model="newDrug.subName" id="sub-name" type="text" class="form-input" />
            </div>

            <div class="form-group">
              <label for="processing">加工方法</label>
              <input v-model="newDrug.processing" id="processing" type="text" class="form-input" />
            </div>

            <div class="form-group">
              <label for="meridians">药物归经</label>
              <input v-model="newDrug.meridians" id="meridians" type="text" class="form-input" />
            </div>

            <div class="form-group">
              <label for="usage">用法用量</label>
              <input v-model="newDrug.usageAndDosage" id="usage" type="text" class="form-input" />
            </div>
          </div>

          <!-- 第三列 -->
          <div class="form-column">
            <div class="form-group">
              <label for="source">药物来源</label>
              <input v-model="newDrug.source" id="source" type="text" class="form-input" />
            </div>

            <div class="form-group">
              <label for="characters">性状特征</label>
              <input v-model="newDrug.characters" id="characters" type="text" class="form-input" />
            </div>

            <div class="form-group">
              <label for="contraindications">禁忌</label>
              <input
                v-model="newDrug.contraindications"
                id="contraindications"
                type="text"
                class="form-input"
              />
            </div>

            <div class="form-group">
              <label for="formulas">方剂</label>
              <input v-model="newDrug.formulas" id="formulas" type="text" class="form-input" />
            </div>
          </div>
        </div>

        <!-- 文件上传区域 -->
        <div class="file-upload-section">
          <div class="file-upload-card">
            <label for="drug-image" class="file-upload-label">
              <span class="upload-icon">+</span>
              <span class="upload-text">点击上传药物图片</span>
              <span class="file-requirements">支持 JPG/PNG 格式，最大5MB</span>
              <input type="file" id="drug-image" accept="image/*" @change="handleImageUpload" />
            </label>
            <div v-if="drugImage" class="file-preview">
              已选择: {{ drugImage.name }}
              <button @click="clearImage" class="clear-button">×</button>
            </div>
          </div>
        </div>

        <!-- 提交按钮 -->
        <div class="form-actions">
          <button class="submit-button" @click="addDrug">
            <span>提交药物信息</span>
            <svg class="submit-icon" viewBox="0 0 24 24">
              <path d="M5 12h14M12 5l7 7-7 7"></path>
            </svg>
          </button>
        </div>
      </div>

      <div class="search-box">
        <input
          v-model="searchQuery"
          type="search"
          placeholder="搜索药物名称"
          @input="filterDrugs"
          style="margin-top: 20px"
        />
      </div>

      <table>
        <thead>
          <tr>
            <th>药物名称</th>
            <th>药物别称</th>
            <th>药物大类</th>
            <th>药物小类</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="drug in displayedDrugs" :key="drug.id">
            <td>{{ drug.mainName }}</td>
            <td>{{ drug.subName }}</td>
            <td>{{ drug.drugCategories }}</td>
            <td>{{ drug.drugCategory }}</td>
            <td>
              <button @click="viewDrugDetails(drug)" class="action-btn view">查看</button>
              <button @click="editDrug(drug)" class="action-btn edit">编辑</button>
              <button @click="deleteDrug(drug.id)" class="action-btn delete">删除</button>
            </td>
          </tr>
        </tbody>
      </table>

      <div class="pagination">
        <button @click="changePage(currentPage - 1)" :disabled="currentPage === 1">上一页</button>
        <span v-for="page in totalPages" :key="page">
          <button @click="changePage(page)" :class="{ active: currentPage === page }">
            {{ page }}
          </button>
        </span>
        <button @click="changePage(currentPage + 1)" :disabled="currentPage === totalPages">
          下一页
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

// Drug data structure
const newDrug = ref({
  drugCategories: '',
  mainName: '',
  natureAndFlavor: '',
  efficacy: '',
  indications: '',
  drugCategory: '',
  subName: '',
  processing: '',
  meridians: '',
  usageAndDosage: '',
  source: '',
  characters: '',
  contraindications: '',
  formulas: '',
})

// Example drugs data (夸克 examples)
const drugsList = ref([
  {
    id: 1,
    mainName: '人参',
    subName: '山参、园参',
    drugCategories: '补虚药',
    drugCategory: '补气药',
    natureAndFlavor: '甘、微苦，微温',
    efficacy: '大补元气，复脉固脱，补脾益肺，生津养血，安神益智',
    indications: '体虚欲脱，肢冷脉微，脾虚食少，肺虚喘咳，津伤口渴',
    processing: '秋季采挖，洗净，晒干或烘干',
    meridians: '归脾、肺、心、肾经',
    usageAndDosage: '3-9g，另煎兑服；也可研粉吞服，一次2g，一日2次',
    source: '五加科植物人参的干燥根',
    characters: '主根呈纺锤形或圆柱形，表面灰黄色，上部有疏浅断续的粗横纹',
    contraindications: '不宜与藜芦、五灵脂同用',
    formulas: '四君子汤、生脉散',
  },
  {
    id: 2,
    mainName: '黄芪',
    subName: '绵黄芪',
    drugCategories: '补虚药',
    drugCategory: '补气药',
    natureAndFlavor: '甘，微温',
    efficacy: '补气升阳，益卫固表，利水消肿，生津养血，行滞通痹',
    indications: '气虚乏力，食少便溏，中气下陷，表虚自汗，气虚水肿',
    processing: '春、秋二季采挖，除去须根和根头，晒干',
    meridians: '归肺、脾经',
    usageAndDosage: '9-30g',
    source: '豆科植物蒙古黄芪或膜荚黄芪的干燥根',
    characters: '圆柱形，表面淡棕黄色或淡棕褐色，质硬而韧',
    contraindications: '表实邪盛、气滞湿阻、食积停滞等实证者不宜',
    formulas: '补中益气汤、玉屏风散',
  },
])

// Table display drugs
const displayedDrugs = ref([])
const searchQuery = ref('')
const currentPage = ref(1)
const itemsPerPage = 5

// Image handling
const drugImage = ref(null)

const handleImageUpload = (event) => {
  const file = event.target.files[0]
  if (file) {
    const validTypes = ['image/jpeg', 'image/png']
    const maxSize = 5 * 1024 * 1024

    if (!validTypes.includes(file.type)) {
      alert('请上传 JPG 或 PNG 格式的图片')
      return
    }

    if (file.size > maxSize) {
      alert('图片大小不能超过 5MB')
      return
    }

    drugImage.value = file
  }
}

const clearImage = () => {
  drugImage.value = null
  document.getElementById('drug-image').value = ''
}

// Add new drug
const addDrug = () => {
  if (!newDrug.value.drugCategories || !newDrug.value.mainName) {
    alert('请填写药物大类和药物名称')
    return
  }

  // Create new drug object
  const newDrugEntry = {
    id: drugsList.value.length + 1,
    ...newDrug.value,
  }

  // Add to drugs list
  drugsList.value.unshift(newDrugEntry)

  // Reset form
  resetForm()

  // Update displayed drugs
  filterDrugs()

  alert('药物信息添加成功！')
}

// Reset form
const resetForm = () => {
  Object.keys(newDrug.value).forEach((key) => {
    newDrug.value[key] = ''
  })
  clearImage()
}

// Search and filter drugs
const filterDrugs = () => {
  let filtered = drugsList.value

  if (searchQuery.value) {
    const query = searchQuery.value.toLowerCase()
    filtered = filtered.filter(
      (drug) =>
        drug.mainName.toLowerCase().includes(query) ||
        (drug.subName && drug.subName.toLowerCase().includes(query)),
    )
  }

  // Pagination
  const start = (currentPage.value - 1) * itemsPerPage
  displayedDrugs.value = filtered.slice(start, start + itemsPerPage)

  // Update total pages
  totalPages.value = Math.ceil(filtered.length / itemsPerPage)
}

// Pagination
const totalPages = ref(1)

const changePage = (page) => {
  if (page > 0 && page <= totalPages.value) {
    currentPage.value = page
    filterDrugs()
  }
}

// Initialize
onMounted(() => {
  filterDrugs()
})
</script>

<style scoped>
body {
  margin: 0;
  font-family: Arial, sans-serif;
  background-color: #f0f0f0;
}

.container {
  display: flex;
  justify-content: flex-start; /* 左对齐以让.sidebar固定 */
  width: 100%; /* 容器宽度100% */
  height: 100vh; /* 使容器占据整个视口高度 */
}

.sidebar {
  background: linear-gradient(to bottom, #1a1a2e, rgb(34, 37, 38)); /* 暗黑蓝色渐变 */
  color: white;
  width: 20%; /* 修改为百分比宽度 */
  max-width: 150px; /* 设置最大宽度 */
  padding: 20px;
  box-shadow: 2px 0 5px rgba(0, 0, 0, 0.3);
  display: flex;
  flex-direction: column;
  align-items: center; /* 水平居中 */
}

.sidebar h2 {
  margin: 0;
  font-size: 24px;
  text-align: center; /* 标题居中 */
}

.sidebar ul {
  list-style-type: none; /* 去掉小圆点 */
  padding: 0;
  width: 100%; /* 使列表宽度占满导航栏 */
  text-align: center; /* 列表项居中 */
}

.sidebar li {
  margin: 10px 0; /* 列表项间距 */
  padding: 10px 0; /* 列表项内边距 */
  transition: background-color 0.5s; /* 背景颜色过渡效果 */
}

.sidebar li:hover {
  background-color: #d3d3d3; /* 鼠标悬停时的背景颜色（浅灰色） */
}

.content {
  flex-grow: 1; /* 右侧内容区域 */
  padding: 20px;
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  overflow-y: auto; /* 使内容可以滚动 */
}
table {
  width: 100%;
  border-collapse: collapse;
}
th,
td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}
th {
  background-color: #f7f7f7;
}
img {
  width: 40px;
  height: 40px;
  border-radius: 50%;
}
.edit-button {
  background-color: #1a1a2e; /* 与页面风格相适应的颜色 */
  color: white;
  border: none;
  padding: 5px 10px;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;
}
.edit-button:hover {
  background-color: #0f3460; /* 悬停时颜色变化 */
}
.search-box {
  margin-bottom: 20px; /* 搜索框与表格之间的间距 */
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
}
.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: center;
  flex-wrap: wrap; /* 允许换行 */
}
.page-button {
  background-color: #1a1a2e;
  color: white;
  border: none;
  padding: 8px 12px;
  margin: 0 5px;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;
}
.page-button:hover {
  background-color: #0f3460;
}
.page-button.active {
  background-color: #0f3460; /* 当前页的背景色 */
  color: white;
  font-weight: bold; /* 使当前页的文字加粗 */
}
.dots {
  margin: 0 5px;
}

.sidebar {
  background: linear-gradient(to bottom, #1a1a2e, rgb(34, 37, 38));
  color: white;
  width: 20%;
  max-width: 150px;
  padding: 20px;
  box-shadow: 2px 0 5px rgba(0, 0, 0, 0.3);
  display: flex;
  flex-direction: column;
  align-items: center;
}
.content {
  flex-grow: 1;
  padding: 20px;
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  overflow-y: auto;
}
.add-plugin-button {
  background-color: #1a1a2e;
  color: white;
  border: none;
  padding: 10px 15px;
  border-radius: 5px;
  margin-bottom: 20px;
  cursor: pointer;
  transition: background-color 0.3s;
}
.input-field {
  width: 90%;
  padding: 10px;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
}
.file-upload-info {
  font-size: 12px;
  color: gray;
  margin-bottom: 10px;
}
#submit-button-container {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}
.submit-button {
  background-color: #1a1a2e;
  color: white;
  border: none;
  padding: 12px 20px;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;
  width: 100%;
  max-width: 200px;
}
.submit-button:hover {
  background-color: #0f3460;
}
.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
}
.page-button,
.delete-button {
  background-color: #1a1a2e;
  color: white;
  border: none;
  padding: 8px 12px;
  margin: 0 5px;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;
}
.page-button:hover,
.delete-button:hover {
  background-color: #0f3460;
}
.page-button.active {
  background-color: #0f3460;
  color: white;
  font-weight: bold;
}
.delete-button {
  background-color: #ff4d4d;
}
.delete-button:hover {
  background-color: #cc0000;
}

input[type='text'],
input[type='file'],
input[type='number'],
input[type='search'] {
  width: calc(100% - 20px);
  padding: 10px;
  margin: 5px 0;
  border: 1px solid #ccc;
  border-radius: 5px;
}
.drug-form-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 24px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.drug-form-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
  margin-bottom: 32px;
}

.form-column {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-group label {
  font-size: 14px;
  color: #4a5568;
  font-weight: 500;
}

.form-input {
  padding: 12px 16px;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  font-size: 14px;
  transition: all 0.2s ease;
  background-color: #f8fafc;
}

.form-input:focus {
  outline: none;
  border-color: #4299e1;
  box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.2);
  background-color: #fff;
}

.file-upload-section {
  margin-bottom: 32px;
}

.file-upload-card {
  border: 2px dashed #cbd5e0;
  border-radius: 12px;
  padding: 24px;
  text-align: center;
  transition: all 0.2s ease;
  background-color: #f8fafc;
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

.upload-icon {
  font-size: 32px;
  color: #4299e1;
  margin-bottom: 8px;
}

.upload-text {
  font-size: 16px;
  color: #2d3748;
  font-weight: 500;
  margin-bottom: 4px;
}

.file-requirements {
  font-size: 12px;
  color: #718096;
}

.file-preview {
  margin-top: 16px;
  padding: 12px;
  background-color: #edf2f7;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.clear-button {
  background: none;
  border: none;
  color: #e53e3e;
  font-size: 18px;
  cursor: pointer;
  padding: 0 8px;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
}

.submit-button {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 14px 24px;
  background-color: #4299e1;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.submit-button:hover {
  background-color: #3182ce;
  transform: translateY(-1px);
}

.submit-button:active {
  transform: translateY(0);
}

.submit-icon {
  width: 20px;
  height: 20px;
  fill: none;
  stroke: currentColor;
  stroke-width: 2;
  stroke-linecap: round;
  stroke-linejoin: round;
}
</style>