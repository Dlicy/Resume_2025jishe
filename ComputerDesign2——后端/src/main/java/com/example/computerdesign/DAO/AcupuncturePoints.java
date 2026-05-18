package com.example.computerdesign.DAO;

import jakarta.persistence.*;

@Entity
@Table(name = "acupoints")
public class AcupuncturePoints {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "acupointname", length = 500)
    private String acupointName;

    @Column(name = "pulse", length = 500)
    private String pulse;

    @Column(name = "orientation", columnDefinition = "TEXT")
    private String orientation;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "operation", columnDefinition = "TEXT")
    private String operation;

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAcupointName() {
        return acupointName;
    }

    public void setAcupointName(String acupointName) {
        this.acupointName = acupointName;
    }

    public String getPulse() {
        return pulse;
    }

    public void setPulse(String pulse) {
        this.pulse = pulse;
    }

    public String getOrientation() {
        return orientation;
    }

    public void setOrientation(String orientation) {
        this.orientation = orientation;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }
}