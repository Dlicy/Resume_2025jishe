package com.example.computerdesign.DAO.UserTools;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "study_records")
public class StudyTime {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "study_time", nullable = false)
    private Integer studyTime; // 学习时间(分钟)

    // 各模块学习时间（与ALTER TABLE语句严格对应）
    @Column(name = "book_time", nullable = false, columnDefinition = "INT DEFAULT 0")
    private Integer bookTime = 0;

    @Column(name = "herb_time", nullable = false, columnDefinition = "INT DEFAULT 0")
    private Integer herbTime = 0;

    @Column(name = "formula_time", nullable = false, columnDefinition = "INT DEFAULT 0")
    private Integer formulaTime = 0;

    @Column(name = "other_time", nullable = false, columnDefinition = "INT DEFAULT 0")
    private Integer otherTime = 0;

    @Column(name = "study_date", nullable = false)
    private LocalDate studyDate; // 学习日期

    @Column(name = "last_modified")
    private LocalTime lastModified; // 最后修改时间

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;


    // 便捷方法：更新学习时间
    public void updateStudyTime(String moduleType, int minutes) {
        this.studyTime += minutes;

        switch (moduleType.toLowerCase()) {
            case "book":
                this.bookTime += minutes;
                break;
            case "herb":
                this.herbTime += minutes;
                break;
            case "formula":
                this.formulaTime += minutes;
                break;
            default:
                this.otherTime += minutes;
        }
        this.lastModified = LocalTime.now();
    }

    // 获取指定模块的学习时间
    public int getModuleTime(String moduleType) {
        switch (moduleType.toLowerCase()) {
            case "book": return bookTime;
            case "herb": return herbTime;
            case "formula": return formulaTime;
            default: return otherTime;
        }
    }


}
