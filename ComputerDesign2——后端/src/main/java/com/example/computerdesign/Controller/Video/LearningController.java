package com.example.computerdesign.Controller.Video;

import com.example.computerdesign.DAO.Vedio.Video;
import com.example.computerdesign.DAO.Vedio.VideoLearning;
import com.example.computerdesign.DTO.Video.TodayLearningResponse;
import com.example.computerdesign.DTO.Video.VideoDTO;
import com.example.computerdesign.DTO.Video.VideoProgressResponse;
import com.example.computerdesign.Service.Vedio.LearningService;
import com.example.computerdesign.Service.Vedio.VideoService;

import com.example.computerdesign.Utils.JwtUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/learning")
@RequiredArgsConstructor
public class LearningController {
    private final LearningService learningService;
    private final VideoService videoService;

    @Value("${Manager_Vedio_video}")
    private String vedioVideo;


    @PutMapping("/video-progress")
    public ResponseEntity<VideoLearning> updateVideoProgress(
            @RequestBody VideoProgressRequest request) {
        System.out.println(request.getDurationLearned());
        System.out.println(request);
        return ResponseEntity.ok(learningService.updateVideoProgress(
                request.getUserId(),
                request.getVideoId(),
                request.getProgress(),
                request.getIsCompleted(),
                request.getDurationLearned()
        ));
    }

    @GetMapping("/today")
    public ResponseEntity<List<TodayLearningResponse>> getTodayLearningVideos(
            @RequestParam Long userId,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date) {


        List<TodayLearningResponse> response = learningService.getTodayLearningVideos(userId, date);

        response.forEach(todayLearningResponse -> {
            VideoDTO video = todayLearningResponse.getVideo();

            // 为视频路径和封面路径添加前缀
            if (video != null) {
                if (video.getCoverImage() != null) {
                    video.setCoverImage(vedioVideo + video.getCoverImage());
                }
            }
        });

        return ResponseEntity.ok(response);
    }

    @GetMapping("/progress")
    public ResponseEntity<VideoProgressResponse> getVideoProgress(
            @RequestParam Long userId,
            @RequestParam Long videoId) {

        try {
            // 1. 查询学习记录
            VideoLearning learningRecord = learningService.findByUserIdAndVideoId(userId, videoId)
                    .orElseGet(() -> {
                        // 如果记录不存在，创建默认响应
                        VideoLearning record = new VideoLearning();
                        record.setProgress(0);
                        record.setDurationLearned(0);
                        record.setIsCompleted(false);
                        return record;
                    });

            // 2. 转换为响应DTO
            VideoProgressResponse response = new VideoProgressResponse(
                    learningRecord.getProgress(),
                    learningRecord.getDurationLearned(),
                    learningRecord.getIsCompleted()
            );

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            System.out.println("获取视频进度失败 - userId: {}, videoId: {}");
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * 获取用户所有已完成的视频（随机最多5个）
     * @param token 用户令牌
     * @return 已完成的视频列表
     */
    @GetMapping("/completed-videos")
    public ResponseEntity<List<CompletedVideoResponse>> getCompletedVideos(
            @RequestHeader("Authorization") String token) {

        try {
            // 1. 解析token获取用户ID
            String jwtToken = token.replace("Bearer ", "").trim();
            Map<String, Object> claims = JwtUtil.parseToken(jwtToken);
            Long userId = Long.valueOf(claims.get("id").toString());

            // 2. 查询所有已完成的视频
            List<VideoLearning> completedVideos = learningService.findCompletedVideosByUserId(userId);

            // 3. 随机选择最多5个
            Collections.shuffle(completedVideos);
            List<VideoLearning> selectedVideos = completedVideos.stream()
                    .limit(5)
                    .collect(Collectors.toList());

            // 4. 转换为响应DTO
            List<CompletedVideoResponse> response = selectedVideos.stream()
                    .map(video -> {
                        Video videoInfo = videoService.getVideoById(video.getVideo().getId());

                        return new CompletedVideoResponse(
                                video.getVideo().getId(),
                                videoInfo.getTitle(),
                                video.getEndTime(),
                                video.getDurationLearned()
                        );
                    })
                    .collect(Collectors.toList());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    // 新增DTO
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class CompletedVideoResponse {
        private Long videoId;
        private String title;
        private LocalDateTime completedAt;
        private Integer durationSeconds;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class VideoLearningResponse {
        private Video video;
        private VideoLearning learning;
    }


    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class VideoProgressRequest {
        private Long userId;
        private Long videoId;
        private Integer progress;
        private Boolean isCompleted;
        private Integer durationLearned;
    }


    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class CourseProgressResponse {
        private Integer progress;
        private Map<Long, VideoProgress> videoProgress;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class VideoProgress {
        private Integer progress;
        private Boolean isCompleted;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class CourseQuitRequest {
        private Long userId;
        private Long courseId;
    }
    // 其他端点...
}
