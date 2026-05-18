package com.example.computerdesign.DAO.UserTools;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface StudyTimeRepository  extends JpaRepository<StudyTime, Long> {
    // 根据用户ID查询学习记录
    List<StudyTime> findByUserId(Long userId);

    // 根据用户ID和学习日期查询
    Optional<StudyTime> findByUserIdAndStudyDate(Long userId, LocalDate studyDate);

    // 查询某用户某时间范围内的学习记录
    @Query("SELECT sr FROM StudyTime sr WHERE sr.userId = :userId AND sr.studyDate BETWEEN :startDate AND :endDate")
    List<StudyTime> findByUserIdAndDateRange(
            @Param("userId") Long userId,
            @Param("startDate") LocalDate startDate,
            @Param("endDate") LocalDate endDate);

    // 计算某用户总学习时间
    @Query("SELECT SUM(sr.studyTime) FROM StudyTime sr WHERE sr.userId = :userId")
    Integer sumStudyTimeByUserId(@Param("userId") Long userId);

    List<StudyTime> findByUserIdAndStudyDateBetween(Long userId, LocalDate startDate, LocalDate endDate);
}
