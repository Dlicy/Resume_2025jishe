import axios from 'axios'
import { debounce } from 'lodash'

// 防抖版本（1秒内只能触发一次）
// export const updateStudyTime = debounce((currentModule: string) => {
//   const token = localStorage.getItem('token')
//   if (!token) {
//     return Promise.reject(new Error('未找到用户token'))
//   }

//   return axios.post(
//     '/api/study-time/update',
//     { module: currentModule },
//     { headers: { Authorization: `Bearer ${token}` } },
//   )
// }, 1000) // 1000ms = 1秒

const _updateStudyTime = debounce((currentModule, resolve, reject) => {
  const token = localStorage.getItem('token')
  if (!token) {
    reject('未找到用户token')
    return
  }
  axios
    .post(
      '/api/study-time/update',
      { module: currentModule },
      {
        headers: { Authorization: `Bearer ${token}` },
      },
    )
    .then(resolve)
    .catch(reject)
}, 1000)

export const updateStudyTime = (currentModule: string) => {
  return new Promise((resolve, reject) => {
    _updateStudyTime(currentModule, resolve, reject)
  })
}
