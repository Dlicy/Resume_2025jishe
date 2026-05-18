package com.example.computerdesign.DTO;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class HerbDTO {
    private String drugCategories;
    private String drugCategory;
    private String mainName;
    private String subName;
    private String natureAndFlavor;
    private String processing;
    private String meridians;
    private String efficacy;
    private String indications;
    private String usageAndDosage;
    private String contraindications;
    private String source;
    private String characters;
    private String formulas;
    private MultipartFile image; // 仅用于接收上传文件
    private String imageUrl;     // 用于返回图片路径


}
