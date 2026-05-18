<template>
  <div class="login-container">
    <div class="login-card">
      <div class="logo">
        <img src="../../assets/Logo.png" alt="管理员头像" class="avatar-img" />
        <h1>管理员系统</h1>
      </div>

      <form @submit.prevent="handleLogin">
        <div class="form-group">
          <label for="username">用户名</label>
          <input id="username" v-model="form.username" type="text" placeholder="请输入用户名" />
        </div>

        <div class="form-group">
          <label for="password">密码</label>
          <input id="password" v-model="form.password" type="password" placeholder="请输入密码" />
        </div>

        <button type="submit" :disabled="loading">
          <span v-if="!loading">登录</span>
          <span v-else>登录中...</span>
        </button>
      </form>
    </div>

    <div class="footer">
      <p>© {{ new Date().getFullYear() }} 管理系统</p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

interface LoginForm {
  username: string
  password: string
}

const form = ref<LoginForm>({
  username: '',
  password: '',
})

const loading = ref(false)

const handleLogin = () => {
  loading.value = true

  // 模拟API请求延迟
  setTimeout(() => {
    // 硬编码验证 - 用户名和密码都是 admin
    if (form.value.username === 'admin' && form.value.password === 'admin') {
      // 登录成功，跳转到管理页面
      router.push('/Manager')
    } else {
      //   alert('用户名或密码错误！')
    }

    loading.value = false
  }, 800)
}
</script>

<style scoped>
.login-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  background-color: #f8f8f8;
  padding: 2rem;
  justify-content: center;
  align-items: center;
}

.login-card {
  width: 100%;
  max-width: 420px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.12);
  padding: 2rem;
  margin-bottom: 2rem;
}

.logo {
  text-align: center;
  margin-bottom: 2rem;
}

.avatar-img {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid #42b883;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.logo h1 {
  margin-top: 1rem;
  font-size: 1.5rem;
  color: #213547;
}

.form-group {
  margin-bottom: 1.5rem;
}

label {
  display: block;
  margin-bottom: 0.5rem;
  font-size: 0.9rem;
  font-weight: 500;
  color: #213547;
}

input {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #e5e7eb;
  border-radius: 4px;
  font-size: 1rem;
  transition: border-color 0.2s;
}

input:focus {
  outline: none;
  border-color: #42b883;
}

button {
  width: 100%;
  padding: 0.75rem;
  background-color: #42b883;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  transition: background-color 0.2s;
}

button:hover:not(:disabled) {
  background-color: #3aa876;
}

button:disabled {
  background-color: #a0aec0;
  cursor: not-allowed;
}

.footer {
  text-align: center;
  color: #64748b;
  font-size: 0.875rem;
}
</style>
