package com.example.computerdesign.DAO.Practive;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "exam_submissions")
public class ExamSubmission {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(columnDefinition = "DECIMAL(5,2) DEFAULT 0")
    private Double score = 0.0;

    @Column(columnDefinition = "BOOLEAN DEFAULT FALSE")
    private Boolean submitted = false;

    @Column(name = "submission_time")
    private LocalDateTime submissionTime;

    @Column(name = "created_at", updatable = false)
    @CreationTimestamp
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "examSubmission", cascade = CascadeType.ALL)
    private List<ExamAnswer> answers = new ArrayList<>();

    // Getters and Setters
}