<template>
  <div class="bili-video-card">
    <div class="bili-video-card__wrap">
      <a class="bili-video-card__image--link" :href="video.link" target="_blank">
        <div class="bili-video-card__image bili-video-card__image--hover">
          <div class="bili-video-card__image--wrap">
            <picture class="v-img bili-video-card__cover">
              <img :src="video.cover" :alt="video.title" loading="lazy" />
            </picture>
          </div>
          <div class="bili-video-card__mask">
            <div class="bili-video-card__stats">
              <div class="bili-video-card__stats--left">
                <span class="bili-video-card__stats--item">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    width="16"
                    height="16"
                    fill="#ffffff"
                  >
                    <path
                      d="M12 5V1L7 6l5 5V7c3.31 0 6 2.69 6 6s-2.69 6-6 6-6-2.69-6-6H4c0 4.42 3.58 8 8 8s8-3.58 8-8-3.58-8-8-8z"
                    ></path>
                  </svg>
                  <span class="bili-video-card__stats--text">{{ video.views }}</span>
                </span>
                <span class="bili-video-card__stats--item">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    width="16"
                    height="16"
                    fill="#ffffff"
                  >
                    <path
                      d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm-1-13h2v6h-2zm0 8h2v2h-2z"
                    ></path>
                  </svg>
                  <span class="bili-video-card__stats--text">{{ video.comments }}</span>
                </span>
              </div>
              <span class="bili-video-card__stats__duration">{{ video.duration }}</span>
            </div>
          </div>
        </div>
      </a>

      <div class="bili-video-card__info">
        <div class="bili-video-card__info--right">
          <h3 class="bili-video-card__info--tit" :title="video.title">
            <a :href="video.link" target="_blank">{{ video.title }}</a>
          </h3>
          <!-- <div class="bili-video-card__info--bottom">
            <a
              class="bili-video-card__info--owner"
              :href="'//space.bilibili.com/' + video.authorId"
              target="_blank"
            >
              <img
                class="bili-video-card__info--avatar"
                :src="video.authorAvatar"
                :alt="video.author"
              />
              <span class="bili-video-card__info--author">{{ video.author }}</span>
              <span v-if="video.likes" class="bili-video-card__info--icon-text"
                >{{ video.likes }}点赞</span
              >
            </a>
          </div> -->
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    video: {
      type: Object,
      required: true,
    },
  },
}
</script>

<style scoped>
.bili-video-card {
  position: relative;
  background-color: #fff;
  border-radius: 8px;
  overflow: hidden;
  transition:
    transform 0.2s,
    box-shadow 0.2s;
}

.bili-video-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
}

.bili-video-card__wrap {
  display: flex;
  flex-direction: column;
  height: 100%;
}

.bili-video-card__image {
  position: relative;
  width: 100%;
  padding-top: 56.25%; /* 16:9 宽高比 */
  overflow: hidden;
  border-radius: 8px 8px 0 0;
}

.bili-video-card__image--wrap {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

.bili-video-card__cover {
  width: 100%;
  height: 100%;
}

.bili-video-card__cover img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.bili-video-card__mask {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 30%;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.7), transparent);
}

.bili-video-card__stats {
  position: absolute;
  bottom: 8px;
  left: 8px;
  right: 8px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  color: white;
  font-size: 12px;
}

.bili-video-card__stats--left {
  display: flex;
  align-items: center;
}

.bili-video-card__stats--item {
  display: flex;
  align-items: center;
  margin-right: 12px;
}

.bili-video-card__stats--item svg {
  margin-right: 4px;
}

.bili-video-card__stats__duration {
  font-size: 12px;
}

.bili-video-card__info {
  flex: 1;
  padding: 12px;
}

.bili-video-card__info--right {
  display: flex;
  flex-direction: column;
  height: 100%;
}

.bili-video-card__info--tit {
  margin: 0 0 8px 0;
  font-size: 14px;
  font-weight: 500;
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}

.bili-video-card__info--tit a {
  color: #18191c;
  text-decoration: none;
}

.bili-video-card__info--bottom {
  margin-top: auto;
  display: flex;
  align-items: center;
  font-size: 12px;
  color: #9499a0;
}

.bili-video-card__info--owner {
  display: flex;
  align-items: center;
  text-decoration: none;
  color: inherit;
}

.bili-video-card__info--avatar {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  margin-right: 6px;
}

.bili-video-card__info--author {
  margin-right: 8px;
  max-width: 100px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.bili-video-card__info--icon-text {
  color: #fb7299;
  margin-right: 8px;
}
</style>
