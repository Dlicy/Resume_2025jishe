<template>
  <div class="module-distribution">
    <h2 class="chart-title">今日学习模块分布</h2>
    <div class="chart-container">
      <canvas ref="chartCanvas"></canvas>
    </div>
    <div class="legend-container">
      <div v-for="(item, index) in chartData" :key="index" class="legend-item">
        <span class="legend-color" :style="{ backgroundColor: colors[index] }"></span>
        <span class="legend-label">{{ item.label }} ({{ item.value }}分钟)</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch, onUnmounted } from 'vue'
import { Chart, ArcElement, Tooltip, Legend } from 'chart.js'

Chart.register(ArcElement, Tooltip, Legend)

const props = defineProps({
  todayData: {
    type: Object,
    required: true,
    default: () => ({
      bookTime: 0,
      herbTime: 0,
      formulaTime: 0,
      otherTime: 0,
    }),
  },
})

const chartCanvas = ref(null)
let chartInstance = null

const colors = [
  '#36A2EB', // 书籍 - 蓝色
  '#4BC0C0', // 中药 - 青绿色
  '#FF9F40', // 方剂 - 橙色
  '#FF6384', // 其他 - 粉色
]

const chartData = ref([])

const updateChartData = () => {
  chartData.value = [
    { label: '书籍学习', value: props.todayData.bookTime },
    { label: '中药百科', value: props.todayData.herbTime },
    { label: '方剂百科', value: props.todayData.formulaTime },
    { label: '其他模块', value: props.todayData.otherTime },
  ].filter((item) => item.value > 0) // 只显示有数据的模块
}

const renderChart = () => {
  if (chartInstance) {
    chartInstance.destroy()
  }

  if (chartCanvas.value && chartData.value.length > 0) {
    const ctx = chartCanvas.value.getContext('2d')
    chartInstance = new Chart(ctx, {
      type: 'pie', // 改为标准的饼图
      data: {
        labels: chartData.value.map((item) => item.label),
        datasets: [
          {
            data: chartData.value.map((item) => item.value),
            backgroundColor: colors.slice(0, chartData.value.length), // 根据实际数据量取颜色
            borderWidth: 1,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false,
          },
          tooltip: {
            callbacks: {
              label: function (context) {
                const label = context.label || ''
                const value = context.raw || 0
                const total = context.dataset.data.reduce((a, b) => a + b, 0)
                const percentage = Math.round((value / total) * 100)
                return `${label}: ${value}分钟 (${percentage}%)`
              },
            },
          },
        },
      },
    })
  }
}

watch(
  () => props.todayData,
  () => {
    updateChartData()
    renderChart()
  },
  { deep: true },
)

onMounted(() => {
  updateChartData()
  renderChart()
})

onUnmounted(() => {
  if (chartInstance) {
    chartInstance.destroy()
  }
})
</script>

<style scoped>
.module-distribution {
  flex: 1;
  background: #ffffff;
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  margin-right: 1rem;
  min-height: 400px;
}

.chart-title {
  font-size: 1.2rem;
  color: #2c3e50;
  margin-bottom: 1.5rem;
  text-align: center;
  font-weight: 600;
}

.chart-container {
  position: relative;
  height: 250px;
  margin-bottom: 1.5rem;
}

.legend-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 1rem;
}

.legend-item {
  display: flex;
  align-items: center;
  margin-right: 1rem;
  font-size: 0.9rem;
}

.legend-color {
  display: inline-block;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  margin-right: 6px;
}

.legend-label {
  color: #555;
}

.no-data {
  text-align: center;
  color: #999;
  padding: 2rem 0;
}

@media (max-width: 768px) {
  .module-distribution {
    margin-right: 0;
    margin-bottom: 2rem;
    min-height: auto;
  }
}
</style>
