package com.example.computerdesign.DAO.Practive;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExamAnswerRepository extends JpaRepository<ExamAnswer, Integer> {
    List<ExamAnswer> findByExamSubmissionId(Integer submissionId);
}
