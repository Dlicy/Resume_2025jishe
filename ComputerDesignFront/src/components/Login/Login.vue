<template>
  <div class="login-container">
    <div class="login-card">
      <h2 class="login-title">用户登录</h2>
      <el-form
        ref="ruleFormRef"
        :model="ruleForm"
        status-icon
        :rules="rules"
        label-width="80px"
        class="login-form"
        label-position="top"
      >
        <el-form-item label="邮箱" prop="email">
          <el-input
            v-model="ruleForm.email"
            type="email"
            autocomplete="off"
            placeholder="请输入邮箱地址"
            class="input-item"
          >
            <template #prefix>
              <el-icon><User /></el-icon>
            </template>
          </el-input>
        </el-form-item>

        <el-form-item label="密码" prop="password">
          <el-input
            v-model="ruleForm.password"
            type="password"
            autocomplete="current-password"
            placeholder="请输入密码"
            show-password
            class="input-item"
          >
            <template #prefix>
              <el-icon><Lock /></el-icon>
            </template>
          </el-input>
        </el-form-item>

        <el-form-item class="form-actions">
          <el-button
            type="primary"
            @click="submitForm(ruleFormRef)"
            :loading="loading"
            class="login-btn"
          >
            登录
          </el-button>
          <div class="action-links">
            <el-button link type="primary" @click="toRegister">注册账号</el-button>
            <el-button link type="primary" @click="toForgotPassword">忘记密码?</el-button>
          </div>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue'
import type { FormInstance } from 'element-plus'
import { ElMessage } from 'element-plus'
import { User, Lock } from '@element-plus/icons-vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const ruleFormRef = ref<FormInstance>()
const loading = ref(false)

const ruleForm = reactive({
  email: '',
  password: '',
})

const rules = {
  email: [
    { required: true, message: '请输入邮箱地址', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change'] },
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 16, message: '密码长度在6到16个字符', trigger: 'blur' },
  ],
}

const toRegister = () => {
  router.push('/register')
}

const toForgotPassword = () => {
  router.push('/forgot-password')
}

const submitForm = async (formEl: FormInstance | undefined) => {
  if (!formEl) return

  try {
    await formEl.validate()
    loading.value = true

    const url = '/User/login'
    const response = await axios.post(url, null, {
      params: { email: ruleForm.email, password: ruleForm.password },
    })

    if (response.data.success) {
      // 存储 token 和用户信息
      localStorage.setItem('token', response.data.data.token)
      localStorage.setItem(
        'user',
        JSON.stringify({
          id: response.data.data.id,
          username: response.data.data.username,
          email: response.data.data.email,
          avatarUrl: response.data.data.avatar,
        }),
      )
      ElMessage.success('登录成功')
      router.push('/')
    } else {
      ElMessage.error(response.data.message || '登录失败')
    }
  } catch (error) {
    console.error('登录错误:', error)
    if (axios.isAxiosError(error)) {
      if (error.response) {
        switch (error.response.status) {
          case 400:
            ElMessage.error('请求参数错误')
            break
          case 401:
            ElMessage.error('邮箱或密码不正确')
            break
          case 500:
            ElMessage.error('服务器错误，请稍后再试')
            break
          default:
            ElMessage.error('登录失败: ' + (error.response.data?.message || '未知错误'))
        }
      } else if (error.request) {
        ElMessage.error('网络错误，请检查网络连接')
      }
    } else {
      ElMessage.error('发生未知错误')
    }
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  padding: 20px;
}

.login-card {
  width: 100%;
  max-width: 420px;
  padding: 40px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.login-card:hover {
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
}

.login-title {
  text-align: center;
  margin-bottom: 30px;
  color: #303133;
  font-size: 24px;
  font-weight: 500;
}

.login-form {
  margin-top: 20px;
}

.input-item {
  width: 100%;
}

.input-item :deep(.el-input__inner) {
  padding-left: 35px;
}

.input-item :deep(.el-input__prefix) {
  display: flex;
  align-items: center;
  padding: 0 8px;
  color: #c0c4cc;
}

.form-actions {
  margin-top: 30px;
}

.login-btn {
  width: 100%;
  height: 45px;
  font-size: 16px;
  border-radius: 6px;
}

.action-links {
  display: flex;
  justify-content: space-between;
  width: 100%;
  margin-top: 15px;
}

.action-links .el-button {
  padding: 0;
  height: auto;
}

@media (max-width: 480px) {
  .login-card {
    padding: 30px 20px;
  }

  .login-title {
    font-size: 20px;
    margin-bottom: 20px;
  }
}
</style>
