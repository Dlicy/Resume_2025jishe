package com.example.computerdesign.Service.Practive;

import com.example.computerdesign.DAO.Practive.*;
import com.example.computerdesign.DTO.Practive.ExamAnswerDTO;
import com.example.computerdesign.DTO.Practive.ExamSubmissionDTO;
import com.example.computerdesign.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class ExamService {
    private final ExamSubmissionRepository examSubmissionRepository;
    private final ExamAnswerRepository examAnswerRepository;
    private final AcupunctureSingleChoiceRepository questionRepository;

    @Autowired
    public ExamService(ExamSubmissionRepository examSubmissionRepository,
                       ExamAnswerRepository examAnswerRepository,
                       AcupunctureSingleChoiceRepository questionRepository) {
        this.examSubmissionRepository = examSubmissionRepository;
        this.examAnswerRepository = examAnswerRepository;
        this.questionRepository = questionRepository;
    }

    @Transactional
    public Integer submitExam(ExamSubmissionDTO submissionDTO) {
        // 1. 基础验证
        if (submissionDTO.getUserId() == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        if (submissionDTO.getAnswers() == null || submissionDTO.getAnswers().isEmpty()) {
            throw new IllegalArgumentException("答案列表不能为空");
        }

        // 2. 保存考试记录
        ExamSubmission submission = new ExamSubmission();
        submission.setUserId(submissionDTO.getUserId());
        submission.setSubmitted(true);
        submission.setSubmissionTime(LocalDateTime.now());
        ExamSubmission savedSubmission = examSubmissionRepository.save(submission);

        // 3. 处理每道题答案
        int correctCount = 0;
        for (ExamAnswerDTO answerDTO : submissionDTO.getAnswers()) {
            // 4. 实时查询题目（不预加载）
            AcupunctureSingleChoice question = questionRepository.findById(answerDTO.getQuestionId())
                    .orElseThrow(() -> new RuntimeException("题目不存在: " + answerDTO.getQuestionId()));

            // 5. 判断答案正确性
            boolean isCorrect = question.getCorrectAnswer().equalsIgnoreCase(answerDTO.getUserAnswer());
            if (isCorrect) correctCount++;

            // 6. 保存答案记录
            ExamAnswer answer = new ExamAnswer();
            answer.setExamSubmission(savedSubmission);
            answer.setQuestion(question);
            answer.setUserAnswer(answerDTO.getUserAnswer());
            answer.setIsCorrect(isCorrect);
            answer.setCreatedAt(LocalDateTime.now());
            examAnswerRepository.save(answer); // 单条保存
        }

        // 7. 计算并更新总分
        double score = calculateScore(correctCount, submissionDTO.getAnswers().size());
        savedSubmission.setScore(score);
        examSubmissionRepository.save(savedSubmission);

        return savedSubmission.getId();
    }

    // 分数计算逻辑抽离
    private double calculateScore(int correctCount, int totalQuestions) {
        if (totalQuestions <= 0) return 0;
        return Math.round((correctCount * 100.0 / totalQuestions) * 100) / 100.0;
    }

    public List<ExamSubmission> getUserExamHistory(Long userId, String search) {
        return examSubmissionRepository.findByUserId(userId);
    }

    public ExamSubmission getExamDetail(Integer id) {
        return examSubmissionRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Exam not found"));
    }
}