<template>
  <div class="acupuncture-process">
    <!-- 流程步骤指示器 -->
    <div class="process-steps">
      <div 
        v-for="(step, index) in steps"
        :key="step.id"
        :class="['step-indicator', { 
          'active': props.currentStep === index,
          'completed': step.completed
        }]"
        @click="goToStep(index)"
      >
        <div class="step-number">{{ index + 1 }}</div>
        <div class="step-title">{{ step.title }}</div>
      </div>
    </div>

    <!-- 当前步骤内容 -->
    <div class="step-content">
      <h3>{{ currentStepData.title }}</h3>
      
      <div class="step-description">
        {{ currentStepData.description }}
      </div>

      <!-- 体位确定步骤 -->
      <div v-if="props.currentStep === 0" class="form-group">
        <label>选择患者体位：</label>
        <select v-model="form.position" class="form-control">
          <option value="">请选择体位</option>
          <option value="仰卧位">仰卧位</option>
          <option value="俯卧位">俯卧位</option>
          <option value="坐位">坐位</option>
        </select>
      </div>

      <!-- 穴位选择步骤 -->
      <div v-if="props.currentStep === 1" class="form-group">
        <label>选择主要治疗穴位：</label>
        <div class="point-selection">
          <label v-for="point in acupuncturePoints" :key="point.id">
            <input 
              type="checkbox" 
              v-model="form.selectedPoints" 
              :value="point.id"
            >
            {{ point.name }} ({{ point.pinyin }})
          </label>
        </div>
      </div>

      <!-- 消毒步骤 -->
      <div v-if="props.currentStep === 2" class="form-group">
        <label>使用酒精进行消毒：</label>
        <div class="point-selection">
          在模型中进行操作，点击酒精进行消毒操作(鼠标中键进行退出)
        </div>
      </div>

      <!-- 选择针具步骤 -->
      <div v-if="props.currentStep === 3" class="form-group">
        <label>选择你要使用的针具：</label>
        <div class="point-selection">
          在模型中进行操作，点击对应针具进行选择(鼠标中键进行退出)
        </div>
      </div>

      <div v-if="props.currentStep === 4" class="from-group">
        <Lebel>确定进针的角度与深度</Lebel>
        <div>
          <input :value="angle" @input="updateAngle">
          <input :value="depth" @input="updateDepth">
        </div>
      </div>

      <!-- 留针步骤 -->
      <div v-if="props.currentStep === 5" class="form-group">
        <label>留针时间（分钟）：</label>
        <input 
          type="number" 
          v-model="form.retentionTime" 
          min="5" 
          max="60" 
          step="5"
          class="form-control"
        >
      </div>

      <!-- 导航按钮 -->
      <div class="step-navigation">
        <button 
          v-if="props.currentStep > 0"
          @click="prevStep"
          class="nav-button prev"
        >
          上一步
        </button>
        <button
          @click="nextStep"
          :disabled="!canProceed"
          class="nav-button next"
        >
          {{ props.currentStep === steps.length - 1 ? '完成治疗' : '下一步' }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import LeftTable from 'element-plus/es/components/table-v2/src/renderers/left-table.mjs'
import { ref, computed, reactive, defineEmits, defineProps } from 'vue'

// 针灸穴位数据
const acupuncturePoints = [
  { id: '合谷', name: '合谷', pinyin: 'Hegu' },
  { id: '外关', name: '外关', pinyin: 'Waiguan' },
  { id: '肩井', name: '肩井', pinyin: 'Jianjing' },
  { id: '肩贞', name: '肩贞', pinyin: 'Jianzhen' },
  { id: '肩髃', name: '肩髃', pinyin: 'Jianyu' }
]

// 治疗步骤定义
const steps = ref([
  { id: 'positioning', title: '体位确定', description: '请选择适合患者和治疗的体位', completed: false },
  { id: 'pointSelection', title: '穴位选择', description: '选择需要针灸的主要穴位', completed: false },
  { id: 'disinfection', title: '消毒', description: '确认消毒部位和消毒完成', completed: false },
  { id: 'needleSelection', title: '针具选择', description: '选择适合的针具类型和规格', completed: false },
  { id: 'insertion', title: '进针', description: '确定进针角度和深度', completed: false },
  { id: 'retention', title: '留针', description: '设置留针时间和补泻手法', completed: false },
  { id: 'withdrawal', title: '出针', description: '结束治疗', completed: false }
])

// 表单数据
const form = reactive({
  position: '',
  selectedPoints: [],
  hasAshiPoint: false,
  disinfectionConfirmed: false,
  needleType: 'filiform',
  needleLength: '1.5',
  needleDiameter: '0.25',
  insertionAngle: 0,
  manipulationTechnique: 'lifting-thrusting',
  manipulationIntensity: 2,
  retentionTime: 20,
  reinReduction: 'none',
  withdrawalOrder: {},
  postWithdrawal: 'none'
})

// 当前步骤
const currentStep = ref(0)





// 接收父组件的 v-model 参数
const props = defineProps({
  currentStep: { type: Number, required: true },
  angle: { type: Number, require: true },
  depth: { type: Number, require: true},
});

const emit = defineEmits([
  'update:currentStep', // 必须声明这个事件
  'update:form',
  'complete',
  'update:angle',
  'update:depth'
]);

// 所有修改 currentStep 的地方都要通过 emit 更新
const nextStep = () => {
  if (props.currentStep < steps.value.length - 1) {
    steps.value[props.currentStep].completed = true;
    emit('update:currentStep', props.currentStep + 1); // 改为 emit
  } else {
    completeTreatment();
  }
};

const prevStep = () => {
  if (props.currentStep > 0) {
    emit('update:currentStep', props.currentStep - 1); // 改为 emit
  }
};

const goToStep = (index) => {
  if (index <= props.currentStep) {
    emit('update:currentStep', index); // 改为 emit
  }
};





// 计算当前步骤数据
const currentStepData = computed(() => steps.value[props.currentStep])

// 是否可以进入下一步
const canProceed = computed(() => {
  switch(props.currentStep) {

    case 0: return form.position != ''
    case 1: return form.selectedPoints.length > 0
    case 2: return form.disinfectionConfirmed
    case 3: return false
    case 4: return true
    case 5: return form.retentionTime >= 5
    case 6: return true
    default: return false
  }
})

// 完成治疗
const completeTreatment = () => {
  emit('complete', form)
  // console.log('治疗记录:', JSON.stringify(form, null, 2))
}
</script>

<style scoped>
.acupuncture-process {
  font-family: 'Roboto', sans-serif;
  background: linear-gradient(135deg, #0f2027 0%, #203a43 50%, #2c5364 100%);
  color: #e0f7fa;
  padding: 20px;
  border-radius: 15px;
  box-shadow: 0 0 30px rgba(0, 255, 255, 0.1);
  border: 1px solid rgba(0, 255, 255, 0.2);
}

.process-steps {
  display: flex;
  justify-content: space-between;
  margin-bottom: 30px;
  position: relative;
}

.process-steps::before {
  content: '';
  position: absolute;
  top: 20px;
  left: 0;
  right: 0;
  height: 2px;
  background: rgba(0, 255, 255, 0.2);
  z-index: 1;
}

.step-indicator {
  display: flex;
  flex-direction: column;
  align-items: center;
  position: relative;
  z-index: 2;
  cursor: pointer;
  transition: all 0.3s ease;
}

.step-indicator:hover {
  transform: translateY(-5px);
}

.step-number {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: rgba(32, 58, 67, 0.8);
  border: 2px solid rgba(0, 255, 255, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 10px;
  font-weight: bold;
  transition: all 0.3s ease;
}

.step-indicator.active .step-number {
  background: rgba(0, 255, 255, 0.2);
  border-color: #00ffff;
  box-shadow: 0 0 15px rgba(0, 255, 255, 0.4);
  color: #00ffff;
}

.step-indicator.completed .step-number {
  background: rgba(0, 200, 150, 0.3);
  border-color: rgba(0, 200, 150, 0.5);
}

.step-title {
  font-size: 14px;
  text-align: center;
  opacity: 0.8;
  transition: all 0.3s ease;
}

.step-indicator.active .step-title {
  opacity: 1;
  font-weight: 500;
  color: #00ffff;
}

.step-content {
  background: rgba(15, 32, 39, 0.7);
  backdrop-filter: blur(10px);
  border-radius: 10px;
  padding: 25px;
  border: 1px solid rgba(0, 255, 255, 0.1);
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
}

.step-content h3 {
  color: #00ffff;
  margin-top: 0;
  margin-bottom: 15px;
  font-size: 22px;
  font-weight: 500;
}

.step-description {
  color: rgba(224, 247, 250, 0.8);
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 1px solid rgba(0, 255, 255, 0.1);
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  color: rgba(224, 247, 250, 0.9);
  font-weight: 500;
}

.form-control {
  width: 100%;
  padding: 12px 15px;
  background: rgba(32, 58, 67, 0.6);
  border: 1px solid rgba(0, 255, 255, 0.3);
  border-radius: 8px;
  color: #e0f7fa;
  font-size: 16px;
  transition: all 0.3s ease;
}

.form-control:focus {
  outline: none;
  border-color: #00ffff;
  box-shadow: 0 0 10px rgba(0, 255, 255, 0.3);
}

.point-selection {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 12px;
}

.point-option {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px;
  border-radius: 6px;
  background: rgba(32, 58, 67, 0.4);
  transition: all 0.2s ease;
  cursor: pointer;
}

.point-option:hover {
  background: rgba(44, 83, 100, 0.6);
}

.checkbox-custom {
  width: 18px;
  height: 18px;
  border: 2px solid rgba(0, 255, 255, 0.5);
  border-radius: 4px;
  display: inline-block;
  position: relative;
  transition: all 0.2s ease;
}

input[type="checkbox"]:checked + .checkbox-custom {
  background: rgba(0, 255, 255, 0.3);
  border-color: #00ffff;
}

input[type="checkbox"]:checked + .checkbox-custom::after {
  content: '✓';
  position: absolute;
  top: -2px;
  left: 2px;
  color: #00ffff;
  font-size: 14px;
}

input[type="checkbox"] {
  position: absolute;
  opacity: 0;
  cursor: pointer;
  height: 0;
  width: 0;
}

.checkbox-label {
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
  padding: 12px;
  border-radius: 8px;
  background: rgba(32, 58, 67, 0.4);
  transition: all 0.2s ease;
}

.checkbox-label:hover {
  background: rgba(44, 83, 100, 0.6);
}

.needle-specs {
  display: flex;
  gap: 20px;
  margin-top: 15px;
}

.spec-group {
  flex: 1;
}

.spec-group label {
  font-size: 14px;
  color: rgba(224, 247, 250, 0.8);
}

.angle-control {
  margin-top: 15px;
}

.angle-slider {
  width: 100%;
  height: 8px;
  -webkit-appearance: none;
  background: rgba(32, 58, 67, 0.6);
  border-radius: 10px;
  outline: none;
  margin-bottom: 15px;
}

.angle-slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  background: #00ffff;
  cursor: pointer;
  box-shadow: 0 0 10px rgba(0, 255, 255, 0.5);
}

.angle-value {
  display: inline-block;
  margin-left: 10px;
  font-weight: bold;
  color: #00ffff;
}

.angle-description {
  margin-top: 5px;
  font-size: 14px;
  color: rgba(224, 247, 250, 0.8);
}

.intensity-control {
  margin-top: 15px;
}

.intensity-slider {
  width: 100%;
  height: 8px;
  -webkit-appearance: none;
  background: rgba(32, 58, 67, 0.6);
  border-radius: 10px;
  outline: none;
}

.intensity-slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  background: #00ffff;
  cursor: pointer;
  box-shadow: 0 0 10px rgba(0, 255, 255, 0.5);
}

.intensity-labels {
  display: flex;
  justify-content: space-between;
  margin-top: 8px;
  font-size: 14px;
}

.intensity-labels span {
  color: rgba(224, 247, 250, 0.6);
  transition: all 0.2s ease;
}

.intensity-labels span.active {
  color: #00ffff;
  font-weight: 500;
}

.withdrawal-order {
  margin-top: 15px;
}

.order-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  background: rgba(32, 58, 67, 0.4);
  border-radius: 6px;
  margin-bottom: 10px;
}

.order-input {
  width: 60px;
  padding: 8px;
  background: rgba(32, 58, 67, 0.6);
  border: 1px solid rgba(0, 255, 255, 0.3);
  border-radius: 4px;
  color: #e0f7fa;
  text-align: center;
}

.step-navigation {
  display: flex;
  justify-content: space-between;
  margin-top: 30px;
  padding-top: 20px;
  border-top: 1px solid rgba(0, 255, 255, 0.1);
}

.nav-button {
  padding: 12px 25px;
  border-radius: 30px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 8px;
}

.nav-button.prev {
  background: rgba(32, 58, 67, 0.6);
  border: 1px solid rgba(0, 255, 255, 0.3);
  color: #e0f7fa;
}

.nav-button.prev:hover {
  background: rgba(44, 83, 100, 0.8);
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(0, 255, 255, 0.2);
}

.nav-button.next {
  background: rgba(0, 255, 255, 0.2);
  border: 1px solid #00ffff;
  color: #00ffff;
}

.nav-button.next:hover:not(:disabled) {
  background: rgba(0, 255, 255, 0.3);
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(0, 255, 255, 0.3);
}

.nav-button.next:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.icon-arrow-left,
.icon-arrow-right {
  font-size: 16px;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .process-steps {
    flex-wrap: wrap;
    gap: 15px;
  }
  
  .step-indicator {
    flex: 1 0 calc(25% - 15px);
  }
  
  .point-selection {
    grid-template-columns: 1fr;
  }
  
  .needle-specs {
    flex-direction: column;
    gap: 15px;
  }
  
  .nav-button {
    padding: 10px 20px;
    font-size: 14px;
  }
}

@media (max-width: 480px) {
  .step-indicator {
    flex: 1 0 calc(50% - 15px);
  }
  
  .step-content {
    padding: 15px;
  }
  
  .form-control {
    padding: 10px 12px;
  }
}
</style>