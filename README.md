# 中医数字化学习平台 (TCM Digital Learning Platform)

一个集 3D 穴位可视化、中药方剂百科全书、在线课程与视频学习、知识测验考试、学习时间追踪、AI 智能问答于一体的中医数字化教育平台。曾获2025年计算机设计大赛国二

---

## 项目结构

```
├── ComputerDesign2——后端/   # Spring Boot 后端
│   └── src/main/java/com/example/computerdesign/
│       ├── config/          # CORS、Web、资源路径配置
│       ├── controller/      # REST API 控制器
│       ├── service/         # 业务逻辑层
│       ├── model/           # 实体 / 数据传输对象
│       └── util/            # 工具类（JWT、文件存储等）
│
└── ComputerDesignFront/    # Vue 3 前端
    └── src/
        ├── views/           # 页面视图
        ├── router/          # 路由配置
        ├── api/             # API 请求模块
        ├── utils/           # 工具函数（token、认证等）
        └── assets/          # 静态资源
```

---

## 技术栈

### 后端
| 组件 | 技术 |
|------|------|
| 框架 | Spring Boot 3.1.5 |
| 语言 | Java 17 |
| 构建 | Maven |
| 数据库 | MySQL |
| ORM | Spring Data JPA + MyBatis |
| 认证 | JWT (com.auth0:java-jwt) |
| 邮件 | Spring Boot Mail (QQ SMTP) |
| 文件存储 | 本地文件系统 (`./uploads/`) |
| AI 集成 | 讯飞星火大模型 (WebSocket) |
| 对象映射 | ModelMapper |
| 视频时长 | JAVE (jave-all-deps) |

### 前端
| 组件 | 技术 |
|------|------|
| 框架 | Vue 3 (Composition API + `<script setup>`) |
| 语言 | TypeScript |
| 构建 | Vite 6 |
| UI 组件库 | Element Plus |
| 路由 | Vue Router 4 |
| HTTP | Axios |
| 图表 | ECharts 5 / vue-echarts |
| 3D 引擎 | Three.js + unity-webgl |
| 图标 | Font Awesome + Element Plus Icons |
| CSS | Sass |

---

## 功能模块

### 1. 用户系统
- 邮箱验证码注册 / 登录
- JWT Token 鉴权（7 天有效期）
- 用户头像上传与个人信息编辑
- 管理员后台（用户管理、内容管理）

### 2. 3D 穴位可视化（Unity WebGL）
- 人体经络 3D 模型交互展示
- 穴位精确定位（世界坐标 + 局部坐标）
- 穴位详细信息查看（名称、经络、位置、操作说明）
- 穴位识别测验（4 选 1 选择题）
- 管理端穴位坐标 CRUD

### 3. 中药百科全书
- 中药药材库：按大类/小类浏览、全文搜索、详情查看
- 方剂库：按类别浏览、关键词搜索、详细组成与用法
- 药材图片上传
- 管理端药材/方剂 CRUD

### 4. 中医古籍图书馆
- PDF / DOCX 书籍上传与管理
- 封面图片展示、书籍网格浏览
- 在线预览与下载
- 按书名/作者搜索、分页浏览

### 5. 在线课程与视频学习
- 视频上传（自动计算时长，支持封面图）
- 课程管理（课程创建、章节排序）
- 视频轮播推荐
- 学习进度追踪（视频完成度 0-100%、学习时长）
- 课程注册 / 退课
- 今日学习列表

### 6. 知识测验系统
- 针灸单选题库（CRUD + 状态管理）
- 随机组卷生成
- 答题提交与自动评分
- 考试历史查看
- 错题回顾

### 7. 学习时间统计
- 分模块计时（书籍、药材、方剂、其他）
- 每日学习时长记录
- 过去 365 天学习热力图（GitHub 风格）
- 学习趋势折线图与模块分布图

### 8. AI 智能问答
- 集成讯飞星火大模型
- 实时对话式 AI 问答
- 在 Unity 3D 场景中嵌入 AI 对话面板

### 9. 虚拟仿真实验
- 数字化针灸操作模拟
- 分步骤操作指引（选穴、消毒、进针、留针）
- 操作评估指标面板

---

## 数据库概览

数据库名称：`Computer_Design`

核心表：
- `user` — 用户（支持普通用户/管理员）
- `herbs` — 中药药材
- `formulas` — 中医方剂
- `books` — 古籍图书
- `video` / `course` / `course_video` — 视频与课程
- `acupuncture_points` — 穴位信息
- `acupuncture_single_choice` — 针灸选择题
- `exam_submissions` / `exam_answers` — 考试提交与答案
- `study_records` — 学习时间记录
- `video_learning` / `course_learning` — 视频/课程学习进度
- `where_points` — 3D 穴位坐标
- `verification_codes` — 邮箱验证码

---

## 快速开始

### 环境要求
- **后端**：JDK 17+、MySQL 8.0+、Maven 3.8+
- **前端**：Node.js 18+、npm 9+

### 后端启动

```bash
cd ComputerDesign2——后端

# 1. 创建 MySQL 数据库
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS Computer_Design DEFAULT CHARSET utf8mb4;"

# 2. 修改 application.properties 中的数据库连接信息
#    spring.datasource.url=jdbc:mysql://localhost:3306/Computer_Design
#    spring.datasource.username=你的用户名
#    spring.datasource.password=你的密码

# 3. 启动（端口 8105）
./mvnw spring-boot:run
```

### 前端启动

```bash
cd ComputerDesignFront

# 1. 安装依赖
npm install

# 2. 配置环境变量（.env）
#    VITE_API_URL=http://localhost:8105

# 3. 开发模式启动（端口默认 5173）
npm run dev

# 4. 生产构建
npm run build
```

### Nginx 部署（生产环境）

前端构建产物通过 Nginx 提供静态服务（配置见 `ComputerDesignFront/nginx.conf`），监听端口 8104，API 代理到后端 8105 端口。

---

## API 接口概览

| 模块 | 基础路径 | 主要功能 |
|------|----------|----------|
| 用户 | `/User` | 注册、登录、信息管理 |
| 验证码 | `/Verification` | 发送邮箱验证码 |
| 书籍 | `/api/books` | 书籍 CRUD、下载、封面 |
| 视频 | `/api/videos` | 视频上传、列表、轮播 |
| 课程 | `/api/courses` | 课程管理、注册、进度 |
| 学习 | `/api/learning` | 视频/课程进度追踪 |
| 考题 | `/api/questions` | 题目 CRUD、随机组卷 |
| 考试 | `/api/exams` | 提交、历史、详情 |
| 学习时间 | `/api/study-time` | 每日学习记录与统计 |
| 百科全书 | `/Encyclopedia` | 药材分类、搜索、详情 |
| 方剂 | `/encyclopedia/formulas` | 方剂搜索、详情 |
| 3D 穴位 | `/api/unity/points` | 穴位坐标 CRUD |
| 穴位查询 | `/AcupuncturePoints` | 穴位查找、随机出题 |
| AI | `/api/ask` | 讯飞星火 AI 问答 |
| 图书馆 | `/Library` | PDF 上传与获取 |

---

## 注意事项

- 后端密码以明文存储，生产环境应增加 BCrypt 等加密机制
- JWT 密钥与讯飞 API 密钥均硬编码在代码中，部署前应移至环境变量或配置文件
- 邮箱验证码功能需要配置有效的 QQ 邮箱 SMTP 授权码
- 文件上传最大 500MB，视频文件存储在本地 `./uploads/` 目录
- 前端 `src/api/course.ts` 引用了不存在的 `@/utils/request.ts`，该模块运行时会报错，需修复
