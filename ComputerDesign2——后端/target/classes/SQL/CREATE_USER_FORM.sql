CREATE TABLE User (
    id BIGINT AUTO_INCREMENT PRIMARY KEY, -- ⽤户唯⼀标识，⾃增主键
    username VARCHAR(255) NOT NULL, -- ⽤户名，格式为 id+号⽤户
    avatar VARCHAR(255) DEFAULT NULL, -- ⽤户头像，默认值为 null
    power INT DEFAULT 0, -- ⽤户⻆⾊权限，默认值为 0
    email VARCHAR(255) NOT NULL UNIQUE, -- ⽤户邮箱，唯⼀
    password VARCHAR(255) NOT NULL, -- ⽤户密码
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP -- 注册时间，默认当前时间
);