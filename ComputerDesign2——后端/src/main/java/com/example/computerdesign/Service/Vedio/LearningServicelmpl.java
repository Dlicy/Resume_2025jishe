package com.example.computerdesign.Service.Vedio;
import com.example.computerdesign.Controller.Video.LearningController;
import com.example.computerdesign.DAO.UserRepository;
import com.example.computerdesign.DAO.Vedio.*;
import com.example.computerdesign.DTO.Video.TodayLearningResponse;
import com.example.computerdesign.DTO.Video.VideoDTO;
import com.example.computerdesign.DTO.Video.VideoLearningDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class LearningServicelmpl implements LearningService {
    private final VideoLearningRepository videoLearningRepository;
    private final UserRepository userRepository;
    private final VideoRepository videoRepository;
    private final CourseVideoService courseVideoService;
    private final CourseVideoRepository courseVideoRepository;


    @Override
    @Transactional
    public VideoLearning updateVideoProgress(
            Long userId,
            Long videoId,
            Integer progress,
            Boolean isCompleted,
            Integer durationLearned) {

        // 查找或创建学习记录
        VideoLearning learning = videoLearningRepository
                .findByUserIdAndVideoId(userId, videoId)
                .orElseGet(() -> {
                    VideoLearning newRecord = new VideoLearning();
                    newRecord.setUser(userRepository.findById(userId).orElseThrow());
                    newRecord.setVideo(videoRepository.findById(videoId).orElseThrow());
                    newRecord.setStartTime(LocalDateTime.now());
                    return newRecord;
                });

        // 更新进度
        learning.setProgress(progress);
        learning.setLastPlayTime(LocalDateTime.now());
        learning.setDurationLearned(durationLearned);

        // 如果标记为完成且之前未完成
        if (isCompleted != null && isCompleted && !learning.getIsCompleted()) {
            learning.setIsCompleted(true);
            learning.setEndTime(LocalDateTime.now());
        }

        return videoLearningRepository.save(learning);
    }


    @Override
    public boolean hasAnyVideoLearning(Long userId, Long courseId) {
        List<Long> videoIds = courseVideoService.getVideoIdsByCourseId(courseId);
        if (videoIds.isEmpty()) {
            return false;
        }
        return videoLearningRepository.existsByUser_IdAndVideo_IdIn(userId, videoIds);
    }

    @Override
    public int calculateCourseProgress(Long userId, Long courseId) {
        // 获取课程下的所有视频ID
        List<Long> videoIds = courseVideoRepository.findByCourseId(courseId).stream()
                .map(cv -> cv.getVideo().getId())
                .collect(Collectors.toList());

        if (videoIds.isEmpty()) {
            return 0;
        }

        // 获取已完成的视频数量
        long completedCount = videoLearningRepository.countByUserIdAndVideoIdInAndIsCompleted(userId, videoIds, true);

        // 计算进度百分比
        return (int) ((completedCount * 100) / videoIds.size());
    }

    @Override
    public void deleteAllVideoLearningForCourse(Long userId, Long courseId) {
        List<Long> videoIds = courseVideoService.getVideoIdsByCourseId(courseId);
        if (!videoIds.isEmpty()) {
            videoLearningRepository.deleteByUserIdAndVideoIdIn(userId, videoIds);
        }
    }


    @Override
    public List<TodayLearningResponse> getTodayLearningVideos(Long userId, LocalDate date) {
        // 获取当天的开始和结束时间
        LocalDateTime startOfDay = date.atStartOfDay();
        LocalDateTime endOfDay = date.atTime(23, 59, 59);

        // 查询今天的学习记录
        List<VideoLearning> learningRecords = videoLearningRepository
                .findByUserIdAndLastPlayTimeBetween(userId, startOfDay, endOfDay);

        return learningRecords.stream()
                .map(record -> {
                    Video video = videoRepository.findById(record.getVideo().getId())
                            .orElseThrow(() -> new RuntimeException("视频不存在"));

                    return new TodayLearningResponse(
                            mapToVideoDTO(video),
                            mapToVideoLearningDTO(record)
                    );
                })
                .collect(Collectors.toList());
    }

    @Override
    public VideoDTO mapToVideoDTO(Video video) {
        return new VideoDTO(
                video.getId(),
                video.getTitle(),
                video.getDuration(),
                video.getCoverImage()
        );
    }

    @Override
    public VideoLearningDTO mapToVideoLearningDTO(VideoLearning learning) {
        return new VideoLearningDTO(
                learning.getProgress(),
                learning.getIsCompleted(),
                learning.getLastPlayTime(),
                learning.getDurationLearned(),
                learning.getStartTime(),
                learning.getEndTime()
        );
    }

    @Override
    public Optional<VideoLearning> findByUserIdAndVideoId(Long userId, Long videoId) {
        return videoLearningRepository.findByUserIdAndVideoId(userId, videoId);
    }

    @Override
    public List<VideoLearning> findCompletedVideosByUserId(Long userId) {
        return videoLearningRepository.findByUserIdAndIsCompletedTrueOrderByEndTimeDesc(userId);
    }
}
