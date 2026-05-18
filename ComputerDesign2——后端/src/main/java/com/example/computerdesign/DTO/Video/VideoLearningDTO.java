package com.example.computerdesign.DTO.Video;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VideoLearningDTO {
    private Integer progress;
    private Boolean isCompleted;
    private LocalDateTime lastPlayTime;
    private Integer durationLearned;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
}
