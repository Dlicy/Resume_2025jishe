<template>
  <header ref="headerEl" class="bili-header sticky-search-header">
    <div class="header-bar">
      <!-- 左侧品牌标识 -->
      <div class="left-entry">
        <div class="tcm-brand">
          <svg class="tcm-icon" width="24" height="24" viewBox="0 0 24 24" fill="#C93C23">
            <path
              d="M12 2L4 5v6.09c0 5.05 3.41 9.76 8 10.91 4.59-1.15 8-5.86 8-10.91V5l-8-3zm-1.06 13.54L7.4 12l1.41-1.41 2.12 2.12 4.24-4.24 1.41 1.41-5.64 5.66z"
            />
            <path d="M16.59 7.58L10 14.17l-2.59-2.58L6 13l4 4 8-8z" />
          </svg>
          <div class="tcm-text">
            <div class="tcm-name">中医传承</div>
            <div class="tcm-slogan">Traditional Chinese Medicine</div>
          </div>
        </div>
      </div>

      <!-- 中央搜索区域 -->
      <div class="center-search-container">
        <div class="center-search__bar">
          <form class="nav-searchform" @submit.prevent="handleSearch">
            <div class="nav-search-content">
              <input
                class="nav-search-input"
                type="text"
                v-model="searchQuery"
                @input="handleInput"
                placeholder="搜索中医课程、经典方剂、穴位名称..."
              />
              <div class="nav-search-clean" @click="clearSearch" v-if="searchQuery">
                <svg width="16" height="16" viewBox="0 0 16 16" fill="#8D6E63">
                  <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="M8 14.75C11.7279 14.75 14.75 11.7279 14.75 8C14.75 4.27208 11.7279 1.25 8 1.25C4.27208 1.25 1.25 4.27208 1.25 8C1.25 11.7279 4.27208 14.75 8 14.75ZM9.64999 5.64303C9.84525 5.44777 10.1618 5.44777 10.3571 5.64303C10.5524 5.83829 10.5524 6.15487 10.3571 6.35014L8.70718 8.00005L10.3571 9.64997C10.5524 9.84523 10.5524 10.1618 10.3571 10.3571C10.1618 10.5523 9.84525 10.5523 9.64999 10.3571L8.00007 8.70716L6.35016 10.3571C6.15489 10.5523 5.83831 10.5523 5.64305 10.3571C5.44779 10.1618 5.44779 9.84523 5.64305 9.64997L7.29296 8.00005L5.64305 6.35014C5.44779 6.15487 5.44779 5.83829 5.64305 5.64303C5.83831 5.44777 6.15489 5.44777 6.35016 5.64303L8.00007 7.29294L9.64999 5.64303Z"
                  />
                </svg>
              </div>
            </div>
            <button class="nav-search-btn" type="submit">
              <svg width="17" height="17" viewBox="0 0 17 17" fill="#8D6E63">
                <path
                  fill-rule="evenodd"
                  clip-rule="evenodd"
                  d="M16.3451 15.2003C16.6377 15.4915 16.4752 15.772 16.1934 16.0632C16.15 16.1279 16.0958 16.1818 16.0525 16.2249C15.7707 16.473 15.4456 16.624 15.1854 16.3652L11.6848 12.8815C10.4709 13.8198 8.97529 14.3267 7.44714 14.3267C3.62134 14.3267 0.5 11.2314 0.5 7.41337C0.5 3.60616 3.6105 0.5 7.44714 0.5C11.2729 0.5 14.3943 3.59538 14.3943 7.41337C14.3943 8.98802 13.8524 10.5087 12.8661 11.7383L16.3451 15.2003ZM2.13647 7.4026C2.13647 10.3146 4.52083 12.6766 7.43624 12.6766C10.3517 12.6766 12.736 10.3146 12.736 7.4026C12.736 4.49058 10.3517 2.1286 7.43624 2.1286C4.50999 2.1286 2.13647 4.50136 2.13647 7.4026Z"
                />
              </svg>
            </button>
          </form>
        </div>
      </div>

      <!-- 右侧新功能区域 -->
      <div class="right-entry">
        <div class="tcm-actions">
          <button class="tcm-btn special-btn" @click="navigateTo('special')">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="#9C27B0">
              <path
                d="M12 2L4 5v6.09c0 5.05 3.41 9.76 8 10.91 4.59-1.15 8-5.86 8-10.91V5l-8-3zm3 14l-3-3-3 3-1.5-1.5L12 9l4.5 4.5L15 16z"
              />
            </svg>
            <span>专题课程</span>
          </button>

          <button class="tcm-btn progress-btn" @click="navigateTo('progress')">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="#FF9800">
              <path
                d="M13 2.05v2.02c3.95.49 7 3.85 7 7.93 0 3.21-1.92 6-4.72 7.28l-1.5-2.6C16.19 15.53 17 13.93 17 12c0-2.76-2.24-5-5-5s-5 2.24-5 5c0 1.93.81 3.53 2.22 4.63l-1.5 2.6C5.92 17 4 14.21 4 11c0-4.08 3.05-7.44 7-7.93V2.05c-5.06.5-9 4.76-9 9.95 0 5.52 4.47 10 9.99 10S22 17.52 22 12c0-5.19-3.94-9.45-9-9.95z"
              />
            </svg>
            <span>学习进度</span>
          </button>

          <button class="tcm-btn daily-btn" @click="navigateTo('daily')">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="#00BCD4">
              <path
                d="M11 12h2v-2h-2v2zm0-4h2V6h-2v2zm0 8h2v-2h-2v2zm-6 4h12V4H5v16zm0-18h12c1.1 0 2 .9 2 2v16c0 1.1-.9 2-2 2H5c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2z"
              />
            </svg>
            <span>每日一学</span>
          </button>
        </div>
      </div>
    </div>
  </header>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { debounce } from 'lodash'

const router = useRouter()
const headerEl = ref(null)
const searchQuery = ref('')

const emit = defineEmits(['search'])

// 滚动时添加阴影效果
onMounted(() => {
  window.addEventListener('scroll', () => {
    if (headerEl.value) {
      const isScrolled = window.scrollY > 10
      headerEl.value.classList.toggle('scrolled', isScrolled)
    }
  })
})

const handleInput = debounce(() => {
  emit('search', searchQuery.value.trim())
}, 300)

const handleSearch = () => {
  const query = searchQuery.value.trim()
  emit('search', query)
}

const clearSearch = () => {
  searchQuery.value = ''
  emit('search', '')
}

const navigateTo = (destination) => {
  switch (destination) {
    case 'special':
      router.push('/special-topics')
      break
    case 'progress':
      router.push('/learning-progress')
      break
    case 'daily':
      router.push('/daily-learning')
      break
  }
}
</script>

<style scoped>
/* 粘性定位核心样式 */
.sticky-search-header {
  position: sticky;
  top: 64px;
  z-index: 90;
  background-color: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(8px);
  transition: all 0.3s ease;
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.sticky-search-header.scrolled {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

/* 兼容不支持backdrop-filter的浏览器 */
@supports not (backdrop-filter: blur(8px)) {
  .sticky-search-header {
    background-color: rgba(255, 255, 255, 0.98);
  }
}

/* 原有样式调整 */
.bili-header {
  background-color: transparent;
  box-shadow: none;
}

.header-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 70px;
  padding: 0 24px;
  max-width: 1600px;
  margin: 0 auto;
}

.left-entry {
  flex: 0 0 220px;
}

.tcm-brand {
  display: flex;
  align-items: center;
  cursor: pointer;
}

.tcm-icon {
  margin-right: 12px;
  flex-shrink: 0;
}

.tcm-text {
  line-height: 1.2;
}

.tcm-name {
  font-size: 18px;
  font-weight: bold;
  color: #c93c23;
  font-family: 'SimSun', serif;
}

.tcm-slogan {
  font-size: 12px;
  color: #8d6e63;
  letter-spacing: 0.5px;
}

.center-search-container {
  flex: 1;
  max-width: 600px;
  margin: 0 30px;
}

.nav-searchform {
  display: flex;
  height: 44px;
  border-radius: 22px;
  overflow: hidden;
  background-color: #f7f3f0;
  border: 1px solid #e0d6d0;
  transition: all 0.3s;
}

.nav-searchform:focus-within {
  box-shadow: 0 2px 8px rgba(201, 60, 35, 0.2);
}

.nav-search-content {
  flex: 1;
  display: flex;
  align-items: center;
  padding: 0 16px;
}

.nav-search-input {
  flex: 1;
  height: 100%;
  border: none;
  background: transparent;
  font-size: 15px;
  outline: none;
  color: #5d4037;
}

.nav-search-input::placeholder {
  color: #a1887f;
}

.nav-search-clean {
  margin-left: 8px;
  cursor: pointer;
  display: flex;
  align-items: center;
}

.nav-search-btn {
  width: 50px;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #ede7e3;
  cursor: pointer;
  border: none;
  transition: background-color 0.3s;
}

.nav-search-btn:hover {
  background-color: #e0d6d0;
}

.right-entry {
  flex: 0 0 auto;
}

.tcm-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.tcm-btn {
  display: flex;
  align-items: center;
  padding: 8px 16px;
  border-radius: 20px;
  font-size: 14px;
  border: none;
  cursor: pointer;
  transition: all 0.3s;
  background-color: transparent;
}

.tcm-btn span {
  margin-left: 8px;
}

.special-btn {
  color: #9c27b0;
  background-color: rgba(156, 39, 176, 0.1);
}

.special-btn:hover {
  background-color: rgba(156, 39, 176, 0.2);
}

.progress-btn {
  color: #ff9800;
  background-color: rgba(255, 152, 0, 0.1);
}

.progress-btn:hover {
  background-color: rgba(255, 152, 0, 0.2);
}

.daily-btn {
  color: #00bcd4;
  background-color: rgba(0, 188, 212, 0.1);
}

.daily-btn:hover {
  background-color: rgba(0, 188, 212, 0.2);
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .tcm-btn span {
    display: none;
  }

  .tcm-btn {
    padding: 8px 12px;
  }
}

@media (max-width: 992px) {
  .header-bar {
    padding: 0 15px;
  }

  .tcm-name {
    font-size: 16px;
  }

  .tcm-slogan {
    display: none;
  }

  .tcm-btn {
    padding: 8px;
  }
}

@media (max-width: 768px) {
  .sticky-search-header {
    top: 60px;
  }

  .left-entry {
    flex: 0 0 auto;
  }

  .tcm-text {
    display: none;
  }

  .center-search-container {
    margin: 0 15px;
  }

  .header-bar {
    padding: 8px 10px;
    height: 60px;
  }

  .nav-searchform {
    height: 40px;
  }
}
</style>
