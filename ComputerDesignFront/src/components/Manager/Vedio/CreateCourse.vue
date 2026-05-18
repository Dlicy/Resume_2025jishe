<template>
  <div class="form-container">
    <div class="course-form">
      <h2>创建新课程</h2>
      <div class="form-grid">
        <!-- 课程标题 -->
        <div class="form-group">
          <label for="title">课程标题</label>
          <input
            id="title"
            v-model="form.title"
            type="text"
            placeholder="请输入课程标题"
            required
            class="form-input"
          />
        </div>

        <!-- 课程描述 -->
        <div class="form-group">
          <label for="description">课程描述</label>
          <textarea
            id="description"
            v-model="form.description"
            placeholder="请输入课程详细描述"
            class="form-input"
            rows="5"
          ></textarea>
        </div>

        <!-- 封面图片上传 -->
        <div class="form-group file-upload-group">
          <label for="coverImage">封面图片</label>
          <div class="file-upload-wrapper">
            <label for="coverImage" class="file-upload-label">
              <span v-if="!form.coverImage" class="file-placeholder">
                <svg class="upload-icon" viewBox="0 0 24 24">
                  <path
                    d="M5 3h14a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2zm7 4a3 3 0 1 0 0 6 3 3 0 0 0 0-6zm-7 9v1h14v-1c0-2-3.5-3-7-3s-7 1-7 3z"
                  />
                </svg>
                <span>选择封面图片</span>
              </span>
              <span v-else class="file-name">{{ form.coverImage.name }}</span>
              <input type="file" id="coverImage" @change="handleImageChange" accept="image/*" />
            </label>
            <span class="file-hint">支持JPG, PNG格式，建议尺寸1200×630px</span>
          </div>
          <div v-if="coverPreview" class="cover-preview">
            <img :src="coverPreview" alt="封面预览" class="preview-image" />
          </div>
        </div>
      </div>

      <!-- 按钮容器 -->
      <div class="button-container">
        <button
          type="submit"
          class="submit-button"
          @click.prevent="submitForm"
          :disabled="submitting"
        >
          <span>{{ submitting ? '创建中...' : '创建课程' }}</span>
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
        coverImage: null,
      },
      coverPreview: null,
      submitting: false,
      message: '',
      isSuccess: false,
    }
  },
  methods: {
    handleImageChange(event) {
      const file = event.target.files[0]
      this.form.coverImage = file

      if (file) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.coverPreview = e.target.result
        }
        reader.readAsDataURL(file)
      } else {
        this.coverPreview = null
      }
    },
    async submitForm() {
      if (!this.form.title.trim()) {
        this.showMessage('请输入课程标题', false)
        return
      }

      this.submitting = true

      const formData = new FormData()
      formData.append('title', this.form.title)
      formData.append('description', this.form.description)
      formData.append('creatorId', 0)

      if (this.form.coverImage) {
        formData.append('coverImage', this.form.coverImage)
      }

      try {
        const response = await axios.post('/api/courses', formData, {
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        })

        this.showMessage('课程创建成功', true)
        this.resetForm()
      } catch (error) {
        console.error('创建课程失败:', error)
        this.showMessage('课程创建失败: ' + (error.response?.data?.message || error.message), false)
      } finally {
        this.submitting = false
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
        coverImage: null,
      }
      this.coverPreview = null
      const input = document.getElementById('coverImage')
      if (input) input.value = ''
    },
  },
}
</script>

<style scoped>
/* 基础样式 - 与之前保持一致 */
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

.course-form {
  max-width: 900px;
  margin: 0 auto;
  padding: 2.5rem;
  background: white;
  border-radius: 16px;
  box-shadow:
    0 10px 25px -5px rgba(0, 0, 0, 0.05),
    0 5px 10px -5px rgba(0, 0, 0, 0.02);
}

.course-form h2 {
  color: #1a365d;
  margin-bottom: 2rem;
  font-weight: 700;
  font-size: 1.75rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #e2e8f0;
  position: relative;
}

.course-form h2::after {
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
  min-height: 120px;
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
  max-width: 300px;
  max-height: 200px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
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

  .course-form {
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

  .course-form {
    padding: 1.5rem;
  }

  .submit-button {
    width: 100%;
    padding: 0.9rem;
  }
}
</style>
