package com.example.computerdesign.DTO;

import lombok.Data;

import java.util.Date;

@Data
public class BookResponseDTO {
    private Long id;
    private String title;
    private String author;
    private String publisher;
    private String language;
    private String fileType;
    private Double rating;
    private Date createdAt;
    private String coverUrl;
    private String fileUrl;
}