package com.example.computerdesign.DAO;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VerificationCodeRepository extends JpaRepository<VerificationCode, Integer> {
    VerificationCode findByEmail(String email);

    // 添加删除方法
    void deleteByEmail(String email);
}
