<template>
    <div class="container">
      <!-- 侧边栏导航 -->
      <div class="sidebar">
        <h2>管理中心</h2>
        <ul>
          <li>
            <a href="#" @click.prevent="setActiveComponent('manager_user')" 
               :class="{ active: activeComponent === 'manager_user' }">
               用户管理
            </a>
          </li>
          <li>
            <a href="#" @click.prevent="setActiveComponent('manager_book')"
               :class="{ active: activeComponent === 'manager_book' }">
               书籍管理
            </a>
          </li>
          <li>
            <a href="#" @click.prevent="setActiveComponent('manager_encyclopedia')"
               :class="{ active: activeComponent === 'manager_encyclopedia' }">
               药物百科管理
            </a>
          </li>
        </ul>
      </div>
  
      <!-- 动态内容区域 -->
      <div class="content">
        <component :is="activeComponent" />
      </div>
    </div>
  </template>
  
  <script setup lang="ts">
    import { ref, shallowRef } from 'vue';
    import manager_book from './manager_book.vue';
    import manager_user from './manager_user.vue';
    import manager_encyclopedia from './manager_encyclopedia.vue';  

    // 当前激活的组件
    const activeComponent = shallowRef(manager_book);
    
    // 组件映射
    const components = {
      manager_book,
      manager_user,
      manager_encyclopedia
    };
    
    // 设置当前显示的组件
    const setActiveComponent = (componentName: keyof typeof components) => {
      activeComponent.value = components[componentName];
    };
  </script>
  
  <style scoped>
  .container {
    display: flex;
    min-height: 100vh;
  }
  
  .sidebar {
    top: 0;
    left: 0;
    width: 200px;
    background-color: #2c3e50;
    padding: 20px;
  }
  
  .sidebar h2 {
    color: white;
    margin-bottom: 20px;
  }
  
  .sidebar ul {
    list-style: none;
    padding: 0;
  }
  
  .sidebar li {
    margin-bottom: 15px;
  }
  
  .sidebar a {
    color: white;
    text-decoration: none;
    display: block;
    padding: 5px;
  }
  
  .sidebar a:hover {
    background-color: #34495e;
  }
  
  .sidebar a.active {
    background-color: #42b983;
    border-radius: 4px;
  }
  
  .content {
    flex: 1;
    padding: 20px;
  }
  </style>