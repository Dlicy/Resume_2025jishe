<template>
  <Nav />
  <router-view />
</template>

<script setup lang="ts">
import Nav from './Nav.vue'
import CreateCourse from './Manager/Vedio/CreateCourse.vue'
import UploadVideo from './Manager/Vedio/UploadVideo.vue'
import index from './Practice/PractiveIndex.vue'
import EditVideo from './Manager/Vedio/EditVideo.vue'
import EditCourse from './Manager/Vedio/EditCourse.vue'

import { useRoute } from 'vue-router'
</script>

<style>
body {
  background-color: rgb(248, 250, 250);
}

* {
  margin: 0;
  padding: 0;
}
</style>
