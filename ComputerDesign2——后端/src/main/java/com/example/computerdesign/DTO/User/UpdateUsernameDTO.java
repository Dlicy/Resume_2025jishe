package com.example.computerdesign.DTO.User;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class UpdateUsernameDTO {
    @NotBlank
    private String username;
}
