import request from '@/utils/request.ts'
import type { ResponseData } from '@/types/request'
import type { Course, CourseListParams, CourseListResponse } from '@/types/course'

export const fetchCourseList = (params?: CourseListParams) => {
  return request.get<ResponseData<CourseListResponse>>('/admin/courses', { params })
}

export const deleteCourse = (id: number) => {
  return request.delete<ResponseData>(`/admin/courses/${id}`)
}

// 其他课程相关API
export const getCourseDetail = (id: number) => {
  return request.get<ResponseData<Course>>(`/admin/courses/${id}`)
}

export const updateCourse = (id: number, data: Partial<Course>) => {
  return request.put<ResponseData>(`/admin/courses/${id}`, data)
}

export const createCourse = (data: Omit<Course, 'id'>) => {
  return request.post<ResponseData<Course>>('/admin/courses', data)
}
