package com.example.computerdesign.DAO.Vedio;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface CourseLearningRepository extends JpaRepository<CourseLearning, Long> {
    Optional<CourseLearning> findByUserIdAndCourseId(Long userId, Long courseId);
    List<CourseLearning> findByUserId(Long userId);



    void deleteByUserIdAndCourseId(Long userId, Long courseId);

    boolean existsByUserIdAndCourseId(Long userId, Long courseId);
}
