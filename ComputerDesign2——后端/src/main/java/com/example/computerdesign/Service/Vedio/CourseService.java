package com.example.computerdesign.Service.Vedio;
import com.example.computerdesign.DAO.Vedio.Video;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.example.computerdesign.DAO.Vedio.Course;
import com.example.computerdesign.DAO.Vedio.CourseVideo;

import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface CourseService {
    Course createCourse(Course course);

    CourseVideo addVideoToCourse(Long courseId, Long videoId, Integer order);

    public List<Course> getAllCourses();

    // 获取分页
    Page<Course> getCourses(int page, int size, String title);

    // 获取单个课程
    Course getCourseById(Long id);

    // 更新课程
    Course updateCourse(Long id, Course courseDetails);

    // 删除课程
    @Transactional
    void deleteCourse(Long id);

    List<Video> getVideosByCourseId(Long courseId);

}
