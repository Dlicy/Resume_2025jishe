CREATE TABLE formulas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name TEXT COMMENT '方剂名称',
    main_category TEXT COMMENT '方剂所属大类',
    sub_category TEXT COMMENT '方剂所属小类',
    source TEXT COMMENT '方剂出处',
    classification TEXT COMMENT '方剂分类',
    composition TEXT COMMENT '方剂组成药材及用量',
    explanation TEXT COMMENT '方剂解释',
    functions TEXT COMMENT '方剂功用',
    indications TEXT COMMENT '方剂主治',
    usage_method TEXT COMMENT '方剂用法',
    precautions TEXT COMMENT '使用注意事项'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='中医方剂数据表';