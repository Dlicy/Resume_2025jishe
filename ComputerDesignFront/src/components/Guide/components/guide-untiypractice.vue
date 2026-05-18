<template>
    <div class="acupoint-model-intro">
      <!-- 顶部标题区 -->
      <div class="hero-section">
        <h1 class="title">
          <el-icon><FirstAidKit /></el-icon>
          虚拟穴位模拟诊断
        </h1>
        <p class="subtitle">基于中医辨证论治的智能化诊断训练系统</p>
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
          诊断流程指南
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
  import { useRouter } from 'vue-router'
  import {
    FirstAidKit,
    Notebook,
    ArrowLeft,
    ArrowRight,
    User,
    Search,
    Connection,
    List,
    Monitor,
    Comment,
    SetUp
  } from '@element-plus/icons-vue'
  
  const router = useRouter()
  
  const features = [
    {
      icon: User,
      title: '智能病例系统',
      description: '50+典型病例库，涵盖内、外、妇、儿各科常见证型'
    },
    {
      icon: Search,
      title: '四诊合参训练',
      description: '完整模拟望闻问切诊断全流程'
    },
    {
      icon: Connection,
      title: '经络可视化',
      description: '动态展示十四经脉走向和穴位关系'
    },
    {
      icon: List,
      title: '辨证分析',
      description: '智能辅助八纲辨证、脏腑辨证等分析方法'
    },
    {
      icon: Monitor,
      title: '实时反馈',
      description: '即时指出辨证要点和常见错误'
    },
    {
      icon: Comment,
      title: '经典对照',
      description: '自动关联《黄帝内经》等经典治疗方案'
    }
  ]
  
  const learningSteps = [
    {
      title: '病例分析',
      description: '通过主诉和病史收集诊断信息'
    },
    {
      title: '穴位探查',
      description: '在3D模型上定位相关穴位并检查体征'
    },
    {
      title: '辨证施治',
      description: '确定证型并生成个性化治疗方案'
    }
  ]
  
  const goToPrevious = () => {
      router.push('/guide/untiy')
  }
  
  const goToNext = () => {
      router.push('/guide/library')
  }
  </script>
  
  <style scoped lang="scss">
  .acupoint-model-intro {
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