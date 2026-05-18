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
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Lob
    private String description;

    @Column(nullable = false)
    private Long creatorId = 0L;

    private LocalDateTime createTime;
    private String coverImage;

    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL)
    private List<CourseVideo> courseVideos = new ArrayList<>();


}

