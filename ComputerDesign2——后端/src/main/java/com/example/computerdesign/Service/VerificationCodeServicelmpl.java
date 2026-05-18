package com.example.computerdesign.Service;
import com.example.computerdesign.DAO.VerificationCode;
import com.example.computerdesign.DAO.VerificationCodeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Date;

@Service
public class VerificationCodeServicelmpl implements VerificationCodeService {
    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private VerificationCodeRepository verificationCodeRepository; // 注入 DAO

    @Override
    @Transactional
    public void sendSimpleMail(String code, String touser) {
        // 构建一个邮件对象
        SimpleMailMessage message = new SimpleMailMessage();
        // 设置邮件主题
        message.setSubject("邮箱注册码");
        // 设置邮件发送者，这个跟application.yml中设置的要一致 username:
        message.setFrom("3521235763@qq.com");
        // 设置邮件接收者，可以有多个接收者，中间用逗号隔开，以下类似
        // message.setTo("10@qq.com","12qq.com");
        message.setTo(touser);
        // 设置邮件发送日期
        message.setSentDate(new Date());
        // 设置邮件的正文
        message.setText("邮箱注册码：" + code);
        // 发送邮件
        javaMailSender.send(message);

        // 查找现有记录
        VerificationCode existingCode = verificationCodeRepository.findByEmail(touser);
        if (existingCode != null) {
            // 更新现有记录
            existingCode.setCode(code);
            existingCode.setSentAt(LocalDateTime.now());
            verificationCodeRepository.save(existingCode);
        } else {
            // 创建新记录
            VerificationCode newVerificationCode = new VerificationCode();
            newVerificationCode.setEmail(touser);
            newVerificationCode.setCode(code);
            newVerificationCode.setSentAt(LocalDateTime.now());
            System.out.println("准备1");
            verificationCodeRepository.save(newVerificationCode);
        }
    }

}
