CREATE TABLE acupuncture_points (
    id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(50) NOT NULL COMMENT '穴位名称',
    path VARCHAR(100) NOT NULL COMMENT '穴位路径',

    -- 世界坐标位置
    position_x DECIMAL(20,15) NOT NULL,
    position_y DECIMAL(20,15) NOT NULL,
    position_z DECIMAL(20,15) NOT NULL,

    -- 局部坐标位置
    local_position_x DECIMAL(20,15) NOT NULL,
    local_position_y DECIMAL(20,15) NOT NULL,
    local_position_z DECIMAL(20,15) NOT NULL,

    -- 世界旋转四元数
    rotation_x DECIMAL(20,15) NOT NULL,
    rotation_y DECIMAL(20,15) NOT NULL,
    rotation_z DECIMAL(20,15) NOT NULL,
    rotation_w DECIMAL(20,15) NOT NULL,

    -- 局部旋转四元数
    local_rotation_x DECIMAL(20,15) NOT NULL,
    local_rotation_y DECIMAL(20,15) NOT NULL,
    local_rotation_z DECIMAL(20,15) NOT NULL,
    local_rotation_w DECIMAL(20,15) NOT NULL,

    -- 缩放比例
    scale_x DECIMAL(20,15) NOT NULL,
    scale_y DECIMAL(20,15) NOT NULL,
    scale_z DECIMAL(20,15) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',

    INDEX idx_model_name (model_name),
    INDEX idx_path (path)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='穴位信息表';