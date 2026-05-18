<template>
  <div class="Logo_name">
    <img src="../../static/img/1234.png" alt="云声知处" class="Logoname" />
  </div>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'LogoName', // 声明组件名称
})
</script>

<style scoped>
/* Logo的尺寸。（经过WPS会员抠图） */
.Logo_name {
  width: 100%;
  margin-top: 10vh;
  user-select: none; /* 禁止文本选择 */
}

/* 让Logo照片居中 */
.Logo_name .Logoname {
  display: block;
  margin: auto;
  width: 70%;
}
</style>
