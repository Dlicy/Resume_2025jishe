<template>
    <div class="bili-video-feed">
      <div class="feed-header">
        <h2 class="feed-title">热门视频推荐</h2>
        <div class="feed-tabs">
          <div class="tab-item active">推荐</div>
          <div class="tab-item">直播</div>
          <div class="tab-item">动画</div>
          <div class="tab-item">知识</div>
        </div>
      </div>
      
      <div class="feed-container">
        <div class="feed-card" v-for="(video, index) in videos" :key="video.id">
          <div class="bili-video-card">
            <a class="video-link" :href="video.url" target="_blank">
              <div class="video-cover">
                <img :src="video.pic" :alt="video.title" class="cover-image">
                <div class="video-stats">
                  <span class="stat-item">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="#fff">
                      <path d="M12 5C5.648 5 1 12 1 12C1 12 5.648 19 12 19C18.352 19 23 12 23 12C23 12 18.352 5 12 5Z"></path>
                      <path d="M12 15C10.343 15 9 13.657 9 12C9 10.343 10.343 9 12 9C13.657 9 15 10.343 15 12C15 13.657 13.657 15 12 15Z"></path>
                    </svg>
                    {{ formatNumber(video.view) }}
                  </span>
                  <span class="stat-item">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="#fff">
                      <path d="M22.01 4.05L20.6 3.4L12 14L3.4 3.4L2 4.05L12 21.7L22.01 4.05Z"></path>
                    </svg>
                    {{ formatNumber(video.danmaku) }}
                  </span>
                  <span class="video-duration">{{ video.duration }}</span>
                </div>
              </div>
            </a>
            
            <div class="video-info">
              <h3 class="video-title">
                <a :href="video.url" target="_blank">{{ video.title }}</a>
              </h3>
              
              <div class="up-info">
                <a class="up-name" :href="`//space.bilibili.com/${video.owner.mid}`" target="_blank">
                  {{ video.owner.name }}
                </a>
              </div>
              
              <div class="video-bottom">
                <span class="video-date">{{ formatDate(video.pubdate) }}</span>
                <span v-if="video.like > 10000" class="video-likes">
                  {{ formatNumber(video.like / 10000) }}万点赞
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref } from 'vue'
  
  interface VideoOwner {
    mid: number
    name: string
    face: string
  }
  
  interface VideoItem {
    id: number
    bvid: string
    title: string
    pic: string
    duration: string
    pubdate: number
    view: number
    danmaku: number
    like: number
    url: string
    owner: VideoOwner
  }
  
  const videos = ref<VideoItem[]>([
    {
      id: 114235929526411,
      bvid: 'BV1SoZ5YVEJg',
      title: '"请问，你有多久没有10点前睡觉了？"',
      pic: '//i0.hdslb.com/bfs/archive/157d1fc1ec2402accc71a41e3e0d4be361024da1.jpg',
      duration: '01:42',
      pubdate: 1743135000,
      view: 1061553,
      danmaku: 1483,
      like: 104826,
      url: 'https://www.bilibili.com/video/BV1SoZ5YVEJg',
      owner: {
        mid: 30502823,
        name: '学姐圆',
        face: '//i2.hdslb.com/bfs/face/2e0e47571d612323fdd1991a01d5e4fefa4dd8ad.webp'
      }
    },
    {
      id: 114195077009406,
      bvid: 'BV1MQXeYDEAU',
      title: '你还在傻傻的手写css？',
      pic: '//i2.hdslb.com/bfs/archive/dc3a3a92b64b70e68b64deb5613b860f3be22456.jpg',
      duration: '01:26',
      pubdate: 1742478925,
      view: 14994,
      danmaku: 0,
      like: 1357,
      url: 'https://www.bilibili.com/video/BV1MQXeYDEAU',
      owner: {
        mid: 207704732,
        name: '程序员三千',
        face: '//i2.hdslb.com/bfs/face/a54db42f3518592aeafd2904cbc8dd301f484e22.jpg'
      }
    },
    {
      id: 114154241268151,
      bvid: 'BV1XrQAYAEGS',
      title: '不好意思，5799的M4 MacBook Air就是无敌',
      pic: '//i0.hdslb.com/bfs/archive/71136c5d2f3a0bec97822f7545a95925a3f45cae.jpg',
      duration: '05:48',
      pubdate: 1741856186,
      view: 527058,
      danmaku: 715,
      like: 6651,
      url: 'https://www.bilibili.com/video/BV1XrQAYAEGS',
      owner: {
        mid: 39984773,
        name: 'GLAT巩振宁',
        face: '//i2.hdslb.com/bfs/face/d45a2a7747c5a3a0cb7d78302245c0ae4df75995.jpg'
      }
    },
    {
      id: 114246750902054,
      bvid: 'BV1EgZaYzEoL',
      title: '"小作坊就得猛猛下料啊！"',
      pic: '//i1.hdslb.com/bfs/archive/e6470a691d3ec6d65c8e581e69ce714d8a7ee10e.jpg',
      duration: '02:13',
      pubdate: 1743300000,
      view: 689794,
      danmaku: 1917,
      like: 63121,
      url: 'https://www.bilibili.com/video/BV1EgZaYzEoL',
      owner: {
        mid: 13689353,
        name: '久远丶酱',
        face: '//i2.hdslb.com/bfs/face/64f87a3f7d56bb909d94c04b305764a00c0c311b.jpg'
      }
    },
    {
      id: 113947512406586,
      bvid: 'BV1APPzeEENA',
      title: '《sleepwalker (sped up)》循环版|"肾上腺素:这把高端局"|',
      pic: '//i1.hdslb.com/bfs/archive/0f41635c8ac9666d077101ffc725fbeccb5a4c0d.jpg',
      duration: '40:54',
      pubdate: 1738713814,
      view: 1296146,
      danmaku: 93,
      like: 27781,
      url: 'https://www.bilibili.com/video/BV1APPzeEENA',
      owner: {
        mid: 319451704,
        name: '绪笔梦生花',
        face: '//i1.hdslb.com/bfs/face/4f1cd62b9972fc4b0aeeff6d5aa95258704f35c5.jpg'
      }
    }
  ])
  
  const formatNumber = (num: number): string => {
    if (num >= 10000) {
      return (num / 10000).toFixed(1) + '万'
    }
    return num.toString()
  }
  
  const formatDate = (timestamp: number): string => {
    const date = new Date(timestamp * 1000)
    const now = new Date()
    const diffDays = Math.floor((now.getTime() - date.getTime()) / (1000 * 60 * 60 * 24))
    
    if (diffDays === 0) return '今天'
    if (diffDays === 1) return '昨天'
    if (diffDays < 7) return `${diffDays}天前`
    
    const month = date.getMonth() + 1
    const day = date.getDate()
    return `${month}-${day}`
  }
  </script>
  
  <style scoped>
  .bili-video-feed {
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px 0;
    font-family: -apple-system, BlinkMacSystemFont, "Helvetica Neue", "PingFang SC", "Microsoft YaHei", "Source Han Sans SC", "Noto Sans CJK SC", "WenQuanYi Micro Hei", sans-serif;
  }
  
  .feed-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 20px;
  }
  
  .feed-title {
    font-size: 22px;
    font-weight: 500;
    color: #212121;
    margin: 0;
  }
  
  .feed-tabs {
    display: flex;
    gap: 20px;
  }
  
  .tab-item {
    font-size: 14px;
    color: #666;
    cursor: pointer;
    padding: 4px 0;
    position: relative;
  }
  
  .tab-item.active {
    color: #00aeec;
    font-weight: 500;
  }
  
  .tab-item.active::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 2px;
    background-color: #00aeec;
  }
  
  .feed-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
    gap: 20px;
  }
  
  .feed-card {
    transition: transform 0.2s;
  }
  
  .feed-card:hover {
    transform: translateY(-5px);
  }
  
  .bili-video-card {
    width: 100%;
    border-radius: 6px;
    overflow: hidden;
    background: #fff;
  }
  
  .video-link {
    display: block;
    position: relative;
    width: 100%;
    padding-top: 56.25%; /* 16:9 aspect ratio */
  }
  
  .video-cover {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
  }
  
  .cover-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 6px;
  }
  
  .video-stats {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 8px;
    background: linear-gradient(transparent, rgba(0, 0, 0, 0.5));
    color: #fff;
    font-size: 12px;
    display: flex;
    align-items: center;
    border-bottom-left-radius: 6px;
    border-bottom-right-radius: 6px;
  }
  
  .stat-item {
    display: flex;
    align-items: center;
    margin-right: 12px;
  }
  
  .stat-item svg {
    margin-right: 4px;
  }
  
  .video-duration {
    margin-left: auto;
  }
  
  .video-info {
    padding: 10px 5px;
  }
  
  .video-title {
    margin: 0;
    font-size: 14px;
    font-weight: 500;
    line-height: 1.5;
    color: #212121;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    height: 42px;
  }
  
  .video-title a {
    color: inherit;
    text-decoration: none;
  }
  
  .video-title a:hover {
    color: #00aeec;
  }
  
  .up-info {
    margin-top: 8px;
    display: flex;
    align-items: center;
  }
  
  .up-name {
    font-size: 12px;
    color: #666;
    text-decoration: none;
  }
  
  .up-name:hover {
    color: #00aeec;
  }
  
  .video-bottom {
    margin-top: 8px;
    display: flex;
    justify-content: space-between;
    font-size: 12px;
    color: #999;
  }
  
  .video-likes {
    color: #fb7299;
  }
  
  @media (max-width: 768px) {
    .feed-container {
      grid-template-columns: repeat(2, 1fr);
    }
    
    .feed-header {
      flex-direction: column;
      align-items: flex-start;
      gap: 10px;
    }
    
    .feed-tabs {
      width: 100%;
      overflow-x: auto;
      padding-bottom: 5px;
    }
  }
  
  @media (max-width: 480px) {
    .feed-container {
      grid-template-columns: 1fr;
    }
  }
  </style>