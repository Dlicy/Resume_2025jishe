<template>
  <div class="register-container">
    <div class="register-card">
      <h2 class="register-title">用户注册</h2>
      <el-form
        ref="ruleFormRef"
        :model="ruleForm"
        status-icon
        :rules="rules"
        label-width="100px"
        class="register-form"
        label-position="top"
      >
        <!-- 用户名输入 -->
        <el-form-item label="用户名" prop="userName">
          <el-input
            v-model="ruleForm.userName"
            autocomplete="off"
            placeholder="2-16位字符"
            class="input-item"
          >
            <template #prefix>
              <el-icon><User /></el-icon>
            </template>
          </el-input>
        </el-form-item>

        <!-- 邮箱输入和获取验证码按钮 -->
        <el-form-item label="邮箱" prop="email">
          <el-row :gutter="15">
            <el-col :span="16">
              <el-input
                v-model="ruleForm.email"
                type="email"
                autocomplete="off"
                placeholder="请输入有效邮箱"
                class="input-item"
              >
                <template #prefix>
                  <el-icon><Message /></el-icon>
                </template>
              </el-input>
            </el-col>
            <el-col :span="8">
              <el-button
                type="primary"
                @click="getVerificationCode"
                :disabled="codeButtonDisabled"
                :loading="codeButtonLoading"
                class="code-btn"
              >
                {{ codeButtonText }}
              </el-button>
            </el-col>
          </el-row>
        </el-form-item>

        <!-- 密码输入 -->
        <el-form-item label="密码" prop="password">
          <el-input
            v-model="ruleForm.password"
            type="password"
            autocomplete="new-password"
            placeholder="6-16位字符"
            show-password
            class="input-item"
          >
            <template #prefix>
              <el-icon><Lock /></el-icon>
            </template>
          </el-input>
        </el-form-item>

        <!-- 确认密码输入 -->
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input
            v-model="ruleForm.confirmPassword"
            type="password"
            autocomplete="new-password"
            placeholder="请再次输入密码"
            show-password
            class="input-item"
          >
            <template #prefix>
              <el-icon><Lock /></el-icon>
            </template>
          </el-input>
        </el-form-item>

        <!-- 验证码输入 -->
        <el-form-item label="验证码" prop="code">
          <el-input
            v-model="ruleForm.code"
            autocomplete="off"
            placeholder="6位数字验证码"
            class="input-item"
          >
            <template #prefix>
              <el-icon><Key /></el-icon>
            </template>
          </el-input>
        </el-form-item>

        <!-- 注册和返回按钮 -->
        <el-form-item class="form-actions">
          <el-button
            type="primary"
            @click="submitForm(ruleFormRef)"
            :loading="submitLoading"
            class="register-btn"
          >
            注册
          </el-button>
          <div class="action-links">
            <el-button link type="primary" @click="toLogin">已有账号? 立即登录</el-button>
          </div>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, reactive } from 'vue'
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus'
import { User, Lock, Message, Key } from '@element-plus/icons-vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const ruleFormRef = ref<FormInstance>()
const current_code = ref()

// 表单数据
const ruleForm = reactive({
  userName: '',
  email: '',
  password: '',
  confirmPassword: '',
  code: '',
})

// 按钮状态
const codeButtonDisabled = ref(false)
const codeButtonLoading = ref(false)
const codeButtonText = ref('获取验证码')
const submitLoading = ref(false)

const toLogin = () => {
  router.push('/login')
}

// 验证规则
const validatePassword = (rule: any, value: string, callback: Function) => {
  if (!value) {
    callback(new Error('请输入密码'))
  } else if (value.length < 6) {
    callback(new Error('密码长度不能少于6位'))
  } else if (value.length > 16) {
    callback(new Error('密码长度不能超过16位'))
  } else {
    callback()
  }
}

const validateConfirmPassword = (rule: any, value: string, callback: Function) => {
  if (!value) {
    callback(new Error('请再次输入密码'))
  } else if (value !== ruleForm.password) {
    callback(new Error('两次输入的密码不一致'))
  } else {
    callback()
  }
}

const rules: FormRules = {
  userName: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 2, max: 16, message: '用户名长度在2到16个字符', trigger: 'blur' },
  ],
  email: [
    { required: true, message: '请输入邮箱地址', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change'] },
  ],
  password: [{ validator: validatePassword, trigger: ['blur', 'change'] }],
  confirmPassword: [{ validator: validateConfirmPassword, trigger: ['blur', 'change'] }],
  code: [
    { required: true, message: '请输入验证码', trigger: 'blur' },
    { pattern: /^\d{4}$/, message: '验证码必须是6位数字', trigger: 'blur' },
  ],
}

// 获取验证码
const getVerificationCode = async () => {
  try {
    const emailValid = await ruleFormRef.value?.validateField('email')
    if (!emailValid) return

    codeButtonLoading.value = true
    codeButtonDisabled.value = true

    const url = '/Verification/sendCode'
    const response = await axios.post(url, null, {
      params: { touser: ruleForm.email },
    })

    if (response.data.success) {
      // console.log('response.data:', response.data.data);
      current_code.value = response.data.data
      ElMessage.success('验证码已发送至邮箱')
      startCountdown()
    } else {
      ElMessage.error(response.data.message || '验证码发送失败')
      codeButtonLoading.value = false
      codeButtonDisabled.value = false
    }
  } catch (error) {
    console.error('请求出错:', error)
    codeButtonLoading.value = false
    codeButtonDisabled.value = false

    if (axios.isAxiosError(error)) {
      if (error.response) {
        switch (error.response.status) {
          case 400:
            ElMessage.error('邮箱格式不正确')
            break
          case 429:
            ElMessage.error('请求过于频繁，请稍后再试')
            break
          default:
            ElMessage.error('验证码发送失败，请稍后重试')
        }
      } else {
        ElMessage.error('网络错误，请检查网络连接')
      }
    }
  }
}

// 倒计时功能
const startCountdown = () => {
  codeButtonLoading.value = false
  let countdown = 60

  const timer = setInterval(() => {
    codeButtonText.value = `${countdown}秒后重新获取`
    countdown--

    if (countdown < 0) {
      clearInterval(timer)
      codeButtonText.value = '获取验证码'
      codeButtonDisabled.value = false
    }
  }, 1000)
}

// 提交表单
const submitForm = async (formEl: FormInstance | undefined) => {
  if (!formEl) return

  if (ruleForm.code != current_code.value) {
    // console.log('ruleForme.code:', ruleForm.code);
    // console.log('current_code:', current_code.value);
    ElMessage.error('验证码错误')
  }

  try {
    const valid = await formEl.validate()
    if (!valid) return

    submitLoading.value = true

    const url = '/User/register'
    const response = await axios.post(url, null, {
      params: { email: ruleForm.email, password: ruleForm.password, code: ruleForm.code },
    })

    console.log('response.data', response.data)

    if (response.data.success) {
      ElMessage.success('注册成功！')
      formEl.resetFields()
      router.push('/login')
    } else {
      ElMessage.error(response.data.message || '注册失败')
    }
  } catch (error) {
    console.error('注册出错:', error)
    if (axios.isAxiosError(error)) {
      if (error.response) {
        switch (error.response.status) {
          case 400:
            ElMessage.error('请求参数错误')
            break
          case 409:
            ElMessage.error('用户名或邮箱已被注册')
            break
          case 422:
            ElMessage.error('验证码错误或已过期')
            break
          default:
            ElMessage.error('注册失败，请稍后重试')
        }
      } else {
        ElMessage.error('网络错误，请检查网络连接')
      }
    }
  } finally {
    submitLoading.value = false
  }
}
</script>

<style scoped>
.register-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  padding: 20px;
}

.register-card {
  width: 100%;
  max-width: 480px;
  padding: 40px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.register-card:hover {
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
}

.register-title {
  text-align: center;
  margin-bottom: 30px;
  color: #303133;
  font-size: 24px;
  font-weight: 500;
}

.register-form {
  margin-top: 20px;
}

.input-item {
  width: 100%;
}

.input-item :deep(.el-input__inner) {
  padding-left: 35px;
  height: 42px;
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

.register-btn {
  width: 100%;
  height: 45px;
  font-size: 16px;
  border-radius: 6px;
  margin-bottom: 15px;
}

.code-btn {
  width: 100%;
  height: 42px;
  white-space: nowrap;
}

.action-links {
  display: flex;
  justify-content: center;
  width: 100%;
}

.action-links .el-button {
  padding: 0;
  height: auto;
}

@media (max-width: 480px) {
  .register-card {
    padding: 30px 20px;
  }

  .register-title {
    font-size: 20px;
    margin-bottom: 20px;
  }

  .input-item :deep(.el-input__inner) {
    height: 38px;
  }

  .register-btn {
    height: 42px;
  }

  .code-btn {
    height: 38px;
    font-size: 14px;
  }
}
</style>
