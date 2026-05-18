package com.example.computerdesign.DTO;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class BookDTO {
    private String title;
    private String author;
    private String publisher;
    private String language;
    private MultipartFile bookFile;
    private MultipartFile coverImage;
}