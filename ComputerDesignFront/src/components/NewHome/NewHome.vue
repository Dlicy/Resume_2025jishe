<template>
  <div class="tcm-dashboard-light">
    <!-- 欢迎区域 -->
    <div class="welcome-section">
      <h1>欢迎回来, {{ userName }}医师!</h1>
      <p>今天是{{ currentDate }}，{{ greetingMessage }}</p>

    </div>

    <!-- 学习概览卡片 -->
    <div class="overview-cards">
      <div class="card">
        <div class="card-icon" style="background-color: #4e8abe">
          <i class="fas fa-map-marked-alt"></i>
        </div>
        <div class="card-content">
          <h3>已掌握穴位</h3>
          <p>{{ stats.masteredPoints }} / 361</p>
        </div>
      </div>

      <div class="card">
        <div class="card-icon" style="background-color: #5dae8b">
          <i class="fas fa-clock"></i>
        </div>
        <div class="card-content">
          <h3>针灸练习时长</h3>
          <p>{{ stats.practiceHours }} 小时</p>
        </div>
      </div>

      <div class="card">
        <div class="card-icon" style="background-color: #8a6bbe">
          <i class="fas fa-project-diagram"></i>
        </div>
        <div class="card-content">
          <h3>经络掌握度</h3>
          <p>{{ stats.meridianMastery }}%</p>
        </div>
      </div>

      <div class="card">
        <div class="card-icon" style="background-color: #e87d7d">
          <i class="fas fa-bolt"></i>
        </div>
        <div class="card-content">
          <h3>连续学习</h3>
          <p>{{ stats.streakDays }} 天</p>
        </div>
      </div>
    </div>

    <!-- 图表区域 -->
    <div class="chart-row">
      <div class="chart-container">
        <h2><i class="fas fa-project-diagram" style="color: #8a6bbe"></i> 经络掌握进度</h2>
        <apexchart
          type="radialBar"
          :options="meridianChart.options"
          :series="meridianChart.series"
        ></apexchart>
      </div>

      <div class="chart-container">
        <h2><i class="fas fa-calendar-alt" style="color: #5dae8b"></i> 每周练习时间</h2>
        <apexchart
          type="bar"
          height="350"
          :options="weeklyPracticeChart.options"
          :series="weeklyPracticeChart.series"
        ></apexchart>
      </div>
    </div>

    <div class="chart-row">
      <div class="chart-container">
        <h2><i class="fas fa-map-marked-alt" style="color: #4e8abe"></i> 穴位掌握分布</h2>
        <apexchart
          type="polarArea"
          :options="acupointsChart.options"
          :series="acupointsChart.series"
        ></apexchart>
      </div>

      <div class="chart-container">
        <h2><i class="fas fa-stethoscope" style="color: #e87d7d"></i> 诊断准确率趋势</h2>
        <apexchart
          type="line"
          height="350"
          :options="diagnosisChart.options"
          :series="diagnosisChart.series"
        ></apexchart>
      </div>
    </div>

    <!-- 今日学习任务 -->
    <div class="daily-tasks">
      <h2><i class="fas fa-tasks" style="color: #5dae8b"></i> 今日学习任务</h2>
      <div class="task-list">
        <div v-for="(task, index) in dailyTasks" :key="index" class="task-item">
          <div class="task-icon" :style="{ backgroundColor: task.color }">
            <i :class="task.icon"></i>
          </div>
          <div class="task-content">
            <h3>{{ task.title }}</h3>
            <p>{{ task.description }}</p>
            <div class="task-meta">
              <span class="task-time"><i class="fas fa-clock"></i> {{ task.time }}分钟</span>
              <span class="task-difficulty"><i class="fas fa-bolt"></i> {{ task.difficulty }}</span>
            </div>
          </div>
          <button
            class="task-btn"
            :class="{ 'primary-btn': !task.completed, 'completed-btn': task.completed }"
          >
            {{ task.completed ? '已完成' : '开始学习' }}
          </button>
        </div>
      </div>
    </div>

    <!-- 经典典籍推荐 -->
    <div class="classical-books">
      <h2><i class="fas fa-book-medical" style="color: #4e8abe"></i> 经典典籍学习</h2>
      <div class="book-list">
        <div v-for="(book, index) in classicalBooks" :key="index" class="book-item">
          <div class="book-cover" :style="{ backgroundColor: book.color }">
            <i :class="book.icon"></i>
          </div>
          <div class="book-info">
            <h3>{{ book.title }}</h3>
            <p class="book-author">{{ book.author }}</p>
            <div class="progress-container">
              <div class="progress-bar">
                <div
                  class="progress"
                  :style="{ width: book.progress + '%', backgroundColor: book.color }"
                ></div>
              </div>
              <span class="progress-text">{{ book.progress }}%</span>
            </div>
            <button class="study-btn" :style="{ backgroundColor: book.color }">继续研读</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'

export default {
  name: 'TcmDashboardLight',
  setup() {
    const userName = ref('张仲景')
    const currentDate = ref('')
    const greetingMessage = ref('')

    const stats = ref({
      masteredPoints: 128,
      practiceHours: 56.5,
      meridianMastery: 72,
      streakDays: 14,
    })

    // 更新当前日期和问候语
    const updateDateTime = () => {
      const now = new Date()
      const options = { year: 'numeric', month: 'long', day: 'numeric', weekday: 'long' }
      currentDate.value = now.toLocaleDateString('zh-CN', options)

      const hours = now.getHours()
      if (hours < 5) {
        greetingMessage.value = '寅时养生，宜静心学习'
      } else if (hours < 7) {
        greetingMessage.value = '卯时大肠经当令，学习效果最佳'
      } else if (hours < 11) {
        greetingMessage.value = '辰时胃经当令，学习正当时'
      } else if (hours < 13) {
        greetingMessage.value = '午时心经当令，适当休息'
      } else if (hours < 17) {
        greetingMessage.value = '未时小肠经当令，吸收知识好时机'
      } else if (hours < 19) {
        greetingMessage.value = '酉时肾经当令，温故而知新'
      } else {
        greetingMessage.value = '亥时三焦经当令，总结一日所学'
      }
    }

    // 经络掌握图表数据
    const meridianChart = ref({
      series: [stats.value.meridianMastery],
      options: {
        chart: {
          type: 'radialBar',
        },
        plotOptions: {
          radialBar: {
            startAngle: -135,
            endAngle: 135,
            hollow: {
              margin: 0,
              size: '70%',
            },
            dataLabels: {
              name: {
                offsetY: -10,
                color: '#4a5568',
                fontSize: '13px',
              },
              value: {
                color: '#4a5568',
                fontSize: '30px',
                show: true,
              },
            },
            track: {
              background: '#edf2f7',
              strokeWidth: '97%',
              margin: 5,
            },
          },
        },
        fill: {
          type: 'gradient',
          gradient: {
            shade: 'light',
            shadeIntensity: 0.15,
            inverseColors: false,
            opacityFrom: 1,
            opacityTo: 1,
            stops: [0, 50, 65, 91],
          },
        },
        stroke: {
          dashArray: 4,
        },
        labels: ['经络掌握度'],
        colors: ['#8A6BBE'],
      },
    })

    // 每周练习时间图表数据
    const weeklyPracticeChart = ref({
      series: [
        {
          name: '练习时间(小时)',
          data: [3, 4, 2.5, 5, 4.5, 6, 3.5],
        },
      ],
      options: {
        chart: {
          type: 'bar',
          height: 350,
          toolbar: {
            show: false,
          },
          background: 'transparent',
        },
        plotOptions: {
          bar: {
            borderRadius: 4,
            horizontal: false,
            columnWidth: '55%',
          },
        },
        dataLabels: {
          enabled: false,
        },
        stroke: {
          show: true,
          width: 2,
          colors: ['transparent'],
        },
        xaxis: {
          categories: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
          labels: {
            style: {
              colors: '#4a5568',
            },
          },
        },
        yaxis: {
          title: {
            text: '小时',
            style: {
              color: '#4a5568',
            },
          },
          labels: {
            style: {
              colors: '#4a5568',
            },
          },
        },
        fill: {
          opacity: 1,
        },
        colors: ['#5DAE8B'],
        tooltip: {
          y: {
            formatter: function (val) {
              return val + ' 小时'
            },
          },
          theme: 'light',
        },
        grid: {
          borderColor: '#e2e8f0',
        },
      },
    })

    // 穴位掌握图表数据
    const acupointsChart = ref({
      series: [85, 72, 68, 90, 65, 78],
      options: {
        chart: {
          type: 'polarArea',
          background: 'transparent',
        },
        stroke: {
          colors: ['#fff'],
        },
        fill: {
          opacity: 0.8,
        },
        labels: [
          '手太阴肺经',
          '足阳明胃经',
          '足太阴脾经',
          '手少阴心经',
          '足太阳膀胱经',
          '手厥阴心包经',
        ],
        colors: ['#4E8ABE', '#5DAE8B', '#8A6BBE', '#E87D7D', '#F6AD55', '#68D391'],
        responsive: [
          {
            breakpoint: 480,
            options: {
              chart: {
                width: 200,
              },
              legend: {
                position: 'bottom',
                labels: {
                  colors: '#4a5568',
                },
              },
            },
          },
        ],
        legend: {
          labels: {
            colors: '#4a5568',
          },
        },
      },
    })

    // 诊断准确率图表数据
    const diagnosisChart = ref({
      series: [
        {
          name: '诊断准确率',
          data: [65, 68, 72, 75, 78, 82, 85, 88, 90],
        },
      ],
      options: {
        chart: {
          height: 350,
          type: 'line',
          zoom: {
            enabled: false,
          },
          toolbar: {
            show: false,
          },
          background: 'transparent',
        },
        dataLabels: {
          enabled: false,
        },
        stroke: {
          curve: 'smooth',
          width: 3,
        },
        colors: ['#E87D7D'],
        xaxis: {
          categories: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月'],
          labels: {
            style: {
              colors: '#4a5568',
            },
          },
        },
        yaxis: {
          min: 50,
          max: 100,
          title: {
            text: '准确率(%)',
            style: {
              color: '#4a5568',
            },
          },
          labels: {
            style: {
              colors: '#4a5568',
            },
          },
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val + '%'
            },
          },
          theme: 'light',
        },
        grid: {
          borderColor: '#e2e8f0',
        },
      },
    })

    // 今日学习任务
    const dailyTasks = ref([
      {
        icon: 'fas fa-hand-holding-medical',
        title: '手太阴肺经穴位复习',
        description: '复习云门、天府、侠白等穴位定位与主治',
        time: 20,
        difficulty: '中等',
        completed: false,
        color: '#4E8ABE',
      },
      {
        icon: 'fas fa-vial',
        title: '针灸病例分析',
        description: '完成2个风寒感冒病例的针灸治疗方案',
        time: 30,
        difficulty: '较难',
        completed: false,
        color: '#5DAE8B',
      },
      {
        icon: 'fas fa-book-open',
        title: '《黄帝内经》选读',
        description: '阅读"灵枢·九针十二原"篇并做笔记',
        time: 15,
        difficulty: '简单',
        completed: true,
        color: '#8A6BBE',
      },
    ])

    // 经典典籍推荐
    const classicalBooks = ref([
      {
        icon: 'fas fa-scroll',
        title: '黄帝内经',
        author: '佚名',
        progress: 45,
        color: '#4E8ABE',
      },
      {
        icon: 'fas fa-book',
        title: '伤寒杂病论',
        author: '张仲景',
        progress: 28,
        color: '#5DAE8B',
      },
      {
        icon: 'fas fa-book-medical',
        title: '针灸甲乙经',
        author: '皇甫谧',
        progress: 15,
        color: '#8A6BBE',
      },
      {
        icon: 'fas fa-book-reader',
        title: '针灸大成',
        author: '杨继洲',
        progress: 8,
        color: '#E87D7D',
      },
    ])

    onMounted(() => {
      updateDateTime()
    })

    return {
      userName,
      currentDate,
      greetingMessage,
      stats,
      meridianChart,
      weeklyPracticeChart,
      acupointsChart,
      diagnosisChart,
      dailyTasks,
      classicalBooks,
    }
  },
}
</script>

<style scoped>
.tcm-dashboard-light {
  padding: 20px;
  max-width: 1400px;
  margin: 0 auto;
  font-family: 'Microsoft YaHei', sans-serif;
  background-color: #f8fafa;
  color: #4a5568;
}

.welcome-section {
  margin-bottom: 30px;
  text-align: center;
  position: relative;
  padding: 25px;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  border: 1px solid #e2e8f0;
}

.welcome-section h1 {
  font-size: 28px;
  color: #2d3748;
  margin-bottom: 8px;
  font-weight: 600;
}

.welcome-section p {
  font-size: 16px;
  color: #718096;
  font-style: italic;
}

.chinese-medicine-icon {
  position: absolute;
  top: 20px;
  right: 20px;
  width: 50px;
  height: 50px;
  background-color: #4e8abe;
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.overview-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  display: flex;
  align-items: center;
  border: 1px solid #e2e8f0;
  transition:
    transform 0.2s,
    box-shadow 0.2s;
}

.card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.card-icon {
  width: 50px;
  height: 50px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 15px;
  color: white;
  font-size: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.card-content h3 {
  font-size: 16px;
  color: #718096;
  margin: 0 0 5px 0;
  font-weight: 500;
}

.card-content p {
  font-size: 24px;
  font-weight: 600;
  color: #2d3748;
  margin: 0;
}

.chart-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
  margin-bottom: 20px;
}

@media (max-width: 1024px) {
  .chart-row {
    grid-template-columns: 1fr;
  }
}

.chart-container {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  border: 1px solid #e2e8f0;
}

.chart-container h2 {
  font-size: 18px;
  color: #2d3748;
  margin-top: 0;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  font-weight: 600;
}

.daily-tasks {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  margin-top: 20px;
  margin-bottom: 20px;
  border: 1px solid #e2e8f0;
}

.daily-tasks h2 {
  font-size: 18px;
  color: #2d3748;
  margin-top: 0;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  font-weight: 600;
}

.task-list {
  display: grid;
  gap: 15px;
}

.task-item {
  display: flex;
  align-items: center;
  padding: 15px;
  border-radius: 10px;
  background-color: white;
  border: 1px solid #e2e8f0;
  transition:
    transform 0.2s,
    box-shadow 0.2s;
}

.task-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
}

.task-icon {
  width: 40px;
  height: 40px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 15px;
  color: white;
  font-size: 16px;
  flex-shrink: 0;
}

.task-content {
  flex: 1;
  min-width: 0;
}

.task-content h3 {
  font-size: 16px;
  margin: 0 0 5px 0;
  color: #2d3748;
  font-weight: 600;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.task-content p {
  font-size: 14px;
  color: #718096;
  margin: 0 0 8px 0;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.task-meta {
  display: flex;
  gap: 15px;
  font-size: 12px;
  color: #718096;
}

.task-meta i {
  margin-right: 5px;
}

.task-btn {
  padding: 8px 15px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.3s;
  font-weight: 500;
  flex-shrink: 0;
  margin-left: 15px;
}

.primary-btn {
  background-color: #4e8abe;
  color: white;
}

.primary-btn:hover {
  background-color: #3a6f9a;
}

.completed-btn {
  background-color: #edf2f7;
  color: #718096;
  cursor: default;
}

.classical-books {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  border: 1px solid #e2e8f0;
}

.classical-books h2 {
  font-size: 18px;
  color: #2d3748;
  margin-top: 0;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  font-weight: 600;
}

.book-list {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
}

.book-item {
  display: flex;
  padding: 15px;
  border-radius: 10px;
  background-color: white;
  border: 1px solid #e2e8f0;
  transition:
    transform 0.2s,
    box-shadow 0.2s;
}

.book-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
}

.book-cover {
  width: 60px;
  height: 80px;
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 15px;
  color: white;
  font-size: 24px;
  flex-shrink: 0;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.book-info {
  flex: 1;
  min-width: 0;
}

.book-info h3 {
  font-size: 16px;
  margin: 0 0 5px 0;
  color: #2d3748;
  font-weight: 600;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.book-author {
  font-size: 14px;
  color: #718096;
  margin: 0 0 10px 0;
  font-style: italic;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.progress-container {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.progress-bar {
  flex: 1;
  height: 6px;
  background: #edf2f7;
  border-radius: 3px;
  margin-right: 10px;
  overflow: hidden;
}

.progress {
  height: 100%;
  border-radius: 3px;
  transition: width 0.3s ease;
}

.progress-text {
  font-size: 12px;
  color: #718096;
  width: 40px;
  text-align: right;
}

.study-btn {
  padding: 6px 12px;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.3s;
  font-weight: 500;
  width: 100%;
}

.study-btn:hover {
  opacity: 0.9;
}

@media (max-width: 768px) {
  .overview-cards {
    grid-template-columns: 1fr 1fr;
  }

  .book-list {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 480px) {
  .overview-cards {
    grid-template-columns: 1fr;
  }

  .task-item {
    flex-wrap: wrap;
  }

  .task-btn {
    margin-left: 0;
    margin-top: 10px;
    width: 100%;
  }
}
</style>
