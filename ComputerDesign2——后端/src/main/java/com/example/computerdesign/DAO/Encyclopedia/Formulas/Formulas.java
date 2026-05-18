package com.example.computerdesign.DAO.Encyclopedia.Formulas;
import jakarta.persistence.*;

@Entity
@Table(name = "formulas")
public class Formulas {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(columnDefinition = "TEXT")
    private String name;

    @Column(name = "main_category", columnDefinition = "TEXT")
    private String mainCategory;

    @Column(name = "sub_category", columnDefinition = "TEXT")
    private String subCategory;

    @Column(columnDefinition = "TEXT")
    private String source;

    @Column(columnDefinition = "TEXT")
    private String classification;

    @Column(columnDefinition = "TEXT")
    private String composition;

    @Column(columnDefinition = "TEXT")
    private String explanation;

    @Column(columnDefinition = "TEXT")
    private String functions;

    @Column(columnDefinition = "TEXT")
    private String indications;

    @Column(name = "usage_method", columnDefinition = "TEXT")
    private String usageMethod;

    @Column(columnDefinition = "TEXT")
    private String precautions;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMainCategory() {
        return mainCategory;
    }

    public void setMainCategory(String mainCategory) {
        this.mainCategory = mainCategory;
    }

    public String getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(String subCategory) {
        this.subCategory = subCategory;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getClassification() {
        return classification;
    }

    public void setClassification(String classification) {
        this.classification = classification;
    }

    public String getComposition() {
        return composition;
    }

    public void setComposition(String composition) {
        this.composition = composition;
    }

    public String getExplanation() {
        return explanation;
    }

    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }

    public String getFunctions() {
        return functions;
    }

    public void setFunctions(String functions) {
        this.functions = functions;
    }

    public String getIndications() {
        return indications;
    }

    public void setIndications(String indications) {
        this.indications = indications;
    }

    public String getUsageMethod() {
        return usageMethod;
    }

    public void setUsageMethod(String usageMethod) {
        this.usageMethod = usageMethod;
    }

    public String getPrecautions() {
        return precautions;
    }

    public void setPrecautions(String precautions) {
        this.precautions = precautions;
    }
}
