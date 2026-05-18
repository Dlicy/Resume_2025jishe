package com.example.computerdesign.DTO;

import lombok.Data;
import lombok.Value;

import java.time.LocalDateTime;

@Data
public class UserDTO {
    private Long id;
    private String username;
    private String avatar;
    private Integer power;
    private String email;
    private String password;
    private LocalDateTime createdAt;


}