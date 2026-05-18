<template>
    <div class="project-intro">
      <!-- 项目标题区 -->
      <div class="hero-section">
        <h1 class="title">
          <el-icon><Reading /></el-icon>
          中医穴位学习系统
        </h1>
        <p class="subtitle">基于Web3D技术的交互式中医教学平台</p>
      </div>
  
      <!-- 项目概述 -->
      <div class="overview-section">
        <h2 class="section-title">
          <el-icon><InfoFilled /></el-icon>
          项目概述
        </h2>
        <el-card shadow="never" class="overview-card">
          <p>本项目是一款融合现代Web3D技术与传统中医理论的教学系统，通过高精度人体模型实现穴位可视化学习，提供交互式探索、智能标注、学习测评等功能，助力中医教学数字化改革。</p>
        </el-card>
      </div>
  
      <!-- 核心功能 -->
      <div class="features-section">
        <h2 class="section-title">
          <el-icon><Star /></el-icon>
          核心功能
        </h2>
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
  
      <!-- 技术架构 -->
      <div class="tech-section">
        <h2 class="section-title">
          <el-icon><Cpu /></el-icon>
          技术架构
        </h2>
        <el-steps direction="vertical" :active="techStack.length">
          <el-step 
            v-for="(tech, index) in techStack" 
            :key="index"
            :title="tech.name"
            :description="tech.description"
          />
        </el-steps>
      </div>
  
      <!-- 导航按钮 -->
      <div class="action-buttons">
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
  import { computed } from 'vue'
  import { useRouter } from 'vue-router'
  import {
    Reading,
    InfoFilled,
    Star,
    Cpu,
    ArrowLeft,
    ArrowRight,
    Monitor,
    MagicStick,
    Connection,
    Collection,
    SetUp,
    DataBoard
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
  
  
  // 核心功能数据
  const features = [
    {
      icon: MagicStick,
      title: '3D穴位探索',
      description: '高精度人体模型，支持360°自由观察和分层解剖'
    },
    {
      icon: Connection,
      title: '智能标注',
      description: '悬停显示穴位详细信息，关联经典医案和现代研究'
    },
    {
      icon: Collection,
      title: '经络可视化',
      description: '动态展示十四经脉走向和穴位分布关系'
    },
    {
      icon: SetUp,
      title: '模拟诊疗',
      description: '虚拟病例练习，培养辨证施治能力'
    },
    {
      icon: DataBoard,
      title: '学习分析',
      description: '记录学习轨迹，生成个性化能力图谱'
    },
    {
      icon: Monitor,
      title: '多端适配',
      description: '支持PC、平板及VR设备无缝切换'
    }
  ]
  
  // 技术架构数据
  const techStack = [
    {
      name: '前端框架',
      description: 'Vue 3 + TypeScript + Element Plus构建响应式界面'
    },
    {
      name: '3D引擎',
      description: 'Unity WebGL实现高精度模型渲染和交互'
    },
    {
      name: '状态管理',
      description: 'Pinia实现跨组件状态共享'
    },
    {
      name: '后端服务',
      description: 'SpringBoot提供API接口和数据服务'
    },
    {
      name: '数据存储',
      description: 'Mysql存储用户数据和穴位知识库'
    }
  ]

  
  const goToNext = () => {
    if (hasNext.value) {
      router.push('/guide/untiy')
    }
  }
  </script>
  
  <style scoped lang="scss">
  .project-intro {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
    position: relative;
    min-height: calc(100vh - 100px);
    padding-bottom: 80px;
  
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
  
    .overview-section {
      margin: 3rem 0;
  
      .overview-card {
        line-height: 1.8;
        font-size: 1.05rem;
        color: #5a6a7a;
        border: none;
        background: rgba(250, 250, 252, 0.8);
      }
    }
  
    .features-section {
      margin: 3rem 0;
  
      .feature-card {
        height: 100%;
        text-align: center;
        transition: all 0.3s ease;
        margin-bottom: 20px;
        border: none;
  
        &:hover {
          transform: translateY(-5px);
          box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
  
        .feature-icon {
            color: #42b983; // 修改图标颜色
          margin-bottom: 1rem;
        }
  
        h3 {
          color: #2c3e50;
          margin-bottom: 0.8rem;
          font-size: 1.1rem;
        }
  
        p {
          color: #7f8c8d;
          font-size: 0.95rem;
          line-height: 1.6;
        }
      }
    }
  
    .tech-section {
      margin: 4rem 0;
  
      :deep(.el-step__title) {
        font-size: 1.1rem;
        font-weight: 500;
        color: #42b983
      }
  
      :deep(.el-step__description) {
        font-size: 0.95rem;
        color: #5a6a7a;
        padding-right: 20px;
      }
    }
  
    .section-title {
      display: flex;
      align-items: center;
      gap: 10px;
      border-left: 4px solid #42b983; // 修改标题边框色
      margin-bottom: 1.5rem;
      font-size: 1.5rem;
      border-left: 4px solid #3a8fb7;
      padding-left: 12px;
  
      .el-icon {
        color: #42b983; // 修改图标颜色
      }
    }
  
    .action-buttons {
      text-align: center;
      margin: 3rem 0;
  
      .el-button {
        padding: 1rem 2.5rem;
        font-size: 1.1rem;
        background-color: #42b983;
        border-color: #42b983;
        box-shadow: 0 4px 12px rgba(66, 185, 131, 0.3);
  
        &:hover {
          transform: translateY(-2px);
          background-color: #3aa876;
        box-shadow: 0 6px 16px rgba(66, 185, 131, 0.4);
        }
      }
    }
  }
  
  @media (max-width: 768px) {
    .project-intro {
      padding: 1rem;
      padding-bottom: 80px;
  
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
  
      .section-title {
        font-size: 1.3rem;
      }
    }
  }
  </style>