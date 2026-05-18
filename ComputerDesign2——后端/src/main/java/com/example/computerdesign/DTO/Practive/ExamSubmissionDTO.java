package com.example.computerdesign.DTO.Practive;

import java.util.List;

public class ExamSubmissionDTO {
    private Long userId;
    private Double score;
    private List<ExamAnswerDTO> answers;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public List<ExamAnswerDTO> getAnswers() {
        return answers;
    }

    public void setAnswers(List<ExamAnswerDTO> answers) {
        this.answers = answers;
    }
}