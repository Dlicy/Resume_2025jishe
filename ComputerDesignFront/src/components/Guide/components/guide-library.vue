<template>
    <div class="acupoint-model-intro">
      <!-- 顶部标题区 -->
      <div class="hero-section">
        <h1 class="title">
          <el-icon><Notebook /></el-icon>
          中医数字书库
        </h1>
        <p class="subtitle">传统智慧与现代技术的完美融合</p>
      </div>
  
      <!-- 特色功能 -->
      <div class="features-section">
        <h2 class="section-title">
          <el-icon><Star /></el-icon>
          核心特色功能
        </h2>
        <el-row :gutter="20">
          <el-col :xs="24" :sm="12" :md="8" v-for="(feature, index) in features" :key="index">
            <el-card shadow="hover" class="feature-card">
              <div class="feature-icon">
                <el-icon :size="36"><component :is="feature.icon" /></el-icon>
              </div>
              <h3>{{ feature.title }}</h3>
              <p>{{ feature.description }}</p>
              <el-tag type="success" effect="plain" class="feature-tag">
                {{ feature.tag }}
              </el-tag>
            </el-card>
          </el-col>
        </el-row>
      </div>
  
      <!-- 学习流程 -->
      <div class="guide-section">
        <h2 class="section-title">
          <el-icon><TrendCharts /></el-icon>
          推荐学习路径
        </h2>
        <el-steps direction="vertical" :active="4" finish-status="success">
          <el-step 
            v-for="(step, index) in learningPath" 
            :key="index"
            :title="step.title" 
            :description="step.description"
            :icon="step.icon"
          />
        </el-steps>
      </div>
  
      <!-- 操作按钮 -->
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
    Notebook,
    Star,
    Reading,
    TrendCharts,
    Collection,
    MagicStick,
    Link,
    Histogram,
    ReadingLamp,
    Connection,
    DocumentChecked,
    VideoPlay,
    DataAnalysis
  } from '@element-plus/icons-vue'
  
  const router = useRouter()
  
  // 特色功能数据
  const features = [
    {
      icon: Collection,
      title: '典籍全文检索',
      description: '支持60+部经典医籍的智能检索，快速定位原文内容',
      tag: '高效查阅'
    },
    {
      icon: MagicStick,
      title: '知识图谱',
      description: '病症-中药-方剂三维关联，可视化呈现中医知识网络',
      tag: '智能关联'
    },
    {
      icon: Link,
      title: '跨文献对照',
      description: '不同典籍对同一理论的论述对比，把握学术源流',
      tag: '比较研究'
    },
    {
      icon: Histogram,
      title: '数据可视化',
      description: '中药功效分布、方剂组成比例的图形化分析',
      tag: '直观呈现'
    },
    {
      icon: ReadingLamp,
      title: '学习笔记',
      description: '支持添加个人批注，形成结构化学习笔记',
      tag: '知识沉淀'
    },
    {
      icon: Connection,
      title: '多端同步',
      description: '电脑、平板、手机数据实时同步，随时随地学习',
      tag: '移动学习'
    }
  ]
  
  // 学习路径数据
  const learningPath = [
    {
      title: '基础奠基',
      description: '精读《黄帝内经》《伤寒论》等核心典籍',
      icon: DocumentChecked
    },
    {
      title: '专题拓展',
      description: '按病症/中药/方剂专题进行系统学习',
      icon: VideoPlay
    },
    {
      title: '对比研究',
      description: '比较不同学派对同一问题的论述差异',
      icon: DataAnalysis
    },
    {
      title: '临床结合',
      description: '将理论知识与临床案例相结合',
      icon: Connection
    }
  ]
  
  const goToPrevious = () => {
      router.push('/guide/untiypractice')
  }
  
  const goToNext = () => {
      router.push('/guide/onlinecourse')
  }
  </script>
  
  <style scoped lang="scss">
  .acupoint-model-intro {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
  
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
        transition: all 0.3s ease;
        margin-bottom: 20px;
        border: none;
        position: relative;
  
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
          margin-bottom: 10px;
          min-height: 60px;
        }
  
        .feature-tag {
          position: absolute;
          bottom: 15px;
          right: 15px;
        }
      }
    }
  
    .guide-section {
      margin: 4rem 0;
      padding: 2rem;
      background: rgba(245, 247, 250, 0.8);
      border-radius: 12px;
  
      :deep(.el-step__title) {
        font-size: 1.1rem;
        font-weight: 500;
        color: #2c3e50;
      }
  
      :deep(.el-step__description) {
        font-size: 0.95rem;
        color: #5a6a7a;
        padding-right: 20px;
      }
  
      :deep(.el-step__icon) {
        font-size: 1.5rem;
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
  
    .section-title {
      display: flex;
      align-items: center;
      gap: 10px;
      color: #2c3e50;
      margin-bottom: 1.5rem;
      font-size: 1.5rem;
      border-left: 4px solid #42b983;
      padding-left: 12px;
  
      .el-icon {
        color: #42b983;
      }
    }
  }
  
  @media (max-width: 768px) {
    .acupoint-model-intro {
      padding: 1rem;
  
      .hero-section {
        padding: 1.5rem 0;
  
        .title {
          font-size: 1.8rem;
        }
      }
  
      .guide-section {
        padding: 1.5rem;
      }
    }
  }
  </style>