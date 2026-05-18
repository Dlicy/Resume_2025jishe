package com.example.computerdesign.DAO.Vedio;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Data;

// 视频-课程 绑定表单
@Data
@Entity
@Table(name = "course_video")
public class CourseVideo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "course_id", nullable = false)
    @JsonIgnoreProperties("courseVideos")
    private Course course;

    @ManyToOne
    @JoinColumn(name = "video_id", nullable = false)
    private Video video;

    @Column(name = "videoorder") // 使用新的字段名
    private Integer videoOrder;
    private String chapter;
    private Integer chapterOrder = 0;

    // Getters and Setters
}