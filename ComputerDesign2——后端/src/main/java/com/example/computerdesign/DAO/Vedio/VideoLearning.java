package com.example.computerdesign.DAO.Vedio;
import com.example.computerdesign.DAO.User;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;


// 视频
@Data
@Entity
@Table(name = "video_learning")
public class VideoLearning {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "video_id", nullable = false)
    private Video video;

    private Boolean isCompleted = false;
    private LocalDateTime lastPlayTime;
    private Integer progress = 0;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private Integer durationLearned = 0;

}
