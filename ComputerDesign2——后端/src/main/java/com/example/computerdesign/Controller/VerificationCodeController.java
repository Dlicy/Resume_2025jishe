package com.example.computerdesign.Controller;

import com.example.computerdesign.DAO.UserRepository;
import com.example.computerdesign.Response;
import com.example.computerdesign.Service.UserService;
import com.example.computerdesign.Service.VerificationCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/Verification") // 设置分路由头
public class VerificationCodeController {


    @Autowired
    private VerificationCodeService verificationCodeService; // 注入服务

    @Autowired
    private UserRepository userRepository;

    @PostMapping(value = "/sendCode") // 处理 POST 请求
    public Response sendCode(@RequestParam String touser) {
        System.out.println("收到消息");
        System.out.println(touser);
        try {
            if(userRepository.findByEmail(touser) != null) {
                return Response.newFail("该邮箱已被注册过！");
            }
        } catch (Exception e) {
            e.printStackTrace(); // 打印异常信息
            return Response.newFail("查询用户时出错: " + e.getMessage());
        }
        System.out.println("收到消息1");
        try {
            // 生成随机验证码
            int code = (int) ((Math.random() * 9 + 1) * 1000);
            // 调用服务发送邮件
            verificationCodeService.sendSimpleMail(String.valueOf(code), touser);
            // 返回成功响应
            return Response.newSuccess(code);
        } catch (Exception e) {
            // 返回错误响应
            return Response.newFail(e.getMessage());
        }
    }
}