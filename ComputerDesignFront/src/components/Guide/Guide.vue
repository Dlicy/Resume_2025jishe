<template>
  <div class="guide-layout">
    <GuideNav />
    <div class="main-content">
      <router-view />
    </div>
  </div>
</template>

<script setup lang="ts">
import GuideNav from '@/components/Guide/GuideNav.vue'
</script>

<style scoped>
.guide-layout {
  display: flex;
  min-height: 100vh;
}

.main-content {
  flex: 1;
  padding: 20px;
  margin-left: 280px; /* 与侧边栏宽度一致 */
}

@media (max-width: 768px) {
  .main-content {
    margin-left: 0;
    padding: 15px;
  }
}
</style>