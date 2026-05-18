<template>
  <el-form ref="formRef" :model="formData" :rules="rules" label-width="120px" label-position="top">
    <el-form-item label="题目内容" prop="question">
      <el-input
        v-model="formData.question"
        type="textarea"
        :rows="4"
        placeholder="请输入题目内容"
      />
    </el-form-item>

    <el-row :gutter="20">
      <el-col :span="12">
        <el-form-item label="选项A" prop="optionA">
          <el-input v-model="formData.optionA" placeholder="请输入选项A内容" />
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item label="选项B" prop="optionB">
          <el-input v-model="formData.optionB" placeholder="请输入选项B内容" />
        </el-form-item>
      </el-col>
    </el-row>

    <el-row :gutter="20">
      <el-col :span="12">
        <el-form-item label="选项C" prop="optionC">
          <el-input v-model="formData.optionC" placeholder="请输入选项C内容" />
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item label="选项D" prop="optionD">
          <el-input v-model="formData.optionD" placeholder="请输入选项D内容" />
        </el-form-item>
      </el-col>
    </el-row>

    <el-form-item label="正确答案" prop="correctAnswer">
      <el-radio-group v-model="formData.correctAnswer">
        <el-radio label="A">A</el-radio>
        <el-radio label="B">B</el-radio>
        <el-radio label="C">C</el-radio>
        <el-radio label="D">D</el-radio>
      </el-radio-group>
    </el-form-item>

    <el-form-item label="题目解析" prop="explanation">
      <el-input
        v-model="formData.explanation"
        type="textarea"
        :rows="4"
        placeholder="请输入题目解析"
      />
    </el-form-item>

    <el-form-item label="状态" prop="isActive" v-if="mode === 'edit'">
      <el-switch v-model="formData.isActive" active-text="启用" inactive-text="禁用" />
    </el-form-item>

    <el-form-item>
      <el-button type="primary" @click="submitForm">提交</el-button>
      <el-button @click="cancel">取消</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import { ref, watch } from 'vue'

export default {
  props: {
    mode: {
      type: String,
      default: 'add',
      validator: (value) => ['add', 'edit'].includes(value),
    },
    questionData: {
      type: Object,
      default: () => ({}),
    },
  },
  emits: ['submit', 'cancel'],
  setup(props, { emit }) {
    // 表单数据
    const formData = ref({
      question: '',
      optionA: '',
      optionB: '',
      optionC: '',
      optionD: '',
      correctAnswer: 'A',
      explanation: '',
      isActive: true,
    })

    // 表单验证规则
    const rules = {
      question: [{ required: true, message: '请输入题目内容', trigger: 'blur' }],
      optionA: [{ required: true, message: '请输入选项A内容', trigger: 'blur' }],
      optionB: [{ required: true, message: '请输入选项B内容', trigger: 'blur' }],
      optionC: [{ required: true, message: '请输入选项C内容', trigger: 'blur' }],
      optionD: [{ required: true, message: '请输入选项D内容', trigger: 'blur' }],
      correctAnswer: [{ required: true, message: '请选择正确答案', trigger: 'change' }],
    }

    // 表单引用
    const formRef = ref(null)

    // 如果是编辑模式，初始化表单数据
    watch(
      () => props.questionData,
      (newVal) => {
        if (props.mode === 'edit' && newVal) {
          formData.value = { ...newVal }
        }
      },
      { immediate: true },
    )

    // 提交表单
    const submitForm = async () => {
      try {
        await formRef.value.validate()
        emit('submit', formData.value)
      } catch (error) {
        console.error('表单验证失败:', error)
      }
    }

    // 取消
    const cancel = () => {
      emit('cancel')
    }

    return {
      formData,
      rules,
      formRef,
      submitForm,
      cancel,
    }
  },
}
</script>

<style scoped>
.el-form {
  max-width: 800px;
  margin: 0 auto;
}
</style>
