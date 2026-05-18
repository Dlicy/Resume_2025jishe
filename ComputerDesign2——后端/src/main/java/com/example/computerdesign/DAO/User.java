package com.example.computerdesign.DAO;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "user")
public class User {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // 用户唯一标识

    @Column(name = "username", nullable = false)
    private String username; // 用户名

    @Column(name = "avatar")
    private String avatar; // 用户头像，默认值为 null

    @Column(name = "power")
    private Integer power = 0; // 用户角色权限，默认值为 0

    @Column(name = "email", unique = true, nullable = false)
    private String email; // 用户邮箱，唯一

    @Column(name = "password", nullable = false)
    private String password; // 用户密码

    @Column(name = "create_at", updatable = false)
    private LocalDateTime createdAt; // 注册时间

    // 默认构造函数
    public User() {
    }

    // Getter 和 Setter 方法

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public Integer getPower() {
        return power;
    }

    public void setPower(Integer power) {
        this.power = power;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now(); // 在创建时设置注册时间
    }

}