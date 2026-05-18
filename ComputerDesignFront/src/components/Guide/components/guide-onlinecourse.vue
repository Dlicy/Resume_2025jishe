<template>
    <div class="acupoint-model-intro">
      <!-- 顶部标题区 -->
      <div class="hero-section">
        <h1 class="title">
          <el-icon><VideoPlay /></el-icon>
          中医在线视频学习平台
        </h1>
        <p class="subtitle">传承经典 · 随师临证 · 每日精进</p>
      </div>
  
      <!-- 特色功能 -->
      <div class="features-section">
        <h2 class="section-title">
          <el-icon><Star /></el-icon>
          平台特色功能
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
          高效学习路径
        </h2>
        <div class="flow-steps">
          <div class="flow-item" v-for="(step, index) in learningSteps" :key="index">
            <div class="step-index">{{ index + 1 }}</div>
            <div class="step-content">
              <h3>{{ step.title }}</h3>
              <p>{{ step.description }}</p>
              <ul v-if="step.details">
                <li v-for="(detail, i) in step.details" :key="i">{{ detail }}</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
  
      <!-- 每日学习 -->
      <div class="daily-learning">
        <h2 class="section-title">
          <el-icon><Calendar /></el-icon>
          每日学习系统
        </h2>
        <el-descriptions :column="2" border>
          <el-descriptions-item 
            v-for="(item, index) in dailySystem" 
            :key="index" 
            :label="item.label"
          >
            <el-icon><component :is="item.icon" /></el-icon>
            {{ item.content }}
          </el-descriptions-item>
        </el-descriptions>
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
    VideoPlay,
    Star,
    Reading,
    TrendCharts,
    Calendar,
    Film,
    School,
    Clock,
    Notebook,
    User,
    Histogram,
    Collection,
    MagicStick,
    Medal,
    ChatLineRound
  } from '@element-plus/icons-vue'
  
  const router = useRouter()
  
  // 特色功能数据
  const features = [
    {
      icon: Film,
      title: '名家视频库',
      description: '收录1000+小时国医大师临床教学视频，涵盖内、外、妇、儿各科',
      tag: '权威传承'
    },
    {
      icon: School,
      title: '专题课程',
      description: '系统化专题课程，从基础理论到临床实践循序渐进',
      tag: '体系化学习'
    },
    {
      icon: Clock,
      title: '跟师实录',
      description: '真实跟诊过程全记录，学习辨证思路与临证技巧',
      tag: '临床思维'
    },
    {
      icon: Notebook,
      title: '学习笔记',
      description: '视频时间轴标记重点，支持图文笔记与知识点关联',
      tag: '知识沉淀'
    },
    {
      icon: User,
      title: '个性化推荐',
      description: '基于学习进度智能推荐适合的进阶内容',
      tag: '因材施教'
    },
    {
      icon: Histogram,
      title: '学习报告',
      description: '多维数据分析，可视化呈现学习成果与成长轨迹',
      tag: '效果量化'
    }
  ]
  
  // 学习流程数据
  const learningSteps = [
    {
      title: '基础筑基',
      description: '建立中医思维框架',
      details: [
        '《中医基础理论》精讲系列',
        '《黄帝内经》核心思想解读',
        '四诊方法专项训练'
      ]
    },
    {
      title: '专题深化',
      description: '按病症系统学习',
      details: [
        '常见病辨证论治专题',
        '经方临床应用精析',
        '特色疗法技术示范'
      ]
    },
    {
      title: '临床跟学',
      description: '培养临证能力',
      details: [
        '国医大师查房实录',
        '典型病例诊疗全流程',
        '师徒问答互动解析'
      ]
    },
    {
      title: '考核提升',
      description: '巩固学习成果',
      details: [
        '章节知识点测试',
        '辨证思维模拟训练',
        '学习报告与改进建议'
      ]
    }
  ]
  
  // 每日学习系统
  const dailySystem = [
    {
      label: '每日一课',
      content: '精选15分钟短课程，碎片时间高效学习',
      icon: Collection
    },
    {
      label: '学习打卡',
      content: '连续打卡获得奖励，培养学习习惯',
      icon: Medal
    },
    {
      label: '重点回顾',
      content: '智能推送遗忘知识点，加强记忆',
      icon: MagicStick
    },
    {
      label: '学友互动',
      content: '学习笔记分享与疑难讨论',
      icon: ChatLineRound
    }
  ]
  
  const goToPrevious = () => {
      router.push('/guide/library')
  }
  
  const goToNext = () => {
      router.push('/guide/prartice')
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
  
            ul {
              color: #7f8c8d;
              padding-left: 20px;
              font-size: 0.9rem;
              margin-top: 8px;
  
              li {
                margin-bottom: 5px;
                line-height: 1.5;
              }
            }
          }
        }
      }
    }
  
    .daily-learning {
      margin: 4rem 0;
  
      :deep(.el-descriptions) {
        margin-top: 20px;
  
        .el-descriptions-item__label {
          font-weight: 500;
        }
  
        .el-icon {
          vertical-align: middle;
          margin-right: 5px;
          color: #42b983;
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
    }
  }
  </style>