package com.example.computerdesign.DAO.Encyclopedia;

import jakarta.persistence.*;

@Entity
@Table(name = "herbs")
public class Herbs {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;  // 中药ID

    @Column(name = "drug_categories")
    private String drugCategories;  // 药大类

    @Column(name = "drug_category")
    private String drugCategory;  // 药小类

    @Column(name = "main_name", nullable = false)
    private String mainName;  // 主名称

    @Column(name = "sub_name")
    private String subName;  // 副名称

    @Column(name = "source")
    private String source;  // 来源

    @Column(name = "nature_and_flavor")
    private String natureAndFlavor;  // 性味

    @Column(name = "processing")
    private String processing;  // 炮制

    @Column(name = "characters")
    private String characters;  // 性状

    @Column(name = "efficacy")
    private String efficacy;  // 功效

    @Column(name = "meridians")
    private String meridians;  // 经脉

    @Column(name = "indications")
    private String indications;  // 主治

    @Column(name = "usage_and_dosage")
    private String usageAndDosage;  // 用法用量

    @Column(name = "contraindications")
    private String contraindications;  // 注意禁忌

    @Column(name = "formulas")
    private String formulas;  // 药方（存储相关方剂的名称或ID）

    @Column(name = "image_url")
    private String imageUrl;  // 图片存储地址

    // Getters and Setters

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getNatureAndFlavor() {
        return natureAndFlavor;
    }

    public void setNatureAndFlavor(String natureAndFlavor) {
        this.natureAndFlavor = natureAndFlavor;
    }

    public String getProcessing() {
        return processing;
    }

    public void setProcessing(String processing) {
        this.processing = processing;
    }

    public String getCharacters() {
        return characters;
    }

    public void setCharacters(String characters) {
        this.characters = characters;
    }

    public String getEfficacy() {
        return efficacy;
    }

    public void setEfficacy(String efficacy) {
        this.efficacy = efficacy;
    }

    public String getMeridians() {
        return meridians;
    }

    public void setMeridians(String meridians) {
        this.meridians = meridians;
    }

    public String getIndications() {
        return indications;
    }

    public void setIndications(String indications) {
        this.indications = indications;
    }

    public String getUsageAndDosage() {
        return usageAndDosage;
    }

    public void setUsageAndDosage(String usageAndDosage) {
        this.usageAndDosage = usageAndDosage;
    }

    public String getContraindications() {
        return contraindications;
    }

    public void setContraindications(String contraindications) {
        this.contraindications = contraindications;
    }

    public String getFormulas() {
        return formulas;
    }

    public void setFormulas(String formulas) {
        this.formulas = formulas;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}