package com.example.computerdesign.DAO.Vedio;
import com.example.computerdesign.DAO.User;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;


// 视频
@Data
@Entity
public class Video {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @JoinColumn(name = "author_id", nullable = false)
    private Long authorId;

    private Integer duration;
    private String videoPath;
    private LocalDateTime uploadTime;
    private Integer views = 0;
    private String description;
    private String coverImage;
    private Boolean status = true;

}
