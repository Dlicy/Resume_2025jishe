package com.example.computerdesign.DAO.Practive;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "exam_answers")
public class ExamAnswer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "submission_id", nullable = false)
    @JsonIgnore
    private ExamSubmission examSubmission;

    @ManyToOne
    @JoinColumn(name = "question_id", nullable = false)
    private AcupunctureSingleChoice question;

    @Column(name = "user_answer", length = 10)
    private String userAnswer;

    private Boolean isCorrect;

    @Column(name = "created_at", updatable = false)
    @CreationTimestamp
    private LocalDateTime createdAt;

}
