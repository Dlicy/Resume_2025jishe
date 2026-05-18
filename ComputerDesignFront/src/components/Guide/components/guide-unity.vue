<template>
    <div class="acupoint-model-intro">
      <!-- 顶部标题区 -->
      <div class="hero-section">
        <h1 class="title">
          <el-icon><MagicStick /></el-icon>
          三维穴位交互学习系统
        </h1>
        <p class="subtitle">基于Unity引擎打造的高精度中医穴位可视化教学平台</p>
      </div>
  
      <!-- 功能特性展示 -->
      <div class="features-section">
        <el-row :gutter="20">
          <el-col :xs="24" :sm="12" :md="8" v-for="(feature, index) in features" :key="index">
            <el-card shadow="hover" class="feature-card">
              <div class="feature-icon">
                <el-icon :size="36"><component :is="feature.icon" /></el-icon>
              </div>
              <h3>{{ feature.title }}</h3>
              <p>{{ feature.description }}</p>
            </el-card>
          </el-col>
        </el-row>
      </div>
  
      <!-- 学习指南 -->
      <div class="guide-section">
        <h2 class="section-title">
          <el-icon><Notebook /></el-icon>
          学习指南
        </h2>
        <el-steps direction="vertical" :active="3">
          <el-step 
            v-for="(step, index) in learningSteps" 
            :key="index" 
            :title="step.title" 
            :description="step.description" 
          />
        </el-steps>
      </div>
  
      <!-- 导航按钮 -->
      <div class="action-buttons">
        <el-button 
          type="info" 
          size="large" 
          @click="goToPrevious"
        >
          <el-icon><ArrowLeft /></el-icon>
          上一页
        </el-button>
        <el-button 
          type="primary" 
          size="large" 
          @click="goToNext"
        >
          下一页
          <el-icon><ArrowRight /></el-icon>
        </el-button>
      </div>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref, computed } from 'vue'
  import { useRouter } from 'vue-router'
  import {
    MagicStick,
    Notebook,
    View,
    Search,
    ScaleToOriginal,
    Position,
    Reading,
    Monitor,
    ArrowLeft,
    ArrowRight
  } from '@element-plus/icons-vue'
  
  const router = useRouter()
  
  // 定义页面导航顺序
  const pageSequence = [
    '/intro',          // 介绍页
    '/features',       // 功能页
    '/guide',          // 指南页
    '/acupoint-model'  // 3D模型页
  ]
  
  const currentRoute = router.currentRoute.value.path
  const currentIndex = computed(() => pageSequence.indexOf(currentRoute))
  
  const hasPrevious = computed(() => currentIndex.value > 0)
  const hasNext = computed(() => currentIndex.value < pageSequence.length - 1)
  
  const goToPrevious = () => {
    if (hasPrevious.value) {
      router.push('/guide/introduction')
    }
  }
  
  const goToNext = () => {
    if (hasNext.value) {
      router.push('/guide/untiypractice')
    }
  }
  
  const features = ref([
    {
      icon: View,
      title: '360°自由观察',
      description: '支持任意角度旋转、缩放查看穴位细节'
    },
    {
      icon: Search,
      title: '精准定位',
      description: '毫米级精度还原人体标准穴位位置'
    },
    {
      icon: ScaleToOriginal,
      title: '分层解剖',
      description: '皮肤、肌肉、骨骼等多层次可视化切换'
    },
    {
      icon: Position,
      title: '智能标注',
      description: '悬停显示穴位名称、功效和针刺方法'
    },
    {
      icon: Reading,
      title: '知识库集成',
      description: '关联经典医籍和现代研究资料'
    },
    {
      icon: Monitor,
      title: '多端适配',
      description: '支持PC、平板及VR设备访问'
    }
  ])
  
  const learningSteps = ref([
    {
      title: '基础导航',
      description: '使用鼠标拖动旋转模型，滚轮缩放，右键平移'
    },
    {
      title: '穴位探索',
      description: '点击穴位点查看详细信息，包括定位、主治和操作指南'
    },
    {
      title: '学习模式',
      description: '开启测验功能，测试穴位定位记忆效果'
    }
  ])
  </script>
  
  <style scoped lang="scss">
  .acupoint-model-intro {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
    position: relative;
    min-height: calc(100vh - 100px);
    padding-bottom: 80px; /* 为导航按钮留出空间 */
  
    .hero-section {
      text-align: center;
      margin-bottom: 3rem;
      padding: 2rem 0;
      background: linear-gradient(135deg, rgba(66, 185, 131, 0.1) 0%, rgba(255, 255, 255, 0) 100%);
      border-radius: 16px;
  
      .title {
        font-size: 2.2rem;
        color: #2c3e50;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 12px;
        margin-bottom: 1rem;
      }
  
      .subtitle {
        font-size: 1.2rem;
        color: #7f8c8d;
        margin: 0;
      }
    }
  
    .features-section {
      margin: 3rem 0;
  
      .feature-card {
        height: 100%;
        text-align: center;
        transition: transform 0.3s ease;
        margin-bottom: 20px;
        border: none;
  
        &:hover {
          transform: translateY(-5px);
          box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
  
        .feature-icon {
          color: #42b983;
          margin-bottom: 1rem;
        }
  
        h3 {
          color: #2c3e50;
          margin-bottom: 0.8rem;
        }
  
        p {
          color: #7f8c8d;
          font-size: 0.95rem;
        }
      }
    }
  
    .guide-section {
      margin: 4rem 0;
  
      :deep(.el-step__title) {
        font-size: 1.1rem;
        font-weight: 500;
      }
    }
  
    .section-title {
      display: flex;
      align-items: center;
      gap: 10px;
      color: #2c3e50;
      margin-bottom: 1.5rem;
      font-size: 1.5rem;
  
      .el-icon {
        color: #42b983;
      }
    }
  
    .action-buttons {
      text-align: center;
      margin: 3rem 0;
  
      .el-button {
        padding: 1rem 2.5rem;
        font-size: 1.1rem;
        background: linear-gradient(135deg, #42b983, #2e856e);
        border: none;
        box-shadow: 0 4px 12px rgba(66, 185, 131, 0.3);
  
        &:hover {
          transform: translateY(-2px);
          box-shadow: 0 6px 16px rgba(66, 185, 131, 0.4);
        }
      }
    }
  }
  
  @media (max-width: 768px) {
    .acupoint-model-intro {
      padding: 1rem;
      padding-bottom: 70px;
  
      .hero-section {
        padding: 1.5rem 0;
  
        .title {
          font-size: 1.8rem;
        }
      }
  
      .navigation-buttons {
        bottom: 10px;
        right: 10px;
        left: 10px;
        justify-content: space-between;
      }
    }
  }
  </style>