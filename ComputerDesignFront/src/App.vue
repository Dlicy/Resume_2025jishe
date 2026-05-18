<template>
  <router-view />
</template>

<script setup lang="ts">
import Home from './components/Home.vue'
import { useRoute } from 'vue-router'
</script>

<style>
body {
  background-color: rgb(248, 250, 250);
}
</style>
