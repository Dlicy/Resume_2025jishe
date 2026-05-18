CREATE TABLE acupuncture_single_choice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question TEXT NOT NULL COMMENT '题目内容',
    option_a VARCHAR(255) NOT NULL COMMENT '选项A',
    option_b VARCHAR(255) NOT NULL COMMENT '选项B',
    option_c VARCHAR(255) NOT NULL COMMENT '选项C',
    option_d VARCHAR(255) NOT NULL COMMENT '选项D',
    correct_answer CHAR(10) NOT NULL COMMENT '正确答案(A/B/C/D)',
    explanation TEXT COMMENT '题目解析',

    -- 管理信息
    is_active BOOLEAN DEFAULT TRUE COMMENT '是否启用',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='中医针灸单选题库';

CREATE TABLE exam_submissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    score DECIMAL(5, 2) DEFAULT 0 COMMENT '考试成绩',
    submitted BOOLEAN DEFAULT FALSE COMMENT '是否已提交',
    submission_time DATETIME DEFAULT NULL COMMENT '提交时间',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='考试提交记录';

CREATE TABLE exam_answers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    submission_id INT NOT NULL,
    question_id INT NOT NULL,
    user_answer CHAR(10) COMMENT '用户答案',
    is_correct BOOLEAN COMMENT '是否答对',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (submission_id) REFERENCES exam_submissions(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES acupuncture_single_choice(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='考试答题记录';