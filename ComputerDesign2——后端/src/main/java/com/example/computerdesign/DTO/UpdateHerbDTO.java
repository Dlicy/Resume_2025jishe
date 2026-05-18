package com.example.computerdesign.DTO;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class UpdateHerbDTO {
    private int id; // 添加 id 字段
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
    private String imageUrl;

    // 构造函数，初始化所有字段
    public UpdateHerbDTO(int id, String mainName, String subName, String drugCategories, String drugCategory,
                      String natureAndFlavor, String processing, String meridians, String efficacy,
                      String indications, String usageAndDosage, String contraindications,
                      String source, String characters, String formulas, String imageUrl) {
        this.id = id;
        this.mainName = mainName;
        this.subName = subName;
        this.drugCategories = drugCategories;
        this.drugCategory = drugCategory;
        this.natureAndFlavor = natureAndFlavor;
        this.processing = processing;
        this.meridians = meridians;
        this.efficacy = efficacy;
        this.indications = indications;
        this.usageAndDosage = usageAndDosage;
        this.contraindications = contraindications;
        this.source = source;
        this.characters = characters;
        this.formulas = formulas;
        this.imageUrl = imageUrl;
    }
}
