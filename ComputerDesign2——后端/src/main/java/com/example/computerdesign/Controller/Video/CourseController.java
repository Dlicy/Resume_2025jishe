package com.example.computerdesign.Controller.Video;

import com.example.computerdesign.DAO.Vedio.Course;
import com.example.computerdesign.DAO.Vedio.CourseVideo;
import com.example.computerdesign.DAO.Vedio.Video;
import com.example.computerdesign.Service.Vedio.CourseService;
import com.example.computerdesign.Utils.VedioStorageService;
import com.example.computerdesign.exception.ResourceNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/api/courses")
@RequiredArgsConstructor
public class CourseController {
    private final CourseService courseService;
    private final VedioStorageService vedioStorageService;

    @Value("${Manager_Vedio_course_image}")
    private String courseImageShowUrl;


    @Value("${file.course-upload-dir}")
    private String courseUploadDir;

    @Value("${Manager_Vedio_video}")
    private String vedioVideo;

    @PostMapping
    public ResponseEntity<Course> createCourse(
            @RequestParam String title,
            @RequestParam(required = false) String description,
            @RequestParam Long creatorId,
            @RequestParam(required = false) MultipartFile coverImage) {

        try {
            Course course = new Course();
            course.setTitle(title);
            course.setDescription(description);
            course.setCreatorId(creatorId);
            course.setCreateTime(LocalDateTime.now());

            if (coverImage != null && !coverImage.isEmpty()) {
                String imagePath = vedioStorageService.storeFile(coverImage);
                course.setCoverImage(imagePath);
            }

            return ResponseEntity.ok(courseService.createCourse(course));
        } catch (IOException e) {
            throw new RuntimeException("Failed to store cover image", e);
        }
    }

    /**
     * 获取课程列表（分页+筛选）
     */
    @GetMapping
    public ResponseEntity<Page<Course>> getCourses(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String title) {
        System.out.println("getCourses params - page: " + page + ", size: " + size + ", title: " + title);
        try {
            Page<Course> result = courseService.getCourses(page, size, title);
            System.out.println("=== 查询结果 ===");
            System.out.println("总记录数: " + result.getTotalElements());
            System.out.println("返回记录数: " + result.getContent().size());
            System.out.println("总页数: " + result.getTotalPages());
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            System.err.println("查询课程列表出错: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     * 获取单个课程详情
     */
    @GetMapping("/{id}")
    public ResponseEntity<Course> getCourseById(@PathVariable Long id) {
        Course course= courseService.getCourseById(id);
        if (course == null) {
            return ResponseEntity.notFound().build(); // 如果课程不存在，返回404
        }

        // 假设 course 有一个 getCoverImage() 方法返回封面图片的相对路径
        String coverImageUrl = courseImageShowUrl + course.getCoverImage();
        course.setCoverImage(coverImageUrl); // 设置完整的封面图片 URL
        return ResponseEntity.ok(course);
    }

    /**
     * 更新课程信息
     */
    @PutMapping("/{id}")
    public ResponseEntity<Course> updateCourse(
            @PathVariable Long id,
            @RequestBody Course course) {

        return ResponseEntity.ok(courseService.updateCourse(id, course));
    }

    /**
     * 删除课程
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCourse(@PathVariable Long id) {
        // 获取课程
        Course course = courseService.getCourseById(id);
        if (course != null) {
            // 删除封面图片
            String coverImagePath = course.getCoverImage(); // 假设这是相对路径
            deleteCoverImage(coverImagePath);
        }

        courseService.deleteCourse(id);
        return ResponseEntity.noContent().build();
    }

    // 用于删除对应课程封面文件
    private void deleteCoverImage(String coverImage) {
        try {
            // 组合文件路径
            Path filePath = Paths.get(courseUploadDir, coverImage);
            Files.deleteIfExists(filePath); // 删除文件
        } catch (Exception e) {
            // 处理异常，记录日志或抛出自定义异常
            System.err.println("Failed to delete cover image: " + e.getMessage());
        }
    }


    @GetMapping("/all")
    public ResponseEntity<List<Course>> getAllCourses() {
        List<Course> courses = courseService.getAllCourses();

        // 检查课程列表是否为空
        if (courses == null || courses.isEmpty()) {
            return ResponseEntity.ok(Collections.emptyList()); // 返回空列表
        }

        // 遍历每个课程，处理封面图片 URL
        for (Course course : courses) {
            String coverImageUrl = courseImageShowUrl + course.getCoverImage();
            course.setCoverImage(coverImageUrl); // 设置完整的封面图片 URL
        }

        return ResponseEntity.ok(courses);
    }

    @GetMapping("/{courseId}/videos")
    public ResponseEntity<List<Video>> getCourseVideos(@PathVariable Long courseId) {
        try {
            List<Video> videos = courseService.getVideosByCourseId(courseId);

            // 为每个视频的路径和封面图片添加前缀
            videos.forEach(video -> {
                video.setVideoPath(vedioVideo + video.getVideoPath());
                if (video.getCoverImage() != null) {
                    video.setCoverImage(vedioVideo + video.getCoverImage());
                }
            });
            return ResponseEntity.ok(videos);
        } catch (ResourceNotFoundException e) {
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }



}
