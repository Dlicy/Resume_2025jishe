-- 创建学习时间表
-- 创建study_records表（完全匹配user表属性）
CREATE TABLE study_records (
                               id BIGINT NOT NULL AUTO_INCREMENT,
                               user_id BIGINT NOT NULL,
                               study_time INT NOT NULL COMMENT '学习时间(分钟)',
                               study_date DATE NOT NULL COMMENT '学习日期(年-月-日)',
                               last_modified TIME COMMENT '最后修改时间(小时:分钟)',
                               created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               PRIMARY KEY (id),
                               FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- 创建索引以提高查询性能
CREATE INDEX idx_study_date ON study_records(study_date);
CREATE INDEX idx_user_study ON study_records(user_id, study_date);



-- 更新表单
ALTER TABLE study_records
ADD COLUMN book_time INT NOT NULL DEFAULT 0 COMMENT '书籍学习分钟数',
ADD COLUMN herb_time INT NOT NULL DEFAULT 0 COMMENT '中药百科学习分钟数',
ADD COLUMN formula_time INT NOT NULL DEFAULT 0 COMMENT '方剂百科学习分钟数',
ADD COLUMN other_time INT NOT NULL DEFAULT 0 COMMENT '其他模块学习分钟数';

-- 更新索引以支持按模块查询
CREATE INDEX idx_module_times ON study_records(user_id, study_date, book_time, herb_time, formula_time);