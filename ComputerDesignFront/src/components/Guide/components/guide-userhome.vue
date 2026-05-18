<template>
    <div class="acupoint-model-intro">
      <!-- 顶部标题区 -->
      <div class="hero-section">
        <h1 class="title">
          <el-icon><User /></el-icon>
          我的中医学习中心
        </h1>
        <p class="subtitle">个性化学习路径 · 智能知识管理</p>
      </div>
  
      <!-- 特色功能 -->
      <div class="features-section">
        <h2 class="section-title">
          <el-icon><Star /></el-icon>
          特色功能
        </h2>
        <el-row :gutter="20">
          <el-col :xs="24" :sm="12" :md="8" v-for="(feature, index) in features" :key="index">
            <el-card shadow="hover" class="feature-card">
              <div class="feature-icon">
                <el-icon :size="36"><component :is="feature.icon" /></el-icon>
              </div>
              <h3>{{ feature.title }}</h3>
              <p>{{ feature.description }}</p>
              <div class="feature-tag">{{ feature.tag }}</div>
            </el-card>
          </el-col>
        </el-row>
      </div>
  
      <!-- 学习路线 -->
      <div class="learning-path">
        <h2 class="section-title">
          <el-icon><TrendCharts /></el-icon>
          个性化学习路线
        </h2>
        <div class="path-steps">
          <div class="path-item" v-for="(step, index) in learningPath" :key="index">
            <div class="step-header">
              <div class="step-marker" :style="{ backgroundColor: step.color }">
                {{ index + 1 }}
              </div>
              <h3>{{ step.title }}</h3>
            </div>
            <div class="step-content">
              <p>{{ step.description }}</p>
              <div class="step-features">
                <el-tag
                  v-for="(feat, i) in step.features"
                  :key="i"
                  :type="feat.type"
                  effect="plain"
                  size="small"
                >
                  <el-icon :size="12"><component :is="feat.icon" /></el-icon>
                  {{ feat.text }}
                </el-tag>
              </div>
            </div>
          </div>
        </div>
      </div>
  
      <!-- 行动按钮 -->
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
    User,
    Star,
    Reading,
    TrendCharts,
    MagicStick,
    Histogram,
    Collection,
    Notebook,
    Clock,
    Medal,
    VideoPlay,
    DocumentChecked,
    Connection
  } from '@element-plus/icons-vue'
  
  const router = useRouter()
  
  // 特色功能数据
  const features = [
    {
      icon: MagicStick,
      title: '智能诊断',
      description: '基于学习历史智能分析知识掌握程度',
      tag: '精准定位'
    },
    {
      icon: Histogram,
      title: '成长图谱',
      description: '可视化展示各学科能力成长曲线',
      tag: '进步可视'
    },
    {
      icon: Collection,
      title: '知识网络',
      description: '构建知识点关联图谱，形成系统认知',
      tag: '体系学习'
    },
    {
      icon: Notebook,
      title: '智能笔记',
      description: '自动关联视频时间戳，一键生成复习卡片',
      tag: '高效回顾'
    },
    {
      icon: Clock,
      title: '记忆曲线',
      description: '根据遗忘规律自动安排复习时间点',
      tag: '科学记忆'
    },
    {
      icon: Medal,
      title: '成就系统',
      description: '学习里程碑与技能徽章激励体系',
      tag: '正向反馈'
    }
  ]
  
  // 学习路线数据
  const learningPath = [
    {
      title: '基础筑基',
      description: '系统掌握中医基础理论核心概念',
      color: '#42b983',
      features: [
        { icon: VideoPlay, text: '28个视频', type: 'success' },
        { icon: DocumentChecked, text: '5套测试', type: '' },
        { icon: Connection, text: '3个实践', type: 'info' }
      ]
    },
    {
      title: '经典精研',
      description: '深度学习《黄帝内经》《伤寒论》核心内容',
      color: '#409eff',
      features: [
        { icon: VideoPlay, text: '36个视频', type: 'success' },
        { icon: DocumentChecked, text: '8套测试', type: '' },
        { icon: Connection, text: '5个实践', type: 'info' }
      ]
    },
    {
      title: '临床思维',
      description: '培养辨证论治能力与方剂应用技巧',
      color: '#e6a23c',
      features: [
        { icon: VideoPlay, text: '42个视频', type: 'success' },
        { icon: DocumentChecked, text: '12套测试', type: '' },
        { icon: Connection, text: '7个实践', type: 'info' }
      ]
    },
    {
      title: '综合实践',
      description: '真实病例分析与临床技能综合训练',
      color: '#f56c6c',
      features: [
        { icon: VideoPlay, text: '18个视频', type: 'success' },
        { icon: DocumentChecked, text: '6套测试', type: '' },
        { icon: Connection, text: '10个实践', type: 'info' }
      ]
    }
  ]
  
  const goToPrevious = () => {
      router.push('/guide/prartice')
  }
  
  const goToNext = () => {
      router.push('/guide/manager')
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
        padding-bottom: 40px;
  
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
          left: 20px;
          background: rgba(66, 185, 131, 0.1);
          color: #42b983;
          padding: 2px 10px;
          border-radius: 4px;
          font-size: 0.8rem;
        }
      }
    }
  
    .learning-path {
      margin: 4rem 0;
  
      .path-steps {
        display: flex;
        flex-direction: column;
        gap: 25px;
        padding-left: 30px;
        position: relative;
  
        &::before {
          content: '';
          position: absolute;
          left: 14px;
          top: 0;
          bottom: 0;
          width: 2px;
          background: linear-gradient(to bottom, #42b983, #f56c6c);
        }
  
        .path-item {
          position: relative;
          
          .step-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 10px;
  
            .step-marker {
              width: 30px;
              height: 30px;
              border-radius: 50%;
              color: white;
              display: flex;
              align-items: center;
              justify-content: center;
              font-weight: bold;
              flex-shrink: 0;
            }
  
            h3 {
              margin: 0;
              color: #2c3e50;
              font-size: 1.2rem;
            }
          }
  
          .step-content {
            padding-left: 45px;
  
            p {
              color: #5a6a7a;
              margin-bottom: 10px;
              line-height: 1.6;
            }
  
            .step-features {
              display: flex;
              gap: 10px;
              flex-wrap: wrap;
  
              .el-tag {
                display: flex;
                align-items: center;
                gap: 4px;
              }
            }
          }
        }
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
  
      .learning-path {
        .path-steps {
          padding-left: 20px;
  
          &::before {
            left: 9px;
          }
  
          .path-item {
            .step-content {
              padding-left: 35px;
            }
          }
        }
      }
    }
  }
  </style>