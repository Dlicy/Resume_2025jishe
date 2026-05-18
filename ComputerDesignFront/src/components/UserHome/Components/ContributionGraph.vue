<template>
  <div class="contribution-section">
    <div class="contribution-graph">
      <div class="graph-header">
        <h3 class="graph-title">{{ currentYear }}年学习贡献</h3>
        <div class="graph-legend">
          <span class="legend-item" v-for="item in legend" :key="item.label">
            <span class="legend-color" :style="{ backgroundColor: item.color }"></span>
            <span>{{ item.label }}</span>
          </span>
        </div>
      </div>

      <div class="graph-content">
        <div class="contribution-grid">
          <div
            class="contribution-cell"
            v-for="(day, index) in adjustedContributionData"
            :key="index"
            :data-level="day.level"
            @mouseenter="showTooltip($event, day)"
            @mouseleave="hideTooltip"
          ></div>
        </div>
      </div>

      <div class="contribution-explanation">
        <h4>如何理解学习贡献图？</h4>
        <p>此图表记录了您每日学习中医知识的时间，如同记录每日针灸练习或中药研习的日志。</p>
        <ul>
          <li><strong>每个小方格</strong>代表一天的学习情况</li>
          <li><strong>颜色深浅</strong>反映当日学习时长，如同药材的剂量多少</li>
          <li><strong>连续学习</strong>形成规律，如同针灸疗程需要持之以恒</li>
          <li><strong>空白处</strong>提示可以加强学习的时机，如同调理身体需要把握节气</li>
        </ul>
        <p>
          建议：每日研习《黄帝内经》、背诵方剂或练习针灸至少30分钟，让学习如同调理身体一样成为习惯。
        </p>
      </div>

      <div
        class="contribution-tooltip"
        v-if="tooltip.visible"
        :style="{
          top: `${tooltip.y}px`,
          left: `${tooltip.x}px`,
        }"
      >
        <div class="tooltip-date">{{ tooltip.date }}</div>
        <div class="tooltip-hours">学习时长: {{ tooltip.hours }}分钟</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const props = defineProps({
  currentYear: {
    type: Number,
    required: true,
  },
  contributionData: {
    type: Array,
    required: true,
    default: () => [],
  },
})

// 贡献图图例
const legend = ref([
  { color: '#ebedf0', label: '无学习' },
  { color: '#9be9a8', label: '1-30分钟' },
  { color: '#40c463', label: '31-60分钟' },
  { color: '#30a14e', label: '61-90分钟' },
  { color: '#216e39', label: '90+分钟' },
])

// 调整后的贡献数据（确保只显示完整周数）
const adjustedContributionData = computed(() => {
  // 直接截取365天的数据（忽略第一周的偏移）
  return props.contributionData.slice(0, 365)
})

// 悬浮提示状态
const tooltip = ref({
  visible: false,
  x: 0,
  y: 0,
  date: '',
  hours: 0,
})

// 显示悬浮提示
const showTooltip = (event, day) => {
  tooltip.value = {
    visible: true,
    x: event.clientX + 10,
    y: event.clientY + 10,
    date: day.date,
    hours: day.hours,
  }
}

// 隐藏悬浮提示
const hideTooltip = () => {
  tooltip.value.visible = false
}
</script>

<style scoped>
.contribution-section {
  margin-top: 2.5rem;
}

.contribution-graph {
  background: #ffffff;
  border-radius: 14px;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
  padding: 1.5rem;
  overflow: hidden;
}

.graph-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.8rem;
}

.graph-title {
  font-size: 1.4rem;
  font-weight: 600;
  color: #2c3e50;
}

.graph-legend {
  display: flex;
  gap: 1.2rem;
  align-items: center;
  flex-wrap: wrap;
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.9rem;
  color: #7f8c8d;
}

.legend-color {
  width: 16px;
  height: 16px;
  border-radius: 4px;
}

.graph-content {
  width: 100%;
  overflow: visible;
}

.contribution-grid {
  display: grid;
  grid-template-columns: repeat(53, minmax(0, 1fr));
  grid-auto-rows: 16px;
  gap: 5px;
  width: 100%;
  margin: 0 auto;
}

.contribution-cell {
  width: 100%;
  height: 16px;
  border-radius: 4px;
  background-color: #ebedf0;
  transition:
    transform 0.2s ease,
    opacity 0.2s ease;
  aspect-ratio: 1/1;
}

.contribution-cell[data-level='1'] {
  background-color: #9be9a8;
}

.contribution-cell[data-level='2'] {
  background-color: #40c463;
}

.contribution-cell[data-level='3'] {
  background-color: #30a14e;
}

.contribution-cell[data-level='4'] {
  background-color: #216e39;
}

.contribution-cell:hover {
  transform: scale(1.3);
  opacity: 0.9;
}

.contribution-explanation {
  margin-top: 2.5rem;
  padding: 1.5rem;
  background-color: #f9f9f9;
  border-radius: 10px;
  border-left: 5px solid #30a14e;
}

.contribution-explanation h4 {
  color: #216e39;
  font-size: 1.2rem;
  margin-bottom: 1rem;
  font-weight: 600;
}

.contribution-explanation p {
  color: #555;
  line-height: 1.7;
  margin-bottom: 1rem;
}

.contribution-explanation ul {
  padding-left: 1.5rem;
  margin-bottom: 1.5rem;
}

.contribution-explanation li {
  color: #555;
  line-height: 1.7;
  margin-bottom: 0.5rem;
}

.contribution-explanation strong {
  color: #2c3e50;
  font-weight: 600;
}

.contribution-tooltip {
  position: fixed;
  background-color: rgba(0, 0, 0, 0.9);
  color: white;
  padding: 12px 18px;
  border-radius: 8px;
  font-size: 14px;
  pointer-events: none;
  z-index: 100;
  transform: translate(15px, 15px);
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.2);
  backdrop-filter: blur(3px);
  line-height: 1.5;
}

.tooltip-date {
  font-weight: bold;
  margin-bottom: 6px;
  color: #ecf0f1;
  font-size: 1.05em;
}

.tooltip-hours {
  color: #bdc3c7;
  font-size: 0.95em;
}

@media (max-width: 992px) {
  .graph-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 1.2rem;
  }

  .graph-legend {
    width: 100%;
    justify-content: space-between;
  }
}

@media (max-width: 768px) {
  .contribution-grid {
    grid-template-columns: repeat(53, minmax(0, 1fr));
    gap: 4px;
  }

  .contribution-cell {
    height: 12px;
  }
}

@media (max-width: 576px) {
  .graph-legend {
    gap: 0.8rem;
  }

  .legend-item {
    font-size: 0.8rem;
  }

  .legend-color {
    width: 14px;
    height: 14px;
  }

  .contribution-grid {
    grid-template-columns: repeat(53, minmax(0, 1fr));
    gap: 3px;
  }

  .contribution-cell {
    height: 10px;
  }

  .contribution-explanation {
    padding: 1rem;
  }

  .contribution-explanation h4 {
    font-size: 1.1rem;
  }
}
</style>
