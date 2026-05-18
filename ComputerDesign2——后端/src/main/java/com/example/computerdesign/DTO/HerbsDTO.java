package com.example.computerdesign.DTO;

import org.springframework.beans.factory.annotation.Value;

public class HerbsDTO {
    @Value("${Base_Url}")
    private String Base_Url;

    private int id;
    private String mainName;
    private String subName;
    private String drugCategories;
    private String drugCategory;
    private String imageUrl;

    public HerbsDTO(int id, String mainName, String subName, String drugCategories, String drugCategory, String imageUrl) {
        this.id = id;
        this.mainName = mainName;
        this.subName = (subName != null) ? subName : "无";
        this.drugCategories = drugCategories;
        this.drugCategory = drugCategory;
        this.imageUrl = (imageUrl != null) ? "http://localhost:8105" + imageUrl : "http://localhost:8105/Herbs/暂无图片.jpg";
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMainName() {
        return mainName;
    }

    public void setMainName(String mainName) {
        this.mainName = mainName;
    }

    public String getSubName() {
        return subName;
    }

    public void setSubName(String subName) {
        this.subName = subName;
    }

    public String getDrugCategories() {
        return drugCategories;
    }

    public void setDrugCategories(String drugCategories) {
        this.drugCategories = drugCategories;
    }

    public String getDrugCategory() {
        return drugCategory;
    }

    public void setDrugCategory(String drugCategory) {
        this.drugCategory = drugCategory;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
