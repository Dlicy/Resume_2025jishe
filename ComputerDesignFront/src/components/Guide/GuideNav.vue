<template>
  <div class="sidebar">
    <div class="sidebar-nav">
      <h3 class="sidebar-title">
        <el-icon><Document /></el-icon>
        系统概述
      </h3>
      <ul class="sidebar-menu">
        <li v-for="item in basicItems" :key="item.to" class="sidebar-menu-item">
          <router-link 
            :to="item.to" 
            class="sidebar-link"
            active-class="active-link"
            @click="emit('item-selected', item)"
          >
            <el-icon class="menu-icon"><component :is="item.icon" /></el-icon>
            <span class="link-text">{{ item.text }}</span>
            <span class="link-arrow">→</span>
          </router-link>
        </li>
      </ul>

      <h3 class="sidebar-title">
        <el-icon><Box /></el-icon>
        虚拟实验室
      </h3>
      <ul class="sidebar-menu">
        <li v-for="item in componentItems" :key="item.to" class="sidebar-menu-item">
          <router-link 
            :to="item.to" 
            class="sidebar-link"
            active-class="active-link"
            @click="emit('item-selected', item)"
          >
            <el-icon class="menu-icon"><component :is="item.icon" /></el-icon>
            <span class="link-text">{{ item.text }}</span>
            <span class="link-arrow">→</span>
          </router-link>
        </li>
      </ul>

      <h3 class="sidebar-title">
        <el-icon><MagicStick /></el-icon>
        系统使用
      </h3>
      <ul class="sidebar-menu">
        <li v-for="item in reusableItems" :key="item.to" class="sidebar-menu-item">
          <router-link 
            :to="item.to" 
            class="sidebar-link"
            active-class="active-link"
            @click="emit('item-selected', item)"
          >
            <el-icon class="menu-icon"><component :is="item.icon" /></el-icon>
            <span class="link-text">{{ item.text }}</span>
            <span class="link-arrow">→</span>
          </router-link>
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Document, Box, MagicStick, Download, InfoFilled, Brush, List, Collection, SwitchButton, Tickets, Connection, SetUp } from '@element-plus/icons-vue'

const emit = defineEmits(['item-selected'])

const basicItems = [
  { to: '/guide/introduction', text: '介绍', icon: InfoFilled }
]

const componentItems = [
  { to: '/guide/untiy', text: '3D穴位模型', icon: MagicStick },
  { to: '/guide/untiypractice', text: '模拟诊断', icon: SetUp }
]

const reusableItems = [
  { to: '/guide/library', text: '中医书库', icon: Box },
  { to: '/guide/onlinecourse', text: '在线课堂', icon: SetUp },
  { to: '/guide/prartice', text: '模拟练习', icon: Connection },
  { to: '/guide/userhome', text: '个人中心', icon: Collection },
  { to: '/guide/manager', text: '管理系统', icon: Brush }
]
</script>

<style scoped>
.sidebar {
  width: 280px;
  position: fixed;
  left: 0;
  top: 64px;
  bottom: 0;
  z-index: 40;
  overflow-y: auto;
  background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
  border-right: 1px solid rgba(0, 0, 0, 0.05);
  padding: 1.5rem 0;
  box-shadow: 2px 0 10px rgba(0, 0, 0, 0.03);
  transition: all 0.3s ease;
}

.sidebar:hover {
  box-shadow: 2px 0 15px rgba(0, 0, 0, 0.05);
}

.sidebar-nav {
  padding: 0 1.5rem;
}

.sidebar-title {
  color: #2c3e50;
  font-size: 0.95em;
  font-weight: 700;
  margin: 1.5rem 0 1rem;
  padding-top: 1rem;
  letter-spacing: 0.5px;
  text-transform: uppercase;
  border-top: 1px solid rgba(0, 0, 0, 0.05);
  position: relative;
}

.sidebar-title:first-child {
  border-top: none;
  padding-top: 0;
}

.sidebar-title::after {
  content: '';
  position: absolute;
  left: 0;
  bottom: -5px;
  width: 30px;
  height: 2px;
  background: #42b983;
  opacity: 0.5;
}

.sidebar-menu {
  list-style: none;
  padding: 0;
  margin: 0;
}

.sidebar-menu-item {
  margin: 0.25rem 0;
  position: relative;
}

.sidebar-link {
  display: flex;
  justify-content: space-between;
  align-items: center;
  color: #4a5568;
  font-size: 0.92em;
  padding: 0.6rem 1rem;
  border-radius: 6px;
  text-decoration: none;
  transition: all 0.2s ease;
  background: transparent;
}

.sidebar-link:hover {
  color: #2c3e50;
  background: rgba(66, 185, 131, 0.1);
  transform: translateX(3px);
}

.sidebar-link.router-link-active {
  color: #42b983;
  font-weight: 500;
  background: rgba(66, 185, 131, 0.1);
  box-shadow: inset 3px 0 0 #42b983;
}

.link-text {
  flex: 1;
}

.link-arrow {
  opacity: 0;
  transform: translateX(-5px);
  transition: all 0.2s ease;
  color: #42b983;
}

.sidebar-link:hover .link-arrow {
  opacity: 1;
  transform: translateX(0);
}

.sidebar-link.router-link-active .link-arrow {
  opacity: 1;
  transform: translateX(0);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .sidebar {
    width: 240px;
    transform: translateX(-100%);
    padding: 1rem 0;
    background: white;
    z-index: 100;
    transition: transform 0.3s ease;
    box-shadow: 2px 0 15px rgba(0, 0, 0, 0.1);
  }

  .sidebar.active {
    transform: translateX(0);
  }

  .sidebar-nav {
    padding: 0 1rem;
  }
}
</style>
