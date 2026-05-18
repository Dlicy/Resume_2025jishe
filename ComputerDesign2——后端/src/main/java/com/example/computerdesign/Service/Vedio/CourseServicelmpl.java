package com.example.computerdesign.Service.Vedio;

import com.example.computerdesign.DAO.User;
import com.example.computerdesign.DAO.UserRepository;
import com.example.computerdesign.DAO.Vedio.*;
import com.example.computerdesign.exception.ResourceNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CourseServicelmpl implements CourseService {
    private final CourseRepository courseRepository;
    private final CourseVideoRepository courseVideoRepository;
    private final VideoRepository videoRepository;

    @Override
    public Course createCourse(Course course) {
        course.setCreateTime(LocalDateTime.now());
        return courseRepository.save(course);
    }

    @Override
    public CourseVideo addVideoToCourse(Long courseId, Long videoId, Integer order) {
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new ResourceNotFoundException("Course not found"));
        Video video = videoRepository.findById(videoId)
                .orElseThrow(() -> new ResourceNotFoundException("Video not found"));

        CourseVideo courseVideo = new CourseVideo();
        courseVideo.setCourse(course);
        courseVideo.setVideo(video);
        courseVideo.setVideoOrder(order);
        return courseVideoRepository.save(courseVideo);
    }

    @Override
    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }

    @Override
    public Page<Course> getCourses(int page, int size, String title) {
        Pageable pageable = PageRequest.of(page, size);

        if (title != null && !title.isEmpty()) {
            return courseRepository.findByTitleContaining(title,pageable);
        }

        return courseRepository.findAll(pageable);
    }

    @Override
    public Course getCourseById(Long id) {
        return courseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("课程不存在"));
    }

    @Override
    public Course updateCourse(Long id, Course courseDetails) {
        Course course = getCourseById(id);
        course.setTitle(courseDetails.getTitle());
        course.setDescription(courseDetails.getDescription());
        // 可以添加更多需要更新的字段
        return courseRepository.save(course);
    }

    @Override
    public void deleteCourse(Long id) {
        // 先删除关联的视频关系
        courseVideoRepository.deleteByCourseId(id);
        // 再删除课程
        courseRepository.deleteById(id);
    }


    @Override
    public List<Video> getVideosByCourseId(Long courseId) {
        // 检查课程是否存在
        courseRepository.findById(courseId)
                .orElseThrow(() -> new ResourceNotFoundException("Course not found with id: " + courseId));

        // 获取课程的所有视频
        return courseVideoRepository.findVideosByCourseId(courseId);
    }
}
