package com.example.computerdesign.DTO.UserTools;

import lombok.AllArgsConstructor;
import lombok.Data;

// 专用DTO
@Data
@AllArgsConstructor
public class StudyTimeSummary {
    private int totalTime;
    private int bookTime;
    private int herbTime;
    private int formulaTime;
}
