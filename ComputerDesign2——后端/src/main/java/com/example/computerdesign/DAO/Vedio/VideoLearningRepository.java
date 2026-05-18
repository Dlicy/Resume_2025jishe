package com.example.computerdesign.DAO.Vedio;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface VideoLearningRepository extends JpaRepository<VideoLearning, Long> {
    Optional<VideoLearning> findByUserIdAndVideoId(Long userId, Long videoId);
    List<VideoLearning> findByUserId(Long userId);


    List<VideoLearning> findByUser_IdAndVideo_IdIn(Long userId, List<Long> videoIds);
    boolean existsByUser_IdAndVideo_IdIn(Long userId, List<Long> videoIds);

    @Modifying
    @Query("DELETE FROM VideoLearning vl WHERE vl.user.id = :userId AND vl.video.id IN :videoIds")
    void deleteByUserIdAndVideoIdIn(@Param("userId") Long userId, @Param("videoIds") List<Long> videoIds);

//    @Query("SELECT vl FROM VideoLearning vl WHERE vl.userId = :userId AND vl.videoId = :videoId")
//    Optional<VideoLearning> findByUserIdAndVideoId(
//            @Param("userId") Long userId,
//            @Param("videoId") Long videoId);

    long countByUserIdAndVideoIdInAndIsCompleted(Long userId, List<Long> videoIds, Boolean isCompleted);

    // 今日学习
    List<VideoLearning> findByUserIdAndLastPlayTimeBetween(Long userId, LocalDateTime start, LocalDateTime end);

    List<VideoLearning> findByUserIdAndIsCompletedTrueOrderByEndTimeDesc(Long userId);
}
