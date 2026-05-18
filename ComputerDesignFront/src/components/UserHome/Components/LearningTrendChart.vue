<template>
  <div class="learning-trend-chart">
    <div class="chart-header">
      <h3>学习趋势分析</h3>
      <div class="time-range-selector">
        <button
          v-for="range in timeRanges"
          :key="range.value"
          :class="{ active: activeRange === range.value }"
          @click="changeTimeRange(range.value)"
        >
          {{ range.label }}
        </button>
      </div>
    </div>

    <div class="chart-container">
      <canvas ref="chartCanvas"></canvas>
    </div>

    <div class="chart-statistics">
      <div class="stat-item">
        <div class="stat-label">总学习时长</div>
        <div class="stat-value">{{ formatTime(totalStudyTime) }}</div>
      </div>
      <div class="stat-item">
        <div class="stat-label">平均每日</div>
        <div class="stat-value">{{ formatTime(dailyAverage) }}</div>
      </div>
      <div class="stat-item">
        <div class="stat-label">最高记录</div>
        <div class="stat-value">{{ formatTime(peakStudyTime) }}</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted, watch, nextTick } from 'vue'
import Chart from 'chart.js/auto'

const props = defineProps({
  studyData: {
    type: Array,
    required: true,
    default: () => [],
  },
})

const chartCanvas = ref(null)
const chartInstance = ref(null)
const activeRange = ref('week')
const processedData = ref([])
const isMounted = ref(false)

const timeRanges = [
  { label: '本周', value: 'week' },
  { label: '本月', value: 'month' },
  { label: '今年', value: 'year' },
]

// 统计数据计算
const totalStudyTime = computed(() => {
  return processedData.value.reduce((sum, item) => sum + item.minutes, 0)
})

const dailyAverage = computed(() => {
  return processedData.value.length > 0
    ? Math.round(totalStudyTime.value / processedData.value.length)
    : 0
})

const peakStudyTime = computed(() => {
  return processedData.value.length > 0
    ? Math.max(...processedData.value.map((item) => item.minutes))
    : 0
})

// 格式化时间显示
const formatTime = (minutes) => {
  if (minutes < 60) return `${minutes}分钟`
  const hours = Math.floor(minutes / 60)
  const mins = Math.round(minutes % 60)
  return `${hours}小时${mins > 0 ? `${mins}分钟` : ''}`
}

// 日期格式化辅助函数
const formatDate = (date) => {
  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, '0')
  const day = String(date.getDate()).padStart(2, '0')
  return `${year}-${month}-${day}`
}

const formatDisplayDate = (date, range) => {
  if (range === 'year') return date
  const month = date.getMonth() + 1
  const day = date.getDate()
  return `${month}/${day}`
}

// 处理数据
const processData = async (range) => {
  try {
    processedData.value = [] // 清空数据

    const now = new Date()
    let result = []

    if (range === 'week') {
      // 本周数据 (最近7天)
      const startOfWeek = new Date(now)
      startOfWeek.setDate(now.getDate() - 6)

      for (let i = 0; i < 7; i++) {
        const date = new Date(startOfWeek)
        date.setDate(date.getDate() + i)
        const dateStr = formatDate(date)

        const record = props.studyData.find((item) => item.studyDate === dateStr)
        result.push({
          date: formatDisplayDate(date, range),
          minutes: record ? record.studyTime : 0,
        })
      }
    } else if (range === 'month') {
      // 本月数据 (最近30天)
      const startOfMonth = new Date(now)
      startOfMonth.setDate(now.getDate() - 29)

      for (let i = 0; i < 30; i++) {
        const date = new Date(startOfMonth)
        date.setDate(date.getDate() + i)
        const dateStr = formatDate(date)

        const record = props.studyData.find((item) => item.studyDate === dateStr)
        result.push({
          date: formatDisplayDate(date, range),
          minutes: record ? record.studyTime : 0,
        })
      }
    } else {
      // 今年数据 (按月份)
      const monthNames = [
        '1月',
        '2月',
        '3月',
        '4月',
        '5月',
        '6月',
        '7月',
        '8月',
        '9月',
        '10月',
        '11月',
        '12月',
      ]

      // 初始化每月数据
      const monthlyData = Array(12).fill(0)

      // 汇总每月学习时间
      props.studyData.forEach((item) => {
        const date = new Date(item.studyDate)
        if (date.getFullYear() === now.getFullYear()) {
          const month = date.getMonth()
          monthlyData[month] += item.studyTime
        }
      })

      // 生成结果
      result = monthNames.map((name, index) => ({
        date: name,
        minutes: monthlyData[index],
      }))
    }

    processedData.value = result.length > 0 ? result : [{ date: '暂无数据', minutes: 0 }]

    await nextTick()
    initChart()
  } catch (error) {
    console.error('数据处理错误:', error)
    processedData.value = [{ date: '数据加载失败', minutes: 0 }]
  }
}

// 初始化图表
const initChart = () => {
  if (!isMounted.value || !chartCanvas.value) return

  const ctx = chartCanvas.value.getContext('2d')
  if (!ctx) return

  // 销毁旧实例
  if (chartInstance.value) {
    chartInstance.value.destroy()
    chartInstance.value = null
  }

  // 确保有有效数据
  if (!processedData.value || processedData.value.length === 0) {
    return
  }

  try {
    chartInstance.value = new Chart(ctx, {
      type: 'line',
      data: {
        labels: processedData.value.map((item) => item.date),
        datasets: [
          {
            label: '学习时长 (分钟)',
            data: processedData.value.map((item) => item.minutes),
            borderColor: '#30a14e',
            backgroundColor: 'rgba(48, 161, 78, 0.1)',
            borderWidth: 2,
            tension: 0.3,
            fill: {
              target: 'origin',
              above: 'rgba(48, 161, 78, 0.1)',
            },
            pointBackgroundColor: '#216e39',
            pointRadius: 4,
            pointHoverRadius: 6,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { display: false },
          tooltip: {
            callbacks: {
              label: (context) => {
                const minutes = context.raw
                const hours = Math.floor(minutes / 60)
                const mins = minutes % 60
                return `学习时长: ${hours > 0 ? `${hours}小时` : ''}${mins}分钟`
              },
            },
          },
        },
        scales: {
          x: {
            grid: { display: false },
            ticks: {
              maxRotation: activeRange.value === 'year' ? 0 : 45,
              minRotation: activeRange.value === 'year' ? 0 : 45,
            },
          },
          y: {
            beginAtZero: true,
            ticks: {
              callback: (value) => {
                if (value >= 60) return `${Math.floor(value / 60)}小时`
                return `${value}分钟`
              },
            },
          },
        },
      },
    })
  } catch (error) {
    console.error('图表初始化失败:', error)
  }
}

// 切换时间范围
const changeTimeRange = async (range) => {
  activeRange.value = range
  await processData(range)
}

// 监听studyData变化
watch(
  () => props.studyData,
  (newData) => {
    if (newData && newData.length > 0) {
      processData(activeRange.value)
    }
  },
  { immediate: true },
)

onMounted(() => {
  isMounted.value = true
  processData(activeRange.value)
})

onUnmounted(() => {
  if (chartInstance.value) {
    chartInstance.value.destroy()
  }
})
</script>

<style scoped>
.learning-trend-chart {
  background: #ffffff;
  border-radius: 14px;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
  padding: 1.5rem;
  margin-top: 2.5rem;
}

.chart-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
}

.chart-header h3 {
  font-size: 1.4rem;
  font-weight: 600;
  color: #2c3e50;
  margin: 0;
}

.time-range-selector {
  display: flex;
  gap: 0.8rem;
}

.time-range-selector button {
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 6px;
  background-color: #f5f7fa;
  color: #7f8c8d;
  font-size: 0.9rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.time-range-selector button:hover {
  background-color: #e0e6ed;
}

.time-range-selector button.active {
  background-color: #30a14e;
  color: white;
}

.chart-container {
  position: relative;
  height: 300px;
  width: 100%;
  margin: 1rem 0;
}

.chart-statistics {
  display: flex;
  justify-content: space-around;
  margin-top: 1.5rem;
  padding-top: 1.5rem;
  border-top: 1px solid #f0f0f0;
}

.stat-item {
  text-align: center;
}

.stat-label {
  font-size: 0.9rem;
  color: #7f8c8d;
  margin-bottom: 0.5rem;
}

.stat-value {
  font-size: 1.2rem;
  font-weight: 600;
  color: #2c3e50;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .chart-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
  }

  .time-range-selector {
    width: 100%;
    justify-content: space-between;
  }

  .time-range-selector button {
    flex: 1;
    text-align: center;
  }

  .chart-statistics {
    flex-direction: column;
    gap: 1.2rem;
  }
}
</style>
