package com.example.computerdesign.DTO.Video;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VideoProgressResponse {
    private Integer progress;
    private Integer durationLearned;
    private Boolean isCompleted;
}
