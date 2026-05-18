<template>
  <div class="manager-container">
    <ManagerNav />
    <div class="content">
      <router-view />
    </div>
  </div>
</template>

<script setup lang="ts">
import ManagerNav from './ManagerNav.vue'
</script>

<style scoped>
.manager-container {
  display: flex;
  min-height: 100vh;
}

.content {
  flex: 1;
  padding: 0;
}
</style>
