CREATE TABLE verification_codes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    code VARCHAR(10) NOT NULL,
    sent_at DATETIME NOT NULL,
    UNIQUE KEY (email) -- 可选：确保同⼀邮箱只能有⼀个验证码
);