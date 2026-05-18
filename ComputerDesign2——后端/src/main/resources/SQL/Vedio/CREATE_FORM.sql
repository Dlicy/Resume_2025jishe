
-- 2. 视频表(video)
CREATE TABLE IF NOT EXISTS `video` (
                                       `id` bigint NOT NULL AUTO_INCREMENT,
                                       `title` varchar(255) NOT NULL,
    `author_id` bigint NOT NULL,
    `duration` int NOT NULL COMMENT '视频时长(秒)',
    `video_path` varchar(255) NOT NULL COMMENT '视频存储路径',
    `upload_time` datetime DEFAULT CURRENT_TIMESTAMP,
    `views` int DEFAULT '0' COMMENT '观看次数',
    `description` text COMMENT '视频描述',
    `cover_image` varchar(255) COMMENT '封面图片路径',
    `status` tinyint(1) DEFAULT '1' COMMENT '状态:1-正常,0-下架',
    PRIMARY KEY (`id`),
    KEY `author_id` (`author_id`),
    CONSTRAINT `video_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 3. 课程/专题表(course)
CREATE TABLE IF NOT EXISTS `course` (
                                        `id` bigint NOT NULL AUTO_INCREMENT,
                                        `title` varchar(255) NOT NULL,
    `description` text COMMENT '课程描述',
    `creator_id` bigint NOT NULL DEFAULT '0' COMMENT '0表示管理员创建',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
    `cover_image` varchar(255) COMMENT '封面图片路径',
    PRIMARY KEY (`id`)
    -- 注意：creator_id 没有设置外键约束，因为允许0值(管理员)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 4. 课程视频关联表(course_video)
CREATE TABLE IF NOT EXISTS `course_video` (
      `id` bigint NOT NULL AUTO_INCREMENT,
      `course_id` bigint NOT NULL,
      `video_id` bigint NOT NULL,
      `order` int DEFAULT '0' COMMENT '视频在课程中的顺序',
      `chapter` varchar(100) COMMENT '章节名称',
    `chapter_order` int DEFAULT '0' COMMENT '章节顺序',
    PRIMARY KEY (`id`),
    UNIQUE KEY `course_video_unique` (`course_id`,`video_id`),
    KEY `video_id` (`video_id`),
    CONSTRAINT `course_video_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE,
    CONSTRAINT `course_video_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `video` (`id`) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 5. 视频学习记录表(video_learning)
CREATE TABLE IF NOT EXISTS `video_learning` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint NOT NULL,
    `video_id` bigint NOT NULL,
    `is_completed` tinyint(1) DEFAULT '0' COMMENT '是否看完',
    `last_play_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后播放时间',
    `progress` int DEFAULT '0' COMMENT '学习进度百分比0-100',
    `start_time` datetime COMMENT '开始学习时间',
    `end_time` datetime COMMENT '完成学习时间',
    `duration_learned` int DEFAULT '0' COMMENT '已学习时长(秒)',
    PRIMARY KEY (`id`),
    UNIQUE KEY `user_video_unique` (`user_id`,`video_id`),
    KEY `video_id` (`video_id`),
    CONSTRAINT `video_learning_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
    CONSTRAINT `video_learning_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `video` (`id`) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 6. 课程学习记录表(course_learning)
CREATE TABLE IF NOT EXISTS `course_learning` (
                                                 `id` bigint NOT NULL AUTO_INCREMENT,
                                                 `user_id` bigint NOT NULL,
                                                 `course_id` bigint NOT NULL,
                                                 `progress` int DEFAULT '0' COMMENT '课程完成百分比',
                                                 `last_learn_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后学习时间',
                                                 `is_completed` tinyint(1) DEFAULT '0' COMMENT '是否完成',
    `start_time` datetime COMMENT '开始学习时间',
    `complete_time` datetime COMMENT '完成时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `user_course_unique` (`user_id`,`course_id`),
    KEY `course_id` (`course_id`),
    CONSTRAINT `course_learning_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
    CONSTRAINT `course_learning_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 去掉关系
ALTER TABLE video DROP FOREIGN KEY video_ibfk_1;

ALTER TABLE course_video CHANGE `order` videoorder INT;