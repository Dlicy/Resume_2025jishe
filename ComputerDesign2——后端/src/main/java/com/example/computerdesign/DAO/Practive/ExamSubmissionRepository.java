package com.example.computerdesign.DAO.Practive;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExamSubmissionRepository extends JpaRepository<ExamSubmission, Integer> {
    List<ExamSubmission> findByUserId(Long userId);

    List<ExamSubmission> findByUserIdAndSubmittedTrue(Long userId);

    List<ExamSubmission> findByUserIdAndScoreContaining(Long userId, String score);

    List<ExamSubmission> findByUserIdOrderBySubmissionTimeDesc(Long userId);


}
