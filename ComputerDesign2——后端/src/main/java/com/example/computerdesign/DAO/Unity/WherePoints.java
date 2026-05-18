package com.example.computerdesign.DAO.Unity;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "acupuncture_points")
public class WherePoints {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "model_name", length = 50, nullable = false)
    private String modelName;

    @Column(name = "path", length = 100, nullable = false)
    private String path;

    @Column(name = "position_x", precision = 20, scale = 15, nullable = false)
    private BigDecimal positionX;

    @Column(name = "position_y", precision = 20, scale = 15, nullable = false)
    private BigDecimal positionY;

    @Column(name = "position_z", precision = 20, scale = 15, nullable = false)
    private BigDecimal positionZ;

    @Column(name = "local_position_x", precision = 20, scale = 15, nullable = false)
    private BigDecimal localPositionX;

    @Column(name = "local_position_y", precision = 20, scale = 15, nullable = false)
    private BigDecimal localPositionY;

    @Column(name = "local_position_z", precision = 20, scale = 15, nullable = false)
    private BigDecimal localPositionZ;

    @Column(name = "rotation_x", precision = 20, scale = 15, nullable = false)
    private BigDecimal rotationX;

    @Column(name = "rotation_y", precision = 20, scale = 15, nullable = false)
    private BigDecimal rotationY;

    @Column(name = "rotation_z", precision = 20, scale = 15, nullable = false)
    private BigDecimal rotationZ;

    @Column(name = "rotation_w", precision = 20, scale = 15, nullable = false)
    private BigDecimal rotationW;

    @Column(name = "local_rotation_x", precision = 20, scale = 15, nullable = false)
    private BigDecimal localRotationX;

    @Column(name = "local_rotation_y", precision = 20, scale = 15, nullable = false)
    private BigDecimal localRotationY;

    @Column(name = "local_rotation_z", precision = 20, scale = 15, nullable = false)
    private BigDecimal localRotationZ;

    @Column(name = "local_rotation_w", precision = 20, scale = 15, nullable = false)
    private BigDecimal localRotationW;

    @Column(name = "scale_x", precision = 20, scale = 15, nullable = false)
    private BigDecimal scaleX;

    @Column(name = "scale_y", precision = 20, scale = 15, nullable = false)
    private BigDecimal scaleY;

    @Column(name = "scale_z", precision = 20, scale = 15, nullable = false)
    private BigDecimal scaleZ;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public BigDecimal getPositionX() {
        return positionX;
    }

    public void setPositionX(BigDecimal positionX) {
        this.positionX = positionX;
    }

    public BigDecimal getPositionY() {
        return positionY;
    }

    public void setPositionY(BigDecimal positionY) {
        this.positionY = positionY;
    }

    public BigDecimal getPositionZ() {
        return positionZ;
    }

    public void setPositionZ(BigDecimal positionZ) {
        this.positionZ = positionZ;
    }

    public BigDecimal getLocalPositionX() {
        return localPositionX;
    }

    public void setLocalPositionX(BigDecimal localPositionX) {
        this.localPositionX = localPositionX;
    }

    public BigDecimal getLocalPositionY() {
        return localPositionY;
    }

    public void setLocalPositionY(BigDecimal localPositionY) {
        this.localPositionY = localPositionY;
    }

    public BigDecimal getLocalPositionZ() {
        return localPositionZ;
    }

    public void setLocalPositionZ(BigDecimal localPositionZ) {
        this.localPositionZ = localPositionZ;
    }

    public BigDecimal getRotationX() {
        return rotationX;
    }

    public void setRotationX(BigDecimal rotationX) {
        this.rotationX = rotationX;
    }

    public BigDecimal getRotationY() {
        return rotationY;
    }

    public void setRotationY(BigDecimal rotationY) {
        this.rotationY = rotationY;
    }

    public BigDecimal getRotationZ() {
        return rotationZ;
    }

    public void setRotationZ(BigDecimal rotationZ) {
        this.rotationZ = rotationZ;
    }

    public BigDecimal getRotationW() {
        return rotationW;
    }

    public void setRotationW(BigDecimal rotationW) {
        this.rotationW = rotationW;
    }

    public BigDecimal getLocalRotationX() {
        return localRotationX;
    }

    public void setLocalRotationX(BigDecimal localRotationX) {
        this.localRotationX = localRotationX;
    }

    public BigDecimal getLocalRotationY() {
        return localRotationY;
    }

    public void setLocalRotationY(BigDecimal localRotationY) {
        this.localRotationY = localRotationY;
    }

    public BigDecimal getLocalRotationZ() {
        return localRotationZ;
    }

    public void setLocalRotationZ(BigDecimal localRotationZ) {
        this.localRotationZ = localRotationZ;
    }

    public BigDecimal getLocalRotationW() {
        return localRotationW;
    }

    public void setLocalRotationW(BigDecimal localRotationW) {
        this.localRotationW = localRotationW;
    }

    public BigDecimal getScaleX() {
        return scaleX;
    }

    public void setScaleX(BigDecimal scaleX) {
        this.scaleX = scaleX;
    }

    public BigDecimal getScaleY() {
        return scaleY;
    }

    public void setScaleY(BigDecimal scaleY) {
        this.scaleY = scaleY;
    }

    public BigDecimal getScaleZ() {
        return scaleZ;
    }

    public void setScaleZ(BigDecimal scaleZ) {
        this.scaleZ = scaleZ;
    }
}
