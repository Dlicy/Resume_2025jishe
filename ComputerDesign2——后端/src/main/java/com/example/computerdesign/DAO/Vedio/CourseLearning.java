package com.example.computerdesign.DAO.Vedio;

import com.example.computerdesign.DAO.User;
import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


// 视频
@Data
@Entity
@Table(name = "course_learning")
public class CourseLearning {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;

    private Integer progress = 0;
    private LocalDateTime lastLearnTime;
    private Boolean isCompleted = false;
    private LocalDateTime startTime;
    private LocalDateTime completeTime;

    // Getters and Setters
}
