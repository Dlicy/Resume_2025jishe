<template>
  <div class="user-management">
    <div class="list-header">
      <h2 class="page-title">用户管理</h2>
      <div class="search-box">
        <input
          v-model="searchQuery"
          type="search"
          placeholder="输入用户名或邮箱..."
          class="search-input"
        />
        <button @click="fetchUsers" class="refresh-btn">
          <span class="search-icon">🔍</span> 搜索
        </button>
        <button @click="fetchUsers" class="refresh-btn">
          <span class="refresh-icon">↻</span> 刷新
        </button>
      </div>
    </div>
    <div v-if="searchQuery" class="search-status">
      <span class="search-results">
        找到 {{ filteredUsers.length }} 条匹配 "{{ searchQuery }}" 的结果
      </span>
      <button v-if="filteredUsers.length === 0" @click="clearSearch" class="clear-search-link">
        清除搜索
      </button>
    </div>

    <div class="table-container">
      <table class="user-table">
        <thead>
          <tr>
            <th>头像</th>
            <th @click="sortUsers('username')">用户名</th>
            <th @click="sortUsers('email')">邮箱</th>
            <th @click="sortUsers('registerTime')">注册时间</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(user, index) in paginatedUsers"
            :key="user.id"
            :class="{ 'even-row': index % 2 === 0 }"
          >
            <td>
              <img :src="user.avatar || defaultAvatar" class="user-avatar" alt="用户头像" />
            </td>
            <td>{{ user.username }}</td>
            <td>{{ user.email }}</td>
            <td>{{ formatDate(user.createdAt) }}</td>
            <td class="actions-cell">
              <button @click="openEditModal(user)" class="action-btn edit">编辑</button>
              <button @click="confirmDelete(user.id)" class="action-btn delete">删除</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="pagination-container" v-if="totalPages > 1">
      <button
        v-for="page in totalPages"
        :key="page"
        @click="currentPage = page"
        :class="{ 'active-page': currentPage === page, 'page-btn': true }"
      >
        {{ page }}
      </button>
    </div>

    <!-- 编辑模态框 -->
    <dialog ref="editDialog" class="edit-modal">
      <h3>编辑用户</h3>
      <form @submit.prevent="submitEdit">
        <div class="form-group">
          <label>用户名</label>
          <input v-model="editForm.username" required />
        </div>
        <div class="form-group">
          <label>邮箱</label>
          <input v-model="editForm.email" type="email" required />
        </div>
        <div class="form-actions">
          <button type="button" @click="closeEdit">取消</button>
          <button type="submit">保存</button>
        </div>
      </form>
    </dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch, reactive } from 'vue'
import axios from 'axios'

const users = ref([])
const searchQuery = ref('')
const currentPage = ref(1)
const itemsPerPage = 10
const sortField = ref('createdAt')
const sortDirection = ref('desc')
const isLoading = ref(false)
const errorMessage = ref('')
const defaultAvatar = ref('/images/default-avatar.png')
const editDialog = ref(null)
const editForm = reactive({
  id: null,
  username: '',
  email: '',
  avatar: '',
})

// API配置
const API_BASE = import.meta.env.VITE_API_URL
const API_ENDPOINTS = {
  GET_USERS: `/User`,
  UPDATE_USER: (id) => `/User/${id}`,
  DELETE_USER: (id) => `/User/${id}`,
}

// 获取用户列表
const fetchUsers = async () => {
  isLoading.value = true
  errorMessage.value = ''
  try {
    const params = {
      page: currentPage.value - 1,
      size: itemsPerPage,
      sort: `${sortField.value},${sortDirection.value}`,
    }

    if (searchQuery.value) {
      params.search = searchQuery.value
    }

    const response = await axios.get(API_ENDPOINTS.GET_USERS, { params })
    users.value = response.data.content
  } catch (error) {
    errorMessage.value = '获取用户列表失败，请稍后重试'
    console.error('Error fetching users:', error)
  } finally {
    isLoading.value = false
  }
}

// 排序用户
const sortUsers = (field) => {
  if (sortField.value === field) {
    sortDirection.value = sortDirection.value === 'asc' ? 'desc' : 'asc'
  } else {
    sortField.value = field
    sortDirection.value = 'asc'
  }
  fetchUsers()
}

// 编辑用户
const openEditModal = (user) => {
  editForm.id = user.id
  editForm.username = user.username
  editForm.email = user.email
  editForm.avatar = user.avatar || ''
  editDialog.value.showModal()
}

// 提交编辑
const submitEdit = async () => {
  try {
    const response = await axios.put(`/api/users/${editForm.id}`, {
      username: editForm.username,
      email: editForm.email,
      avatar: editForm.avatar,
    })

    // 更新本地数据
    const index = users.value.findIndex((u) => u.id === editForm.id)
    if (index !== -1) {
      users.value[index] = response.data
    }

    closeEdit()
  } catch (error) {
    console.error('更新失败:', error)
    alert(`更新失败: ${error.response?.data?.message || error.message}`)
  }
}

// 关闭模态框
const closeEdit = () => {
  editDialog.value.close()
}

// 格式化日期
const formatDate = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return date.toLocaleDateString() + ' ' + date.toLocaleTimeString()
}

// 计算属性
const filteredUsers = computed(() => {
  const query = searchQuery.value.toLowerCase()
  if (!query) return users.value

  return users.value.filter(
    (user) =>
      user.username.toLowerCase().includes(query) || user.email.toLowerCase().includes(query),
  )
})

const totalPages = computed(() => {
  return Math.ceil(filteredUsers.value.length / itemsPerPage)
})

const paginatedUsers = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage
  const end = start + itemsPerPage
  return filteredUsers.value.slice(start, end)
})

// 清除搜索框
const clearSearch = () => {
  searchQuery.value = ''
  currentPage.value = 1
  fetchUsers()
}

// 初始化加载数据
onMounted(() => {
  fetchUsers()
})

// 监听搜索条件变化
watch(searchQuery, () => {
  currentPage.value = 1
  fetchUsers()
})

// 监听页码变化
watch(currentPage, fetchUsers)
</script>

<style scoped>
/* 基础样式 */
.user-management {
  padding: 24px;
  max-width: 1200px;
  margin: 0 auto;
}

.list-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.page-title {
  font-size: 1.5rem;
  color: #2d3748;
}

.search-box {
  display: flex;
  gap: 12px;
}

.search-input {
  padding: 10px 16px;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  font-size: 14px;
  width: 300px;
  transition: all 0.2s;
}

.search-input:focus {
  border-color: #4299e1;
  box-shadow: 0 0 0 2px rgba(66, 153, 225, 0.2);
  outline: none;
}

.refresh-btn {
  padding: 10px 16px;
  background-color: #f8fafc;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 6px;
}

.refresh-btn:hover {
  background-color: #edf2f7;
}

.user-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

.user-table th,
.user-table td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #e2e8f0;
}

.user-table th {
  background-color: #f7fafc;
  color: #4a5568;
  cursor: pointer;
}

.user-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
}

.actions-cell {
  gap: 0.5rem;
}

.action-btn {
  padding: 8px 16px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 0.9rem;
}

.action-btn.edit {
  background-color: rgba(236, 201, 75, 0.1);
  color: #d69e2e;
}

.action-btn.delete {
  background-color: rgba(245, 101, 101, 0.1);
  color: #e53e3e;
}

.pagination-container {
  display: flex;
  justify-content: center;
  gap: 5px;
  margin-top: 20px;
}

.page-btn {
  padding: 8px 16px;
  border: 1px solid #e2e8f0;
  background-color: white;
  border-radius: 6px;
  cursor: pointer;
}

.page-btn:hover {
  background-color: #f7fafc;
}

.active-page {
  background-color: #4299e1;
  color: white;
  border-color: #4299e1;
}

.edit-modal {
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.form-group {
  margin-bottom: 15px;
}

.form-group input {
  padding: 10px;
  border-radius: 8px;
  border: 1px solid #ddd;
}

.form-actions button {
  padding: 10px 20px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}

.form-actions button:first-child {
  background-color: #f8fafc;
}

.form-actions button:last-child {
  background-color: #4299e1;
  color: white;
}

.error-message {
  color: #e53e3e;
  font-size: 0.9rem;
  margin-top: 1rem;
}
</style>
