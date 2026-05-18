<template>
  <div class="form-container">
    <div class="upload-form">
      <h2>上传视频</h2>
      <div class="form-grid">
        <!-- 视频文件上传 -->
        <div class="form-group file-upload-group">
          <label for="videoFile">视频文件</label>
          <div class="file-upload-wrapper">
            <label for="videoFile" class="file-upload-label">
              <span v-if="!file" class="file-placeholder">
                <svg class="upload-icon" viewBox="0 0 24 24">
                  <path
                    d="M13 5v6h5l-6 7-6-7h5V5h2zm-1-3c4.2 0 8 3.2 8 7s-3.8 7-8 7-8-3.2-8-7 3.8-7 8-7zm0-2C5.5 0 0 4.5 0 10s5.5 10 12 10 12-4.5 12-10S18.5 0 12 0z"
                  />
                </svg>
                <span>选择视频文件</span>
              </span>
              <span v-else class="file-name">{{ file.name }}</span>
              <input
                type="file"
                id="videoFile"
                @change="handleFileChange"
                accept="video/*"
                required
              />
            </label>
            <span class="file-hint">支持MP4, MOV等格式，最大500MB</span>
          </div>
        </div>

        <!-- 封面图片上传 -->
        <div class="form-group file-upload-group">
          <label for="coverImage">视频封面</label>
          <div class="file-upload-wrapper">
            <label for="coverImage" class="file-upload-label">
              <span v-if="!coverImage" class="file-placeholder">
                <svg class="upload-icon" viewBox="0 0 24 24">
                  <path
                    d="M5 3h14a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2zm7 4a3 3 0 1 0 0 6 3 3 0 0 0 0-6zm-7 9v1h14v-1c0-2-3.5-3-7-3s-7 1-7 3z"
                  />
                </svg>
                <span>选择封面图片</span>
              </span>
              <span v-else class="file-name">{{ coverImage.name }}</span>
              <input
                type="file"
                id="coverImage"
                @change="handleCoverImageChange"
                accept="image/*"
              />
            </label>
            <span class="file-hint">支持JPG, PNG格式，最大5MB</span>
          </div>
          <div v-if="coverImagePreview" class="cover-preview">
            <img :src="coverImagePreview" alt="封面预览" class="preview-image" />
          </div>
        </div>

        <!-- 文本输入 -->
        <div class="form-group">
          <label for="title">视频标题</label>
          <input
            id="title"
            v-model="form.title"
            type="text"
            placeholder="请输入视频标题"
            required
            class="form-input"
          />
        </div>

        <div class="form-group">
          <label for="description">视频描述</label>
          <textarea
            id="description"
            v-model="form.description"
            placeholder="请输入视频描述"
            class="form-input"
            rows="4"
          ></textarea>
        </div>

        <!-- 添加到课程 -->
        <div class="form-group checkbox-group">
          <label class="checkbox-label">
            <input type="checkbox" v-model="addToCourse" class="checkbox-input" />
            <span class="checkbox-custom"></span>
            <span class="checkbox-text">添加到课程</span>
          </label>
        </div>

        <!-- 课程选择 -->
        <div v-if="addToCourse" class="course-selection">
          <div class="form-group">
            <label for="course">选择课程</label>
            <select id="course" v-model="form.courseId" required class="form-input">
              <option value="">-- 请选择课程 --</option>
              <option v-for="course in courses" :value="course.id" :key="course.id">
                {{ course.title }}
              </option>
            </select>
          </div>

          <div class="form-group">
            <label for="order">课程顺序</label>
            <input id="order" v-model="form.order" type="number" min="0" class="form-input" />
          </div>
        </div>
      </div>

      <!-- 按钮容器 -->
      <div class="button-container">
        <button
          type="submit"
          class="submit-button"
          @click.prevent="submitForm"
          :disabled="uploading"
        >
          <span>{{ uploading ? '上传中...' : '上传视频' }}</span>
          <svg
            class="button-icon"
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

      <!-- 消息提示 -->
      <div v-if="message" class="message" :class="{ success: isSuccess, error: !isSuccess }">
        {{ message }}
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      form: {
        title: '',
        description: '',
        courseId: null,
        order: 0,
      },
      file: null,
      coverImage: null,
      coverImagePreview: null,
      addToCourse: false,
      courses: [],
      uploading: false,
      message: '',
      isSuccess: false,
    }
  },
  async created() {
    await this.fetchCourses()
  },
  methods: {
    handleCoverImageChange(event) {
      this.coverImage = event.target.files[0]
      if (this.coverImage) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.coverImagePreview = e.target.result
        }
        reader.readAsDataURL(this.coverImage)
      } else {
        this.coverImagePreview = null
      }
    },
    async fetchCourses() {
      try {
        const response = await axios.get('/api/courses', {
          params: {
            page: 0,
            size: 100,
          },
        })
        this.courses = response.data.content
      } catch (error) {
        console.error('获取课程列表失败:', error)
      }
    },
    handleFileChange(event) {
      this.file = event.target.files[0]
    },
    async submitForm() {
      if (!this.file) {
        this.showMessage('请选择视频文件', false)
        return
      }

      this.uploading = true

      const formData = new FormData()
      formData.append('file', this.file)
      formData.append('title', this.form.title)
      formData.append('description', this.form.description)
      formData.append('authorId', 0)
      if (this.coverImage) {
        formData.append('coverImage', this.coverImage)
      }

      if (this.addToCourse && this.form.courseId) {
        formData.append('courseId', this.form.courseId)
        formData.append('order', this.form.order)
      }

      try {
        const response = await axios.post('/api/videos', formData, {
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        })

        this.showMessage('视频上传成功', true)
        this.resetForm()
      } catch (error) {
        console.error('上传失败:', error)
        this.showMessage('视频上传失败: ' + (error.response?.data?.message || error.message), false)
      } finally {
        this.uploading = false
      }
    },
    showMessage(msg, success) {
      this.message = msg
      this.isSuccess = success
      setTimeout(() => {
        this.message = ''
      }, 5000)
    },
    resetForm() {
      this.form = {
        title: '',
        description: '',
        courseId: null,
        order: 0,
      }
      this.file = null
      this.coverImage = null
      this.coverImagePreview = null
      this.addToCourse = false
      const fileInputs = ['videoFile', 'coverImage']
      fileInputs.forEach((id) => {
        const input = document.getElementById(id)
        if (input) input.value = ''
      })
    },
  },
}
</script>

<style scoped>
/* 基础样式 */
.form-container {
  box-sizing: border-box;
  font-family:
    'Inter',
    -apple-system,
    BlinkMacSystemFont,
    'Segoe UI',
    Roboto,
    Oxygen,
    Ubuntu,
    Cantarell,
    sans-serif;
  color: #2d3748;
  font-size: 1rem;
  line-height: 1.6;
  padding: 2rem;
  background-color: #f8fafc;
  min-height: 100vh;
}

.upload-form {
  max-width: 900px;
  margin: 0 auto;
  padding: 2.5rem;
  background: white;
  border-radius: 16px;
  box-shadow:
    0 10px 25px -5px rgba(0, 0, 0, 0.05),
    0 5px 10px -5px rgba(0, 0, 0, 0.02);
}

.upload-form h2 {
  color: #1a365d;
  margin-bottom: 2rem;
  font-weight: 700;
  font-size: 1.75rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #e2e8f0;
  position: relative;
}

.upload-form h2::after {
  content: '';
  position: absolute;
  left: 0;
  bottom: -1px;
  width: 80px;
  height: 3px;
  background: #4299e1;
}

/* 表单网格布局 */
.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 1.75rem;
  margin-bottom: 2.5rem;
}

/* 表单组样式 */
.form-group {
  margin-bottom: 0;
  padding: 1.25rem;
  background: #ffffff;
  border-radius: 12px;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  border: 1px solid #edf2f7;
}

.form-group:hover {
  border-color: #e2e8f0;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
}

.form-group label {
  display: block;
  margin-bottom: 0.75rem;
  font-weight: 500;
  color: #4a5568;
  font-size: 0.95rem;
  letter-spacing: 0.02em;
}

/* 输入框样式 */
.form-input {
  width: 100%;
  padding: 0.75rem 1rem;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  font-size: 0.95rem;
  background: white;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  color: #4a5568;
}

.form-input::placeholder {
  color: #a0aec0;
}

.form-input:hover {
  border-color: #cbd5e0;
}

.form-input:focus {
  border-color: #4299e1;
  box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
  outline: none;
}

textarea.form-input {
  min-height: 100px;
  resize: vertical;
}

/* 文件上传组 */
.file-upload-group {
  grid-column: 1 / -1;
}

.file-upload-wrapper {
  margin-top: 0.5rem;
  position: relative;
}

.file-upload-label {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 1.5rem 1rem;
  background: #f8fafc;
  border: 2px dashed #e2e8f0;
  border-radius: 8px;
  text-align: center;
  cursor: pointer;
  transition: all 0.25s ease;
  min-height: 120px;
}

.file-upload-label:hover {
  background: #f0f5ff;
  border-color: #cbd5e0;
}

.file-upload-label input[type='file'] {
  display: none;
}

.file-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  color: #718096;
}

.upload-icon {
  width: 36px;
  height: 36px;
  margin-bottom: 0.75rem;
  fill: #cbd5e0;
  transition: fill 0.2s ease;
}

.file-upload-label:hover .upload-icon {
  fill: #a0aec0;
}

.file-name {
  display: block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-size: 0.95rem;
  color: #4a5568;
  padding: 0.5rem;
  background: #edf2f7;
  border-radius: 4px;
  width: 100%;
  text-align: center;
}

.file-hint {
  display: block;
  font-size: 0.85rem;
  color: #718096;
  margin-top: 0.75rem;
  text-align: center;
}

/* 封面预览 */
.cover-preview {
  margin-top: 1rem;
  text-align: center;
}

.preview-image {
  max-width: 200px;
  max-height: 150px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
}

/* 复选框样式 */
.checkbox-group {
  display: flex;
  align-items: center;
}

.checkbox-label {
  display: flex;
  align-items: center;
  cursor: pointer;
}

.checkbox-input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
  height: 0;
  width: 0;
}

.checkbox-custom {
  position: relative;
  display: inline-block;
  width: 18px;
  height: 18px;
  background: white;
  border: 1px solid #cbd5e0;
  border-radius: 4px;
  margin-right: 10px;
  transition: all 0.2s ease;
}

.checkbox-input:checked ~ .checkbox-custom {
  background-color: #4299e1;
  border-color: #4299e1;
}

.checkbox-input:checked ~ .checkbox-custom::after {
  content: '';
  position: absolute;
  left: 6px;
  top: 2px;
  width: 5px;
  height: 10px;
  border: solid white;
  border-width: 0 2px 2px 0;
  transform: rotate(45deg);
}

.checkbox-text {
  font-size: 0.95rem;
  color: #4a5568;
}

/* 课程选择 */
.course-selection {
  grid-column: 1 / -1;
  padding: 1.5rem;
  background: #f8fafc;
  border-radius: 12px;
  margin-top: -1rem;
}

/* 按钮容器 */
.button-container {
  display: flex;
  justify-content: flex-end;
  padding: 1.5rem 0 0;
}

/* 提交按钮 */
.submit-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.9rem 2rem;
  background-color: #4299e1;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  letter-spacing: 0.02em;
  box-shadow: 0 4px 6px rgba(66, 153, 225, 0.15);
  position: relative;
  overflow: hidden;
}

.submit-button:hover:not(:disabled) {
  background-color: #3182ce;
  transform: translateY(-2px);
  box-shadow: 0 6px 12px rgba(66, 153, 225, 0.2);
}

.submit-button:active:not(:disabled) {
  transform: translateY(0);
}

.submit-button:disabled {
  background-color: #cbd5e0;
  cursor: not-allowed;
}

.button-icon {
  margin-left: 0.75rem;
  width: 18px;
  height: 18px;
  stroke-width: 2.5;
  transition: transform 0.2s ease;
}

.submit-button:hover:not(:disabled) .button-icon {
  transform: scale(1.1);
}

/* 消息提示 */
.message {
  margin-top: 1.5rem;
  padding: 1rem;
  border-radius: 8px;
  font-size: 0.95rem;
  text-align: center;
}

.success {
  background-color: #dff0d8;
  color: #3c763d;
  border: 1px solid #d6e9c6;
}

.error {
  background-color: #f2dede;
  color: #a94442;
  border: 1px solid #ebccd1;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .form-container {
    padding: 1.5rem;
  }

  .upload-form {
    padding: 2rem;
  }

  .form-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
}

@media (max-width: 480px) {
  .form-container {
    padding: 1rem;
  }

  .upload-form {
    padding: 1.5rem;
  }

  .submit-button {
    width: 100%;
    padding: 0.9rem;
  }
}
</style>
