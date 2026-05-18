package com.example.computerdesign.DTO;

import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UpdateUserDTO {
    @Size(min = 2, max = 50)
    private String username;

    private String avatar;
}