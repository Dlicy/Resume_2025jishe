package com.example.computerdesign.Controller.Video;

import com.example.computerdesign.DAO.Vedio.CourseLearning;
import com.example.computerdesign.DAO.Vedio.CourseVideoRepository;
import com.example.computerdesign.DAO.Vedio.VideoLearning;
import com.example.computerdesign.DAO.Vedio.VideoLearningRepository;
import com.example.computerdesign.Service.Vedio.CourseLearningService;
import com.example.computerdesign.Service.Vedio.CourseVideoService;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/courses")
@RequiredArgsConstructor
public class CourseLearningController {
    private final CourseLearningService courseLearningService;
    private final CourseVideoRepository courseVideoRepository;
    private final VideoLearningRepository videoLearningRepository;

    // 检查课程报名状态
    @GetMapping("/{courseId}/enrollment-status")
    public ResponseEntity<Map<String, Boolean>> getEnrollmentStatus(
            @PathVariable Long courseId,
            @RequestParam Long userId) {
        boolean isEnrolled = courseLearningService.existsByUserIdAndCourseId(userId, courseId);
        System.out.println(isEnrolled);
        return ResponseEntity.ok(Collections.singletonMap("isEnrolled", isEnrolled));
    }

    // 加入课程
    @PostMapping("/{courseId}/enroll")
    public ResponseEntity<CourseLearning> enrollCourse(
            @PathVariable Long courseId,
            @RequestBody EnrollmentRequest request) {
        return ResponseEntity.ok(courseLearningService.enrollCourse(request.getUserId(), courseId));
    }

    // 退出课程
    @DeleteMapping("/{courseId}/quit")
    public ResponseEntity<Void> quitCourse(
            @PathVariable Long courseId,
            @RequestParam Long userId) {
        System.out.println("收到退出请求");
        System.out.println(userId);
        System.out.println(courseId);
        courseLearningService.quitCourse(userId, courseId);
        return ResponseEntity.noContent().build();
    }


    // 获取课程视频学习进度
    @GetMapping("/{courseId}/video-progress")
    public ResponseEntity<Map<Long, LearningController.VideoProgress>> getVideoProgress(
            @PathVariable Long courseId,
            @RequestParam Long userId) {

        // 1. 获取课程下的所有视频ID
        List<Long> videoIds = courseVideoRepository.findByCourseId(courseId)
                .stream()
                .map(cv -> cv.getVideo().getId())
                .collect(Collectors.toList());

        // 2. 查询这些视频的学习记录
        List<VideoLearning> learnings = videoLearningRepository.findByUser_IdAndVideo_IdIn(userId, videoIds);

        // 3. 构建响应数据
        Map<Long, LearningController.VideoProgress> result = learnings.stream()
                .collect(Collectors.toMap(
                        vl -> vl.getVideo().getId(),
                        vl -> new LearningController.VideoProgress(vl.getProgress(), vl.getIsCompleted())
                ));

        // 4. 填充未学习视频（进度为0）
        videoIds.forEach(videoId -> {
            if (!result.containsKey(videoId)) {
                result.put(videoId, new LearningController.VideoProgress(0, false));
            }
        });

        return ResponseEntity.ok(result);
    }




    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class EnrollmentRequest {
        private Long userId;
    }
}
