package com.example.computerdesign.DTO.UserTools;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
public class StudyTimeDTO {
    private Long id;
    private Long userId;
    private Integer studyTime;
    private LocalDate studyDate;
    private LocalTime lastModified;

    private int totalTime;
    private int bookTime;
    private int herbTime;
    private int formulaTime;
}
