import { createRouter, createWebHistory } from 'vue-router'
import Home from '../components/Home.vue'
import Search01 from '../components/Library/Search01.vue'
import Search02 from '../components/Library/Search02.vue'
import VirtualIndex from '@/components/Virtual_labs/VirtualIndex.vue'
import HomeIndex from '@/components/Home/HomeIndex.vue'

import ManagerIndex from '@/components/Manager/ManagerIndex.vue'
import ManagerBase from '@/components/Manager/ManagerBase.vue'
import HerbsIndex from '@/components/Manager/Herbs/HerbsIndex.vue'
import AddHerbs from '@/components/Manager/Herbs/AddHerbs.vue'
import EditHerbs from '@/components/Manager/Herbs/EditHerbs.vue'
import AddBooks from '@/components/Manager/Books/AddBooks.vue'
import EditBooks from '@/components/Manager/Books/EditBooks.vue'
import EditUser from '@/components/Manager/user/EditUser.vue'
import Login from '@/components/Login/Login.vue'
import Register from '@/components/Login/Register.vue'
import ShowBook from '@/components/Library/ShowBook.vue'
import ShowHerb from '@/components/Library/ShowHerb.vue'
import AddPoints from '@/components/Manager/Points/AddPoints.vue'
import EditPoints from '@/components/Manager/Points/EditPoints.vue'
import Search03 from '@/components/Library/Search03.vue'
import ShowFormula from '@/components/Library/ShowFormula.vue'

import Guide from '@/components/Guide/Guide.vue'

import UnityShow from '@/components/Unity/UnityShow.vue'
import UserHome from '@/components/UserHome/UserHome.vue'

// 方剂百科
import AddFormula from '@/components/Manager/Formulas/AddFormula.vue'
import EditFormula from '@/components/Manager/Formulas/EditFormula.vue'

// 模拟诊断
import PracticeHome from '@/components/UnityPractice/PracticeHome.vue'

// 线上课程
import OnlineCourseIndex from '@/components/OnlineCourse/OnlineCourseIndex.vue'
import LearningProgress from '@/components/OnlineCourse/LearningProgress.vue'
import DailyLearning from '@/components/OnlineCourse/DailyLearning.vue'
import fff from '@/components/OnlineCourse/fff.vue'
import VideoDetail from '@/components/OnlineCourse/VideoDetail.vue'
import SpecialTopics from '@/components/OnlineCourse/SpecialTopics.vue'
import CreateCourse from '@/components/Manager/Vedio/CreateCourse.vue'
import UploadVideo from '@/components/Manager/Vedio/UploadVideo.vue'
import EditCourse from '@/components/Manager/Vedio/EditCourse.vue'
import EditVideo from '@/components/Manager/Vedio/EditVideo.vue'
import PractiveIndex from '@/components/Practice/PractiveIndex.vue'
import CourseDetail from '@/components/OnlineCourse/CourseDetail.vue'

// 模拟联系
import AutoTestView from '@/components/Practice/Components/AutoTestView.vue'
import HistoryView from '@/components/Practice/Components/HistoryView.vue'
import WrongQuestionsView from '@/components/Practice/Components/WrongQuestionsView.vue'

import AddQuestion from '@/components/Manager/Practive/AddQuestion.vue'
import EditQuestion from '@/components/Manager/Practive/EditQuestion.vue'
import ExamDetail from '@/components/Practice/Components/ExamDetail.vue'

import guideIntroduce from '@/components/Guide/components/guide-introduce.vue'
import guideLibrary from '@/components/Guide/components/guide-library.vue'
import guideManager from '@/components/Guide/components/guide-manager.vue'
import guideOnlinecourse from '@/components/Guide/components/guide-onlinecourse.vue'
import guidePractice from '@/components/Guide/components/guide-practice.vue'
import guideUnity from '@/components/Guide/components/guide-unity.vue'
import guideUntiypractice from '@/components/Guide/components/guide-untiypractice.vue'
import guideUserhome from '@/components/Guide/components/guide-userhome.vue'

const isAuthenticated = () => {
  // 这里是检查用户是否登录的逻辑
  return !!localStorage.getItem('user') // 示例：检查 localStorage
}

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      children: [
        {
          path: '/', // 子路由路径
          name: 'DemoHome',
          component: HomeIndex,
        },
        // meta: {
        //   requiresAuth: true, // 需要登录
        //   title: '首页',
        // },
        {
          path: 'practice', // 另一个子路由示例
          name: 'practice',
          component: PractiveIndex,
          children: [
            {
              path: 'auto-test',
              component: AutoTestView,
            },
            {
              path: 'history',
              component: HistoryView,
            },
            {
              path: 'wrong-questions',
              component: WrongQuestionsView,
            },
            {
              path: '',
              redirect: '/practice/auto-test',
            },
          ],
        },

        {
          path: 'search02', // 另一个子路由示例
          name: 'search02',
          component: Search02,
        },
        {
          path: 'online_course', // 另一个子路由示例
          name: 'onlinecourseIndex',
          component: fff,
        },
        {
          path: 'daily-learning', // 另一个子路由示例
          name: 'daily-learning',
          component: DailyLearning,
        },
        {
          path: 'learning-progress',
          name: 'learning-progress',
          component: LearningProgress,
        },
        {
          path: 'video/:id',
          name: 'VideoDetail',
          component: VideoDetail,
          props: true,
        },
        {
          path: '/course/:id',
          name: 'CourseDetail',
          component: CourseDetail,
          props: true,
        },
        {
          path: 'special-topics',
          name: 'SpecialTopics',
          component: SpecialTopics,
        },
        {
          path: 'search03', // 另一个子路由示例
          name: 'search03',
          component: Search03,
        },
        {
          path: 'showbook', // 另一个子路由示例
          name: 'showbook',
          component: ShowBook,
          props: (route) => ({ bookId: route.query.bookid }), // 通过 props 传递 bookId
        },
        {
          path: 'showformula', // 另一个子路由示例
          name: 'showformula',
          component: ShowFormula,
          props: (route) => ({ formulaId: route.query.formulaid }), // 通过 props 传递 bookId
        },
        {
          path: 'showherb', // 另一个子路由示例
          name: 'showherb',
          component: ShowHerb,
          props: (route) => ({ herbId: route.query.herbid }), // 通过 props 传递 bookId
        },
        {
          path: 'userhome', // 另一个子路由示例
          name: 'userhome',
          component: UserHome,
        },
        {
          path: 'guide', // 另一个子路由示例
          name: 'guide',
          component: Guide,
          children: [
            {
              path: '',
              redirect: '/guide/introduction'
            },

            // 系统概述
            {
              path: 'introduction',
              name: 'guideIntroduce',
              component: guideIntroduce,
            },
            // 虚拟实验室
            {
              path: 'untiy',
              name: 'guideUnity',
              component: guideUnity
            },
            {
              path: 'untiypractice',
              name: 'guideUntiypractice',
              component: guideUntiypractice
            },
            // 系统使用
            {
              path: 'library',
              name: 'guideLibrary',
              component: guideLibrary
            },
            {
              path: 'onlinecourse',
              name: 'guideOnlinecourse',
              component: guideOnlinecourse
            },
            {
              path: 'prartice',
              name: 'guidePractice',
              component: guidePractice
            },
            {
              path: 'userhome',
              name: 'guideUserhome',
              component: guideUserhome
            },
            {
              path: 'manager',
              name: 'guideManager',
              component: guideManager
            },
          ]
        },
        {
          path: 'Virtual_labs', // 另一个子路由示例
          name: 'Virtual_labs',
          component: VirtualIndex,
        },
        {
          path: 'search01', // 另一个子路由示例
          name: 'search01',
          component: Search01,
        },
      ],
    },

    {
      path: '/acupuncture/review/:id',
      name: 'ExamDetail',
      component: ExamDetail,
      props: true, // 将路由参数作为props传递
    },
    {
      path: '/ManagerLogin',
      name: 'managerlogin',
      component: ManagerIndex, // 确保你有 Manager 组件
    },
    {
      path: '/Manager',
      name: 'manager',
      component: ManagerBase, // 确保你有 Manager 组件
      children: [
        // 其他路由...
        {
          path: 'encyclopedia',
          children: [
            {
              path: 'AddHerbs',
              name: 'encyclopedia-add-herbs', // 推荐kebab-case命名
              component: AddHerbs,
            },
            {
              path: 'EditHerbs',
              name: 'encyclopedia-edit-herbs',
              component: EditHerbs,
            },
            {
              path: 'EditFormulas',
              name: 'encyclopedia-edit-formulas',
              component: EditFormula,
            },
            {
              path: 'AddFormulas',
              name: 'encyclopedia-add-formulas', // 推荐kebab-case命名
              component: AddFormula,
            },
          ],
        },
        {
          path: 'exam',
          children: [
            {
              path: 'AddQuestion',
              name: 'exam-add-question', // 推荐kebab-case命名
              component: AddQuestion,
            },
            {
              path: 'EditQuestion',
              name: 'exam-edit-question',
              component: EditQuestion,
            },
          ],
        },
        {
          path: 'OnlineCourse',
          children: [
            {
              path: 'Course',
              children: [
                {
                  path: 'CreateCourse',
                  name: 'onlinecourse-course-createcourse',
                  component: CreateCourse,
                },
                {
                  path: 'EditCourse',
                  name: 'onlinecourse-course-editcourse',
                  component: EditCourse,
                },
              ],
            },
            {
              path: 'Video',
              children: [
                {
                  path: 'UploadVideo',
                  name: 'onlinecourse-video-uploadvideo',
                  component: UploadVideo,
                },
                {
                  path: 'EditVideo',
                  name: 'onlinecourse-video-editvideo',
                  component: EditVideo,
                },
              ],
            },
          ],
        },
        {
          path: 'book',
          children: [
            {
              path: 'AddBooks',
              name: 'book-add-books',
              component: AddBooks,
            },
            {
              path: 'EditBooks',
              name: 'book-edit-books',
              component: EditBooks,
            },
          ],
        },
        {
          path: 'lab',
          children: [
            {
              path: 'acupoint',
              children: [
                {
                  path: 'AddPoint',
                  name: 'acupoint-add-point',
                  component: AddPoints,
                },
                {
                  path: 'EditPoint',
                  name: 'acupoint-edit-point',
                  component: EditPoints,
                },
              ],
            },
          ],
        },
        {
          path: 'EditUser',
          name: 'user-edit-user',
          component: EditUser,
        },
      ],
    },
    {
      path: '/UnityShow',
      name: 'unityshow',
      component: UnityShow,
    },
    {
      path: '/Unitypractice', // 另一个子路由示例
      name: 'unitypractice',
      component: PracticeHome,
    },
    {
      path: '/Login',
      name: 'Login',
      component: Login,
    },
    {
      path: '/Register',
      name: 'Register',
      component: Register,
    },
  ],
})

// 路由守卫
router.beforeEach((to, from, next) => {
  const isAuthenticated = localStorage.getItem('token')

  // 设置页面标题
  document.title = to.meta.title ? `${to.meta.title} | 我的应用` : '我的应用'

  // 需要登录但未登录的页面
  if (to.meta.requiresAuth && !isAuthenticated) {
    next({
      path: '/login',
      query: { redirect: to.fullPath }, // 保存目标路由以便登录后跳转
    })
  }
  // 已登录但访问登录/注册页
  else if ((to.path === '/login' || to.path === '/register') && isAuthenticated) {
    next('/') // 跳转到首页
  } else {
    next() // 正常放行
  }
})

export default router
