<template>
    <div class="acupoint-model-intro">
      <!-- 顶部标题区 -->
      <div class="hero-section">
        <h1 class="title">
          <el-icon><Setting /></el-icon>
          中医教学管理系统
        </h1>
        <p class="subtitle">一站式教学资源管理与数据分析平台</p>
      </div>
  
      <!-- 核心功能 -->
      <div class="features-section">
        <h2 class="section-title">
          <el-icon><Star /></el-icon>
          核心管理功能
        </h2>
        <el-row :gutter="20">
          <el-col :xs="24" :sm="12" :md="6" v-for="(feature, index) in features" :key="index">
            <el-card shadow="hover" class="feature-card">
              <div class="feature-icon">
                <el-icon :size="36"><component :is="feature.icon" /></el-icon>
              </div>
              <h3>{{ feature.title }}</h3>
              <p>{{ feature.description }}</p>
              <div class="feature-actions">
                <el-tag 
                  v-for="(action, i) in feature.actions" 
                  :key="i" 
                  size="small"
                  :type="action.type"
                >
                  {{ action.text }}
                </el-tag>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </div>
  
      <!-- 管理流程 -->
      <div class="management-flow">
        <h2 class="section-title">
          <el-icon><TrendCharts /></el-icon>
          标准化管理流程
        </h2>
        <div class="flow-container">
          <div class="flow-item" v-for="(step, index) in managementSteps" :key="index">
            <div class="step-header">
              <div class="step-number">{{ index + 1 }}</div>
              <h3>{{ step.title }}</h3>
            </div>
            <div class="step-content">
              <p>{{ step.description }}</p>
              <div class="step-tools">
                <el-tag
                  v-for="(tool, i) in step.tools"
                  :key="i"
                  effect="plain"
                  :color="tool.color"
                >
                  <el-icon :size="12"><component :is="tool.icon" /></el-icon>
                  {{ tool.name }}
                </el-tag>
              </div>
            </div>
          </div>
        </div>
      </div>
  
      <!-- 数据看板 -->
      <div class="dashboard-section">
        <h2 class="section-title">
          <el-icon><DataAnalysis /></el-icon>
          教学数据总览
        </h2>
        <el-row :gutter="20">
          <el-col :xs="12" :sm="6" v-for="(stat, index) in statistics" :key="index">
            <el-card shadow="never" class="stat-card">
              <div class="stat-icon" :style="{ color: stat.color }">
                <el-icon :size="28"><component :is="stat.icon" /></el-icon>
              </div>
              <div class="stat-value">{{ stat.value }}</div>
              <div class="stat-label">{{ stat.label }}</div>
              <el-progress 
                v-if="stat.progress" 
                :percentage="stat.progress" 
                :color="stat.color"
                :show-text="false"
              />
            </el-card>
          </el-col>
        </el-row>
      </div>
  
      <!-- 快速入口 -->
      <div class="quick-actions">
        <div class="action-buttons">
        <el-button 
          type="info" 
          size="large" 
          @click="goToPrevious"
        >
          <el-icon><ArrowLeft /></el-icon>
          上一页
        </el-button>
      </div>
      </div>
    </div>
  </template>
  
  <script setup lang="ts">
  import { useRouter } from 'vue-router'
  import {
    Setting,
    Star,
    TrendCharts,
    DataAnalysis,
    User,
    Notebook,
    Collection,
    MapLocation,
    Upload,
    Download,
    Search,
    Edit,
    Delete,
    View,
    Link,
    Refresh,
    Sort
  } from '@element-plus/icons-vue'
  
  const router = useRouter()
  
  // 核心功能数据
  const features = [
    {
      icon: User,
      title: '人员管理',
      description: '教师、学生账号管理与权限分配',
      actions: [
        { text: '批量导入', type: 'success' },
        { text: '角色分配', type: '' },
        { text: '活动追踪', type: 'info' }
      ]
    },
    {
      icon: Notebook,
      title: '课程管理',
      description: '课程体系搭建与教学计划制定',
      actions: [
        { text: '课程编排', type: 'success' },
        { text: '资源关联', type: '' },
        { text: '发布审核', type: 'info' }
      ]
    },
    {
      icon: Collection,
      title: '书籍管理',
      description: '中医典籍数字化管理与版本控制',
      actions: [
        { text: 'OCR识别', type: 'success' },
        { text: '章节标注', type: '' },
        { text: '引用分析', type: 'info' }
      ]
    },
    {
      icon: MapLocation,
      title: '穴位管理',
      description: '3D穴位模型数据维护与更新',
      actions: [
        { text: '定位校准', type: 'success' },
        { text: '主治编辑', type: '' },
        { text: '视频关联', type: 'info' }
      ]
    }
  ]
  
  // 管理流程数据
  const managementSteps = [
    {
      title: '数据采集',
      description: '多源数据导入与标准化处理',
      tools: [
        { icon: Upload, name: 'Excel导入', color: '#f0f9eb' },
        { icon: Link, name: 'API对接', color: '#f0f9eb' },
        { icon: Edit, name: '手动录入', color: '#f0f9eb' }
      ]
    },
    {
      title: '内容审核',
      description: '专业团队进行医学内容校验',
      tools: [
        { icon: Search, name: '自动查重', color: '#ecf5ff' },
        { icon: View, name: '专家审核', color: '#ecf5ff' },
        { icon: Refresh, name: '版本对比', color: '#ecf5ff' }
      ]
    },
    {
      title: '资源发布',
      description: '多平台同步发布教学资源',
      tools: [
        { icon: Download, name: 'PDF导出', color: '#fdf6ec' },
        { icon: Sort, name: '智能推荐', color: '#fdf6ec' },
        { icon: Delete, name: '撤回管理', color: '#fdf6ec' }
      ]
    }
  ]
  
  // 数据统计
  const statistics = [
    {
      icon: User,
      value: '1,258',
      label: '注册教师',
      color: '#42b983',
      progress: 78
    },
    {
      icon: Notebook,
      value: '326',
      label: '在线课程',
      color: '#409eff',
      progress: 65
    },
    {
      icon: Collection,
      value: '1,892',
      label: '典籍资源',
      color: '#e6a23c',
      progress: 92
    },
    {
      icon: MapLocation,
      value: '361+',
      label: '穴位数据',
      color: '#f56c6c',
      progress: 100
    }
  ]
  
  // 快速入口
  const quickActions = [
    {
      icon: User,
      label: '新增教师',
      type: 'primary',
      path: '/admin/teacher/add'
    },
    {
      icon: Notebook,
      label: '课程审核',
      type: 'success',
      path: '/admin/course/review'
    },
    {
      icon: Collection,
      label: '典籍更新',
      type: 'warning',
      path: '/admin/book/update'
    },
    {
      icon: MapLocation,
      label: '穴位校准',
      type: 'danger',
      path: '/admin/acupoint/edit'
    }
  ]
  
  const goToPrevious = () => {
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
        padding-bottom: 15px;
  
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
          font-size: 1.1rem;
        }
  
        p {
          color: #7f8c8d;
          font-size: 0.9rem;
          margin-bottom: 12px;
          min-height: 40px;
        }
  
        .feature-actions {
          display: flex;
          flex-wrap: wrap;
          gap: 8px;
        }
      }
    }
  
    .management-flow {
      margin: 4rem 0;
  
      .flow-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
        margin-top: 20px;
  
        .flow-item {
          background: rgba(245, 247, 250, 0.8);
          border-radius: 8px;
          padding: 20px;
          transition: all 0.3s ease;
  
          &:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
          }
  
          .step-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
  
            .step-number {
              width: 30px;
              height: 30px;
              background: #42b983;
              color: white;
              border-radius: 50%;
              display: flex;
              align-items: center;
              justify-content: center;
              font-weight: bold;
            }
  
            h3 {
              margin: 0;
              color: #2c3e50;
              font-size: 1.1rem;
            }
          }
  
          .step-content {
            p {
              color: #5a6a7a;
              margin-bottom: 15px;
              line-height: 1.6;
            }
  
            .step-tools {
              display: flex;
              flex-wrap: wrap;
              gap: 8px;
  
              .el-tag {
                display: flex;
                align-items: center;
                gap: 5px;
              }
            }
          }
        }
      }
    }
  
    .dashboard-section {
      margin: 4rem 0;
  
      .stat-card {
        border: none;
        text-align: center;
        padding: 20px 15px;
        transition: all 0.3s ease;
  
        &:hover {
          transform: translateY(-5px);
        }
  
        .stat-icon {
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
          margin-bottom: 10px;
        }
  
        :deep(.el-progress-bar) {
          padding-right: 0;
        }
      }
    }
  
    .quick-actions {
      margin: 4rem 0;
  
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
  
      .features-section {
        .feature-card {
          margin-bottom: 15px;
        }
      }
  
      .quick-actions {
        .action-buttons {
          .el-button {
            min-width: 100%;
          }
        }
      }
    }
  }
  </style>