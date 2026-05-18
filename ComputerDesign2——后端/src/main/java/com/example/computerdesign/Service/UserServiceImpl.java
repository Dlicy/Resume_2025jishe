package com.example.computerdesign.Service;

import com.example.computerdesign.DAO.User;
import com.example.computerdesign.DAO.UserRepository;

import com.example.computerdesign.DAO.VerificationCodeRepository;
import com.example.computerdesign.DTO.UpdateUserDTO;
import com.example.computerdesign.DTO.UserDTO;
import com.example.computerdesign.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository; // 用户数据访问对象

    @Autowired
    private VerificationCodeRepository verificationCodeRepository;

    @Override
    @Transactional
    public User registerUser(String email, String password, String code) {
        // 验证验证码逻辑（略）
        verificationCodeRepository.deleteByEmail(email);

        User user = new User();
        user.setEmail(email);
        user.setPassword(password); // 密码应进行加密处理
        user.setUsername("未知用户"); // 生成用户名
        user.setAvatar(null); // 默认头像
        user.setPower(0); // 默认权限
        user.setCreatedAt(LocalDateTime.now()); // 设置注册时间

        return userRepository.save(user); // 保存用户并返回
    }

    public Page<UserDTO> getUsers(String search, int page, int size, String[] sort) {
        Sort.Direction direction = sort[1].equalsIgnoreCase("desc") ? Sort.Direction.DESC : Sort.Direction.ASC;
        Pageable pageable = PageRequest.of(page, size, Sort.by(direction, sort[0]));

        if (search != null && !search.isEmpty()) {
            return userRepository.searchUsers(search, pageable)
                    .map(this::convertToDTO);
        }

        return userRepository.findAll(pageable)
                .map(this::convertToDTO);
    }

    public UserDTO getUserById(Long id) {
        return userRepository.findById(id)
                .map(this::convertToDTO)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    }

    public UserDTO updateUser(Long id, UpdateUserDTO dto) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        if (dto.getUsername() != null) {
            user.setUsername(dto.getUsername());
        }
        if (dto.getAvatar() != null) {
            user.setAvatar(dto.getAvatar());
        }

        User updatedUser = userRepository.save(user);
        return convertToDTO(updatedUser);
    }

    public void deleteUser(Long id) {
        if (!userRepository.existsById(id)) {
            throw new ResourceNotFoundException("User not found");
        }
        userRepository.deleteById(id);
    }

    private UserDTO convertToDTO(User user) {
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setAvatar(user.getAvatar());
        dto.setEmail(user.getEmail());
        dto.setCreatedAt(user.getCreatedAt());
        return dto;
    }


}