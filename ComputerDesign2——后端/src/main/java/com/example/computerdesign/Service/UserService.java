package com.example.computerdesign.Service;

import com.example.computerdesign.DAO.User;
import com.example.computerdesign.DTO.UpdateUserDTO;
import com.example.computerdesign.DTO.UserDTO;
import org.springframework.data.domain.Page;

public interface UserService {
    // 注册用户
    User registerUser(String email, String password, String code);

    Page<UserDTO> getUsers(String search, int page, int size, String[] sort);

    UserDTO getUserById(Long id);

    UserDTO updateUser(Long id, UpdateUserDTO dto);

    void deleteUser(Long id);
}
