package com.example.computerdesign.DTO.Practive;

//public class ExamAnswerDTO {
//    private Integer questionId;
//    private String userAnswer;
//
//    public Integer getQuestionId() {
//        return questionId;
//    }
//
//    public void setQuestionId(Integer questionId) {
//        this.questionId = questionId;
//    }
//
//    public String getUserAnswer() {
//        return userAnswer;
//    }
//
//    public void setUserAnswer(String userAnswer) {
//        this.userAnswer = userAnswer;
//    }
//}

public class ExamAnswerDTO {
    private Integer questionId;
    private String userAnswer;
    private Boolean isCorrect;

    public Integer getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Integer questionId) {
        this.questionId = questionId;
    }

    public String getUserAnswer() {
        return userAnswer;
    }

    public void setUserAnswer(String userAnswer) {
        this.userAnswer = userAnswer;
    }

    public Boolean getCorrect() {
        return isCorrect;
    }

    public void setCorrect(Boolean correct) {
        isCorrect = correct;
    }
}