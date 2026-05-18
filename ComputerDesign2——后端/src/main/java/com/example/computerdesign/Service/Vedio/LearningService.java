package com.example.computerdesign.Service.Vedio;

import com.example.computerdesign.Controller.Video.LearningController;
import com.example.computerdesign.DAO.Vedio.Video;
import com.example.computerdesign.DAO.Vedio.VideoLearning;
import com.example.computerdesign.DTO.Video.TodayLearningResponse;
import com.example.computerdesign.DTO.Video.VideoDTO;
import com.example.computerdesign.DTO.Video.VideoLearningDTO;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface LearningService {
    VideoLearning updateVideoProgress(
            Long userId,
            Long videoId,
            Integer progress,
            Boolean isCompleted,
            Integer durationLearned);

    boolean hasAnyVideoLearning(Long userId, Long courseId);

    int calculateCourseProgress(Long userId, Long courseId);

    void deleteAllVideoLearningForCourse(Long userId, Long courseId);

    // 计算每日学习
    List<TodayLearningResponse> getTodayLearningVideos(Long userId, LocalDate date);
    VideoDTO mapToVideoDTO(Video video);
    VideoLearningDTO mapToVideoLearningDTO(VideoLearning learning);

    Optional<VideoLearning> findByUserIdAndVideoId(Long userId, Long videoId);

    List<VideoLearning> findCompletedVideosByUserId(Long userId);
}
