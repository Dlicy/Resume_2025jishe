<template>
    <div class="acupoint-model-intro">
      <!-- 顶部标题区 -->
      <div class="hero-section">
        <h1 class="title">
          <el-icon><EditPen /></el-icon>
          中医在线练习系统
        </h1>
        <p class="subtitle">智能测评 · 精准提升 · 巩固学习</p>
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
              <div class="feature-tag">{{ feature.tag }}</div>
            </el-card>
          </el-col>
        </el-row>
      </div>
  
      <!-- 学习流程 -->
      <div class="learning-flow">
        <h2 class="section-title">
          <el-icon><TrendCharts /></el-icon>
          科学练习流程
        </h2>
        <div class="flow-steps">
          <div class="flow-item" v-for="(step, index) in learningSteps" :key="index">
            <div class="step-index">{{ index + 1 }}</div>
            <div class="step-content">
              <h3>{{ step.title }}</h3>
              <p>{{ step.description }}</p>
              <div class="step-features" v-if="step.features">
                <el-tag
                  v-for="(feat, i) in step.features"
                  :key="i"
                  type="success"
                  effect="plain"
                  size="small"
                >
                  {{ feat }}
                </el-tag>
              </div>
            </div>
          </div>
        </div>
      </div>
  
      <!-- 数据统计 -->
      <div class="stats-section">
        <h2 class="section-title">
          <el-icon><DataAnalysis /></el-icon>
          学习数据追踪
        </h2>
        <el-row :gutter="20">
          <el-col :xs="12" :sm="8" :md="6" v-for="(stat, index) in stats" :key="index">
            <div class="stat-card">
              <div class="stat-icon">
                <el-icon :size="32"><component :is="stat.icon" /></el-icon>
              </div>
              <div class="stat-value">{{ stat.value }}</div>
              <div class="stat-label">{{ stat.label }}</div>
            </div>
          </el-col>
        </el-row>
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
    EditPen,
    Star,
    Reading,
    TrendCharts,
    DataAnalysis,
    Collection,
    MagicStick,
    DocumentChecked,
    Opportunity,
    Notebook,
    Histogram,
    Timer,
    Medal
  } from '@element-plus/icons-vue'
  
  const router = useRouter()
  
  // 特色功能数据
  const features = [
    {
      icon: Collection,
      title: '智能组卷',
      description: '根据学习进度自动生成个性化试卷，覆盖薄弱知识点',
      tag: '精准练习'
    },
    {
      icon: DocumentChecked,
      title: '模拟考试',
      description: '全真模拟中医执业考试环境，提升应试能力',
      tag: '实战演练'
    },
    {
      icon: Notebook,
      title: '错题本',
      description: '自动收录错题，支持分类管理和重点标注',
      tag: '查漏补缺'
    },
    {
      icon: Opportunity,
      title: '知识点练习',
      description: '按经络、方剂、诊断等专题针对性训练',
      tag: '专项突破'
    },
    {
      icon: Histogram,
      title: '成长轨迹',
      description: '可视化学习曲线，清晰掌握进步情况',
      tag: '效果量化'
    },
    {
      icon: Timer,
      title: '速记模式',
      description: '碎片时间刷题，强化重点知识记忆',
      tag: '高效学习'
    }
  ]
  
  // 学习流程数据
  const learningSteps = [
    {
      title: '诊断学情',
      description: '系统智能评估当前知识掌握情况',
      features: ['能力测评', '薄弱点分析']
    },
    {
      title: '制定计划',
      description: '生成个性化练习方案',
      features: ['每日题量推荐', '重点突破方向']
    },
    {
      title: '专项训练',
      description: '针对性强化薄弱环节',
      features: ['智能组卷', '知识点专项']
    },
    {
      title: '复盘提升',
      description: '巩固学习成果',
      features: ['错题重练', '模拟考试']
    }
  ]
  
  // 数据统计
  const stats = [
    {
      icon: Medal,
      value: '98%',
      label: '用户通过率'
    },
    {
      icon: Collection,
      value: '5000+',
      label: '精选题库'
    },
    {
      icon: DocumentChecked,
      value: '86%',
      label: '效率提升'
    },
    {
      icon: Notebook,
      value: '92%',
      label: '错题掌握率'
    }
  ]
  
  const goToPrevious = () => {
      router.push('/guide/onlinecourse')
  }
  
  const goToNext = () => {
      router.push('/guide/userhome')
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
  
    .learning-flow {
      margin: 4rem 0;
  
      .flow-steps {
        display: flex;
        flex-direction: column;
        gap: 20px;
        padding-left: 20px;
        border-left: 2px dashed #42b983;
  
        .flow-item {
          display: flex;
          gap: 15px;
          position: relative;
  
          &::before {
            content: '';
            position: absolute;
            left: -31px;
            top: 5px;
            width: 20px;
            height: 20px;
            background: #42b983;
            border-radius: 50%;
            border: 4px solid white;
          }
  
          .step-index {
            font-size: 0.9rem;
            color: #42b983;
            font-weight: bold;
            margin-top: 5px;
          }
  
          .step-content {
            background: rgba(245, 245, 245, 0.8);
            padding: 15px;
            border-radius: 8px;
            flex: 1;
  
            h3 {
              color: #2c3e50;
              margin-bottom: 8px;
              font-size: 1.1rem;
            }
  
            p {
              color: #5a6a7a;
              margin-bottom: 10px;
            }
  
            .step-features {
              display: flex;
              gap: 8px;
              flex-wrap: wrap;
              margin-top: 10px;
            }
          }
        }
      }
    }
  
    .stats-section {
      margin: 4rem 0;
  
      .stat-card {
        background: rgba(245, 247, 250, 0.8);
        border-radius: 8px;
        padding: 20px;
        text-align: center;
        transition: all 0.3s ease;
  
        &:hover {
          transform: translateY(-5px);
          box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
  
        .stat-icon {
          color: #42b983;
          margin-bottom: 10px;
        }
  
        .stat-value {
          font-size: 1.8rem;
          font-weight: bold;
          color: #2c3e50;
          margin-bottom: 5px;
        }
  
        .stat-label {
          color: #7f8c8d;
          font-size: 0.9rem;
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
  
      .learning-flow {
        .flow-steps {
          padding-left: 15px;
  
          .flow-item {
            &::before {
              left: -26px;
            }
          }
        }
      }
  
      .stats-section {
        .stat-card {
          margin-bottom: 15px;
        }
      }
    }
  }
  </style>