package com.example.computerdesign.Controller;

import com.example.computerdesign.DAO.User;
import com.example.computerdesign.DAO.UserRepository;
import com.example.computerdesign.DAO.VerificationCodeRepository;
import com.example.computerdesign.DTO.UpdateUserDTO;
import com.example.computerdesign.DTO.User.UpdateUsernameDTO;
import com.example.computerdesign.DTO.UserDTO;
import com.example.computerdesign.Response;
import com.example.computerdesign.Service.UserService;
import com.example.computerdesign.Utils.JwtUtil;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.nio.file.Path;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/User") // 设置分路由头
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private VerificationCodeRepository verificationCodeRepository;
    @Autowired
    private UserRepository userRepository;

    @Value("${User_Avatar_Show_Url}")
    private String AvatarShowUrl;


    @Value("${User_Avatar_Default_Url}")
    private String DefalutAvatar;
    @Value("${User_Avatar_Upload_Dir}")
    private String UploadAvatarDir;

    @PostMapping("/register")
    public Response register(@RequestParam String email,
                                     @RequestParam String password,
                                     @RequestParam String code) {
        // 查找与邮箱对应的验证码
        String storedCode = verificationCodeRepository.findByEmail(email).getCode();

        // 验证验证码是否一致
        if (storedCode == null || !storedCode.equals(code)) {
            return Response.newFail("Register failed: Invalid verification code");
        }
        System.out.println(code);

        // 验证通过，注册用户
        User newUser = userService.registerUser(email, password, code);
        if (newUser != null) {
            return Response.newSuccess("Register success: " + newUser.getUsername());
        } else {
            return Response.newFail("Register failed: User already exists");
        }
    }

    @PostMapping("/login")
    public Response login(@RequestParam String email,
                             @RequestParam String password) {
        System.out.println("123");

        if(userRepository.findByEmail(email).getPassword().equals(password)) {
            System.out.println(email);
            Map<String, Object> claims = new HashMap<>();
            claims.put("id", userRepository.findByEmail(email).getId());
            claims.put("username", userRepository.findByEmail(email).getUsername());
            String token = JwtUtil.genToken(claims);
            // 创建一个包含 token 的 JSON 对象
            Map<String, Object> responseBody = new HashMap<>();
            responseBody.put("token", token);
            responseBody.put("id", userRepository.findByEmail(email).getId());
            responseBody.put("username", userRepository.findByEmail(email).getUsername());
            responseBody.put("email", email);
            String avatar = userRepository.findByEmail(email).getAvatar();
            if (avatar == null || avatar.isEmpty()) {
                avatar = DefalutAvatar; // 替换为您的默认头像路径
            }
            responseBody.put("avatar", avatar);
            responseBody.put("result", "登录成功！");
            return Response.newSuccess(responseBody);
        }else{
            return Response.newFail("Login failed");
        }


    }

    @GetMapping
    public ResponseEntity<Page<UserDTO>> getUsers(
            @RequestParam(required = false) String search,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "createdAt,desc") String[] sort) {



        Page<UserDTO> result = userService.getUsers(search, page, size, sort)
                .map(dto -> {
                    if (dto.getAvatar() == null || dto.getAvatar().isEmpty()) {
                        dto.setAvatar(DefalutAvatar);
                    } else {
                        dto.setAvatar(AvatarShowUrl + dto.getAvatar());
                    }
                    return dto;
                });

        return ResponseEntity.ok(result);
    }

    @GetMapping("/{id}")
    public ResponseEntity<UserDTO> getUserById(@PathVariable Long id) {
        return ResponseEntity.ok(userService.getUserById(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<UserDTO> updateUser(
            @PathVariable Long id,
            @Valid @RequestBody UpdateUserDTO dto) {
        return ResponseEntity.ok(userService.updateUser(id, dto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        userService.deleteUser(id);
        return ResponseEntity.noContent().build();
    }

    // 分开两个接口处理更清晰
    @PutMapping("/update-username")
    public Response updateUsername(
            @RequestHeader("Authorization") String token,
            @RequestBody UpdateUsernameDTO dto) {
        try {
            Long userId = getUserIdFromToken(token);
            User user = userRepository.findById(userId).orElseThrow();

            if(dto.getUsername() == null || dto.getUsername().trim().isEmpty()) {
                return Response.newFail("用户名不能为空");
            }

            // 检查用户名是否已存在
            if(userRepository.existsByUsernameAndIdNot(dto.getUsername(), userId)) {
                return Response.newFail("用户名已存在");
            }

            user.setUsername(dto.getUsername());
            userRepository.save(user);

            return Response.newSuccess("用户名更新成功");
        } catch (Exception e) {
            return Response.newFail("更新失败: " + e.getMessage());
        }
    }

    @PostMapping("/update-avatar")
    public Response updateAvatar(
            @RequestHeader("Authorization") String token,
            @RequestParam("avatar") MultipartFile file) {
        try {
            if (file.isEmpty()) {
                return Response.newFail("请选择头像文件");
            }

            Long userId = getUserIdFromToken(token);
            User user = userRepository.findById(userId).orElseThrow();

            // 创建上传目录
            File dir = new File(UploadAvatarDir);
            if (!dir.exists()) dir.mkdirs();

            System.out.println(UploadAvatarDir);

            // 生成唯一文件名
            String filename = userId + "_" + System.currentTimeMillis() +
                    file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));

            // 保存文件
            Path path = Paths.get(UploadAvatarDir + filename);
            Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

            // 更新数据库
            user.setAvatar(filename); // 存储访问路径
            userRepository.save(user);

            return Response.newSuccess(AvatarShowUrl+filename);
        } catch (Exception e) {
            return Response.newFail("头像上传失败: " + e.getMessage());
        }
    }

    private Long getUserIdFromToken(String token) {
        token = token.replace("Bearer ", "");
        Map<String, Object> claims = JwtUtil.parseToken(token);
        return ((Number) claims.get("id")).longValue();
    }



}
