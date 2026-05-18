package com.example.computerdesign.DAO.Vedio;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public interface CourseVideoRepository extends JpaRepository<CourseVideo, Long> {
    List<CourseVideo> findByCourseId(Long courseId);
    Optional<CourseVideo> findByCourseIdAndVideoId(Long courseId, Long videoId);

    // 根据课程ID删除关联记录
    @Transactional
    @Modifying
    @Query("DELETE FROM CourseVideo cv WHERE cv.id = :courseId")
    void deleteByCourseId(Long courseId);


    // 通过课程找视频
    @Query("SELECT cv.video FROM CourseVideo cv WHERE cv.course.id = :courseId ORDER BY cv.chapterOrder, cv.videoOrder")
    List<Video> findVideosByCourseId(@Param("courseId") Long courseId);


    @Query("SELECT cv.video FROM CourseVideo cv WHERE cv.course = :courseId")
    List<Long> findVideoIdsByCourseId(@Param("courseId") Long courseId);
}