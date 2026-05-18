package com.example.computerdesign.DTO.Video;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TodayLearningResponse {
    private VideoDTO video;
    private VideoLearningDTO learning;
}
