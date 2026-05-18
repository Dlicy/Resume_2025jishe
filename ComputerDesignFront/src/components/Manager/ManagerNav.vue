<template>
  <div class="sidebar-container">
    <div class="sidebar">
      <h2 class="sidebar-title">管理中心</h2>
      <ul class="menu-list">
        <!-- 用户管理 -->
        <li class="menu-item">
          <router-link
            to="/Manager/EditUser"
            class="menu-link"
            active-class="active"
            exact-active-class="active"
          >
            <span class="link-icon">👤</span>
            <span class="link-text">用户管理</span>
          </router-link>
        </li>

        <!-- 书籍管理 - 带下拉菜单 -->
        <li class="menu-item dropdown">
          <div
            class="dropdown-toggle menu-link"
            @click="toggleDropdown('book')"
            :class="{ active: isDropdownOpen('book') || isBookActive() }"
          >
            <span class="link-icon">📚</span>
            <span class="link-text">书籍管理</span>
            <span class="arrow" :class="{ rotated: isDropdownOpen('book') }">›</span>
          </div>
          <transition name="slide">
            <ul class="dropdown-menu" v-show="isDropdownOpen('book')">
              <li class="submenu-item">
                <router-link
                  to="/Manager/book/AddBooks"
                  class="submenu-link"
                  active-class="active"
                  exact-active-class="active"
                >
                  <span class="submenu-icon">➕</span>
                  <span>添加书籍</span>
                </router-link>
              </li>
              <li class="submenu-item">
                <router-link
                  to="/Manager/book/EditBooks"
                  class="submenu-link"
                  active-class="active"
                  exact-active-class="active"
                >
                  <span class="submenu-icon">✏️</span>
                  <span>编辑书籍</span>
                </router-link>
              </li>
            </ul>
          </transition>
        </li>

        <!-- 虚拟实验室 - 带下拉菜单 -->
        <li class="menu-item dropdown">
          <div
            class="dropdown-toggle menu-link"
            @click="toggleDropdown('lab')"
            :class="{ active: isDropdownOpen('lab') || isLabActive() }"
          >
            <span class="link-icon">🔬</span>
            <span class="link-text">虚拟实验室</span>
            <span class="arrow" :class="{ rotated: isDropdownOpen('lab') }">›</span>
          </div>
          <transition name="slide">
            <ul class="dropdown-menu" v-show="isDropdownOpen('lab')">
              <!-- 针灸穴位子菜单 -->
              <li class="submenu-item has-children">
                <div class="submenu-link directory" @click.stop="toggleDropdown('acupoint')">
                  <span class="submenu-icon">📍</span>
                  <span>针灸穴位</span>
                  <span class="arrow" :class="{ rotated: isDropdownOpen('acupoint') }">›</span>
                </div>
                <transition name="slide">
                  <ul class="nested-menu" v-show="isDropdownOpen('acupoint')">
                    <li class="nested-item">
                      <router-link
                        to="/Manager/lab/acupoint/AddPoint"
                        class="nested-link"
                        active-class="active"
                        exact-active-class="active"
                      >
                        <span class="nested-icon">➕</span>
                        <span>添加穴位</span>
                      </router-link>
                    </li>
                    <li class="nested-item">
                      <router-link
                        to="/Manager/lab/acupoint/EditPoint"
                        class="nested-link"
                        active-class="active"
                        exact-active-class="active"
                      >
                        <span class="nested-icon">✏️</span>
                        <span>编辑穴位</span>
                      </router-link>
                    </li>
                  </ul>
                </transition>
              </li>
            </ul>
          </transition>
        </li>

        <!-- 在线课堂 -->
        <li class="menu-item dropdown">
          <div
            class="dropdown-toggle menu-link"
            @click="toggleDropdown('classroom')"
            :class="{ active: isDropdownOpen('classroom') || isClassroomActive() }"
          >
            <span class="link-icon">🎓</span>
            <span class="link-text">在线课堂</span>
            <span class="arrow" :class="{ rotated: isDropdownOpen('classroom') }">›</span>
          </div>
          <transition name="slide">
            <ul class="dropdown-menu" v-show="isDropdownOpen('classroom')">
              <!-- 课程管理子菜单 -->
              <li class="submenu-item has-children">
                <div class="submenu-link directory" @click.stop="toggleDropdown('course')">
                  <span class="submenu-icon">📖</span>
                  <span>课程管理</span>
                  <span class="arrow" :class="{ rotated: isDropdownOpen('course') }">›</span>
                </div>
                <transition name="slide">
                  <ul class="nested-menu" v-show="isDropdownOpen('course')">
                    <li class="nested-item">
                      <router-link
                        to="/Manager/OnlineCourse/Course/CreateCourse"
                        class="nested-link"
                        active-class="active"
                        exact-active-class="active"
                      >
                        <span class="nested-icon">➕</span>
                        <span>添加课程</span>
                      </router-link>
                    </li>
                    <li class="nested-item">
                      <router-link
                        to="/Manager/OnlineCourse/Course/EditCourse"
                        class="nested-link"
                        active-class="active"
                        exact-active-class="active"
                      >
                        <span class="nested-icon">✏️</span>
                        <span>编辑课程</span>
                      </router-link>
                    </li>
                  </ul>
                </transition>
              </li>

              <!-- 视频管理子菜单 -->
              <li class="submenu-item has-children">
                <div class="submenu-link directory" @click.stop="toggleDropdown('video')">
                  <span class="submenu-icon">🎬</span>
                  <span>视频管理</span>
                  <span class="arrow" :class="{ rotated: isDropdownOpen('video') }">›</span>
                </div>
                <transition name="slide">
                  <ul class="nested-menu" v-show="isDropdownOpen('video')">
                    <li class="nested-item">
                      <router-link
                        to="/Manager/OnlineCourse/Video/UploadVideo"
                        class="nested-link"
                        active-class="active"
                        exact-active-class="active"
                      >
                        <span class="nested-icon">➕</span>
                        <span>添加视频</span>
                      </router-link>
                    </li>
                    <li class="nested-item">
                      <router-link
                        to="/Manager/OnlineCourse/Video/EditVideo"
                        class="nested-link"
                        active-class="active"
                        exact-active-class="active"
                      >
                        <span class="nested-icon">✏️</span>
                        <span>编辑视频</span>
                      </router-link>
                    </li>
                  </ul>
                </transition>
              </li>
            </ul>
          </transition>
        </li>

        <!-- 药物百科管理 -->
        <li class="menu-item dropdown">
          <div
            class="dropdown-toggle menu-link"
            @click="toggleDropdown('encyclopedia')"
            :class="{ active: isDropdownOpen('encyclopedia') || isEncyclopediaActive() }"
          >
            <span class="link-icon">🌿</span>
            <span class="link-text">药物百科管理</span>
            <span class="arrow" :class="{ rotated: isDropdownOpen('encyclopedia') }">›</span>
          </div>
          <transition name="slide">
            <ul class="dropdown-menu" v-show="isDropdownOpen('encyclopedia')">
              <!-- 中药百科子菜单 -->
              <li class="submenu-item has-children">
                <div class="submenu-link directory" @click.stop="toggleDropdown('herbs')">
                  <span class="submenu-icon">🍃</span>
                  <span>中药百科</span>
                  <span class="arrow" :class="{ rotated: isDropdownOpen('herbs') }">›</span>
                </div>
                <transition name="slide">
                  <ul class="nested-menu" v-show="isDropdownOpen('herbs')">
                    <li class="nested-item">
                      <router-link
                        to="/Manager/encyclopedia/AddHerbs"
                        class="nested-link"
                        active-class="active"
                        exact-active-class="active"
                      >
                        <span class="nested-icon">➕</span>
                        <span>添加中药</span>
                      </router-link>
                    </li>
                    <li class="nested-item">
                      <router-link
                        to="/Manager/encyclopedia/EditHerbs"
                        class="nested-link"
                        active-class="active"
                        exact-active-class="active"
                      >
                        <span class="nested-icon">✏️</span>
                        <span>编辑中药</span>
                      </router-link>
                    </li>
                  </ul>
                </transition>
              </li>

              <!-- 修改方剂百科部分 -->
              <li class="submenu-item has-children">
                <div class="submenu-link directory" @click.stop="toggleDropdown('prescription')">
                  <span class="submenu-icon">📜</span>
                  <span>方剂百科</span>
                  <span class="arrow" :class="{ rotated: isDropdownOpen('prescription') }">›</span>
                </div>
                <transition name="slide">
                  <ul class="nested-menu" v-show="isDropdownOpen('prescription')">
                    <li class="nested-item">
                      <router-link
                        to="/manager/encyclopedia/AddFormulas"
                        class="nested-link"
                        active-class="active"
                        exact-active-class="active"
                      >
                        <span class="nested-icon">➕</span>
                        <span>添加方剂</span>
                      </router-link>
                    </li>
                    <li class="nested-item">
                      <router-link
                        to="/manager/encyclopedia/EditFormulas"
                        class="nested-link"
                        active-class="active"
                        exact-active-class="active"
                      >
                        <span class="nested-icon">✏️</span>
                        <span>编辑方剂</span>
                      </router-link>
                    </li>
                  </ul>
                </transition>
              </li>
              <!-- <li class="submenu-item">
                <router-link
                  to="/manager/encyclopedia/disease"
                  class="submenu-link"
                  active-class="active"
                  exact-active-class="active"
                >
                  <span class="submenu-icon">🩺</span>
                  <span>疾病百科</span>
                </router-link>
              </li> -->
            </ul>
          </transition>
        </li>

        <!-- 新增的组卷练习大类 -->
        <li class="menu-item dropdown">
          <div
            class="dropdown-toggle menu-link"
            @click="toggleDropdown('exam')"
            :class="{ active: isDropdownOpen('exam') || isExamActive() }"
          >
            <span class="link-icon">📝</span>
            <span class="link-text">组卷练习</span>
            <span class="arrow" :class="{ rotated: isDropdownOpen('exam') }">›</span>
          </div>
          <transition name="slide">
            <ul class="dropdown-menu" v-show="isDropdownOpen('exam')">
              <li class="submenu-item">
                <router-link
                  to="/Manager/exam/AddQuestion"
                  class="submenu-link"
                  active-class="active"
                  exact-active-class="active"
                >
                  <span class="submenu-icon">➕</span>
                  <span>添加题目</span>
                </router-link>
              </li>
              <li class="submenu-item">
                <router-link
                  to="/Manager/exam/EditQuestion"
                  class="submenu-link"
                  active-class="active"
                  exact-active-class="active"
                >
                  <span class="submenu-icon">📋</span>
                  <span>题目管理</span>
                </router-link>
              </li>
            </ul>
          </transition>
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

// 下拉菜单状态
const dropdownStates = ref({
  encyclopedia: false,
  herbs: false,
  book: false,
  lab: false,
  prescription: false, // 新增方剂百科状态
  acupoint: false,
  classroom: false,
  course: false,
  video: false,
  exam: false, // 新增组卷练习状态
})

// 切换下拉菜单
const toggleDropdown = (menu: keyof typeof dropdownStates.value) => {
  dropdownStates.value[menu] = !dropdownStates.value[menu]
}

// 检查下拉菜单是否打开
const isDropdownOpen = (menu: keyof typeof dropdownStates.value) => {
  return dropdownStates.value[menu]
}

// 检查药物百科相关路由是否激活
const isEncyclopediaActive = () => {
  return route.path.startsWith('/manager/encyclopedia')
}

// 检查中药百科相关路由是否激活
const isHerbsActive = () => {
  return route.path.startsWith('/manager/encyclopedia/herbs')
}

// 检查虚拟实验室相关路由是否激活
const isLabActive = () => {
  return route.path.startsWith('/manager/lab')
}

// 检查针灸穴位相关路由是否激活
const isAcupointActive = () => {
  return route.path.includes('/manager/lab/acupoint')
}

// 检查书籍管理相关路由是否激活
const isBookActive = () => {
  return route.path.startsWith('/manager/book')
}

// 添加方剂百科路由检测方法
const isPrescriptionActive = () => {
  return route.path.includes('/manager/encyclopedia/prescription')
}

// 检查在线课堂相关路由是否激活
const isClassroomActive = () => {
  return route.path.startsWith('/manager/classroom')
}

// 检查组卷练习相关路由是否激活 - 新增
const isExamActive = () => {
  return route.path.startsWith('/manager/exam')
}
</script>

<!-- 样式部分保持不变 -->

<style scoped>
.sidebar-container {
  position: sticky;
  top: 0;
  height: 100vh;
  z-index: 100;
}

.sidebar {
  width: 220px;
  height: 100%;
  background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
  padding: 0 0;
  box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  overflow: hidden; /* 修改为hidden解决滚动条问题 */
}

.sidebar-title {
  color: #fff;
  text-align: center;
  padding: 0 20px 20px;
  margin: 0;
  margin-top: 10px;
  font-size: 1.3rem;
  font-weight: 600;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.menu-list {
  flex: 1;
  padding: 0 15px;
  margin: 0;
  list-style: none;
  overflow-y: auto; /* 只在菜单列表内部添加滚动条 */
}

.menu-item {
  margin-bottom: 5px;
  position: relative;
}

.menu-link {
  color: rgba(255, 255, 255, 0.8);
  text-decoration: none;
  display: flex;
  align-items: center;
  padding: 12px 15px;
  border-radius: 6px;
  transition: all 0.3s ease;
  font-size: 0.95rem;
}

.menu-link:hover {
  background: rgba(255, 255, 255, 0.1);
  color: #fff;
}

.menu-link.active {
  background: #42b983;
  color: #fff;
  font-weight: 500;
}

.link-icon {
  margin-right: 10px;
  font-size: 1.1rem;
}

.link-text {
  flex: 1;
}

/* 下拉菜单样式 */
.dropdown-toggle {
  cursor: pointer;
}

.dropdown-menu {
  padding-left: 10px;
  margin-top: 5px;
  list-style: none;
  overflow: hidden;
}

.submenu-item {
  margin-bottom: 3px;
}

.submenu-link {
  color: rgba(255, 255, 255, 0.7);
  text-decoration: none;
  display: flex;
  align-items: center;
  padding: 8px 15px 8px 30px;
  border-radius: 4px;
  transition: all 0.3s ease;
  font-size: 0.85rem;
  cursor: pointer;
}

.submenu-link:hover {
  background: rgba(255, 255, 255, 0.05);
  color: #fff;
}

.submenu-link.active {
  background: rgba(66, 185, 131, 0.3);
  color: #fff;
}

.has-children {
  position: relative;
}

.nested-menu {
  padding-left: 10px;
  list-style: none;
}

.nested-item {
  margin-bottom: 2px;
}

.nested-link {
  color: rgba(255, 255, 255, 0.6);
  text-decoration: none;
  display: flex;
  align-items: center;
  padding: 6px 15px 6px 45px;
  border-radius: 4px;
  transition: all 0.3s ease;
  font-size: 0.8rem;
}

.nested-link:hover {
  background: rgba(255, 255, 255, 0.03);
  color: #fff;
}

.nested-link.active {
  background: rgba(66, 185, 131, 0.2);
  color: #fff;
}

.nested-icon {
  margin-right: 8px;
  font-size: 0.8rem;
}

.submenu-icon {
  margin-right: 8px;
  font-size: 0.9rem;
}

.arrow {
  font-size: 1.2rem;
  transition: transform 0.3s ease;
  transform: rotate(0deg);
  margin-left: 5px;
}

.arrow.rotated {
  transform: rotate(90deg);
}

/* 过渡动画 */
.slide-enter-active,
.slide-leave-active {
  transition: all 0.3s ease;
  max-height: 500px;
}

.slide-enter-from,
.slide-leave-to {
  opacity: 0;
  max-height: 0;
}

/* 滚动条样式 */
.sidebar::-webkit-scrollbar,
.menu-list::-webkit-scrollbar {
  width: 5px;
}

.sidebar::-webkit-scrollbar-track,
.menu-list::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.05);
}

.sidebar::-webkit-scrollbar-thumb,
.menu-list::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.2);
  border-radius: 3px;
}

.sidebar::-webkit-scrollbar-thumb:hover,
.menu-list::-webkit-scrollbar-thumb:hover {
  background: rgba(255, 255, 255, 0.3);
}

/* 添加目录样式 */
.submenu-link.directory {
  pointer-events: auto; /* 确保可以点击 */
  cursor: pointer;
}

/* 移除目录的active效果 */
.submenu-link.directory.active,
.submenu-link.directory:hover.active {
  background: transparent !important;
  color: rgba(255, 255, 255, 0.7) !important;
}

/* 子菜单项保持原有active效果 */
.submenu-link:not(.directory).active {
  background: rgba(66, 185, 131, 0.3);
  color: #fff;
}

.nested-link.active {
  background: rgba(66, 185, 131, 0.2);
  color: #fff;
}
</style>
