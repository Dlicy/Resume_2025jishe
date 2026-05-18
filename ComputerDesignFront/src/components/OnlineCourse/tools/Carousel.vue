<template>
  <div v-if="validItems.length > 0" class="recommended-swipe">
    <div class="carousel">
      <div class="carousel-container">
        <div class="vui_carousel vui_carousel--bottom vui_carousel--show-arrow">
          <div class="vui_carousel__slides" :style="{ transform: `translateX(${translateX}%)` }">
            <div v-for="(item, index) in validItems" :key="index" class="vui_carousel__slide">
              <div class="carousel-area">
                <div class="carousel-area-img">
                  <a class="carousel-item" :href="item.link" target="_blank">
                    <picture class="v-img carousel-inner__img">
                      <img :src="item.image" :alt="item.title" loading="eager" />
                    </picture>
                  </a>
                </div>
              </div>
            </div>
          </div>

          <div class="carousel-footer">
            <div class="carousel-footer-mask"></div>
            <div class="carousel-footer-text">
              <div class="carousel-footer-title">
                <a v-if="currentItem" :href="currentItem.link" target="_blank">{{
                  currentItem.title
                }}</a>
              </div>
            </div>
            <div class="carousel-dots">
              <ul class="carousel-dots-list">
                <li
                  v-for="(item, index) in validItems"
                  :key="index"
                  :class="['carousel-dots-dot', { 'is-active': currentIndex === index }]"
                  @click="goToSlide(index)"
                >
                  <div class="before"></div>
                  <div class="after"></div>
                </li>
              </ul>
            </div>
          </div>

          <div class="carousel-arrows">
            <button @click="prevSlide">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                <path
                  d="M15.41 16.59L10.83 12l4.58-4.59L14 6l-6 6 6 6 1.41-1.41z"
                  fill="currentColor"
                ></path>
              </svg>
            </button>
            <button @click="nextSlide">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                <path
                  d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6-1.41-1.41z"
                  fill="currentColor"
                ></path>
              </svg>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 空状态显示 -->
  <div v-else class="empty-carousel">
    <div class="empty-content">
      <svg viewBox="0 0 24 24" class="empty-icon">
        <path
          d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 15H9V7h2v10zm4 0h-2V7h2v10z"
          fill="#999"
        />
      </svg>
      <p class="empty-text">暂无推荐内容</p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Carousel',
  props: {
    items: {
      type: Array,
      default: () => [],
      validator: (value) => {
        return (
          Array.isArray(value) &&
          value.every((item) => {
            return !item || (item.link && item.image && item.title)
          })
        )
      },
    },
  },
  data() {
    return {
      currentIndex: 0,
      translateX: 0,
      interval: null,
    }
  },
  computed: {
    validItems() {
      return this.items.filter((item) => item && item.link && item.image && item.title)
    },
    currentItem() {
      return this.validItems[this.currentIndex] || null
    },
  },
  watch: {
    items: {
      handler(newVal) {
        if (newVal.length > 0 && this.currentIndex >= newVal.length) {
          this.currentIndex = 0
          this.translateX = 0
        }
      },
      immediate: true,
    },
  },
  mounted() {
    this.startAutoPlay()
  },
  beforeUnmount() {
    this.stopAutoPlay()
  },
  methods: {
    startAutoPlay() {
      if (this.validItems.length > 1) {
        this.interval = setInterval(this.nextSlide, 5000)
      }
    },
    stopAutoPlay() {
      if (this.interval) {
        clearInterval(this.interval)
        this.interval = null
      }
    },
    goToSlide(index) {
      if (index >= 0 && index < this.validItems.length) {
        this.currentIndex = index
        this.translateX = -index * 100
        this.stopAutoPlay()
        this.startAutoPlay()
      }
    },
    prevSlide() {
      const newIndex = (this.currentIndex - 1 + this.validItems.length) % this.validItems.length
      this.goToSlide(newIndex)
    },
    nextSlide() {
      const newIndex = (this.currentIndex + 1) % this.validItems.length
      this.goToSlide(newIndex)
    },
  },
}
</script>

<style scoped>
.recommended-swipe {
  position: relative;
  width: 100%;
  margin-bottom: 20px;
  border-radius: 8px;
  overflow: hidden;
}

.carousel {
  position: relative;
  width: 100%;
  height: 0;
  padding-bottom: 25%; /* 4:1 宽高比 */
}

.carousel-container {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

.vui_carousel {
  position: relative;
  width: 100%;
  height: 100%;
  overflow: hidden;
}

.vui_carousel__slides {
  display: flex;
  width: 100%;
  height: 100%;
  transition: transform 0.3s ease;
}

.vui_carousel__slide {
  flex: 0 0 100%;
  height: 100%;
}

.carousel-area {
  width: 100%;
  height: 100%;
}

.carousel-area-img {
  width: 100%;
  height: 100%;
}

.carousel-item {
  display: block;
  width: 100%;
  height: 100%;
}

.carousel-inner__img {
  width: 100%;
  height: 100%;
}

.carousel-inner__img img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.carousel-footer {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 60px;
  z-index: 2;
}

.carousel-footer-mask {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.7), transparent);
}

.carousel-footer-text {
  position: relative;
  height: 100%;
  display: flex;
  align-items: center;
  padding: 0 20px;
}

.carousel-footer-title {
  flex: 1;
}

.carousel-footer-title a {
  color: white;
  font-size: 16px;
  font-weight: 500;
  text-decoration: none;
}

.carousel-dots {
  position: absolute;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
}

.carousel-dots-list {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
}

.carousel-dots-dot {
  width: 24px;
  height: 4px;
  margin: 0 4px;
  background-color: rgba(255, 255, 255, 0.3);
  border-radius: 2px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.carousel-dots-dot.is-active {
  background-color: rgba(255, 255, 255, 0.6);
}

.carousel-dots-dot .before,
.carousel-dots-dot .after {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: #fb7299;
  transform: translateX(-100%);
}

.carousel-dots-dot.is-active .after {
  animation: progress 5s linear forwards;
}

@keyframes progress {
  0% {
    transform: translateX(-100%);
  }
  100% {
    transform: translateX(0);
  }
}

.carousel-arrows {
  position: absolute;
  top: 50%;
  left: 0;
  width: 100%;
  display: flex;
  justify-content: space-between;
  transform: translateY(-50%);
  padding: 0 20px;
  z-index: 3;
}

.carousel-arrows button {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: rgba(0, 0, 0, 0.3);
  border: none;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: background-color 0.2s;
}

.carousel-arrows button:hover {
  background-color: rgba(0, 0, 0, 0.5);
}

.carousel-arrows button svg {
  width: 24px;
  height: 24px;
}

/* 空状态样式 */
.empty-carousel {
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f5f5f5;
  border-radius: 8px;
  margin-bottom: 20px;
}

.empty-content {
  text-align: center;
}

.empty-icon {
  width: 48px;
  height: 48px;
  margin-bottom: 12px;
}

.empty-text {
  color: #999;
  font-size: 14px;
}
</style>
