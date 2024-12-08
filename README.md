# Astro 多语言博客项目创建手册

## 项目概述

这是一个使用 Astro 和 MySQL 构建的多语言博客系统，支持中英文内容管理，采用现代化的设计风格。

## 技术栈

- Astro: 静态站点生成框架
- MySQL: 数据库
- Tailwind CSS: 样式框架
- Node.js: 运行环境

## 项目创建步骤

### 1. 初始化项目

```bash
# 创建新的 Astro 项目
npm create astro@latest astro-p1
cd astro-p1

# 安装依赖
npm install mysql2 dotenv
```

### 2. 添加 Tailwind CSS

```bash
# 安装 Tailwind CSS 和相关依赖
npm install -D tailwindcss @astrojs/tailwind @tailwindcss/typography
```

创建 `tailwind.config.mjs`:
```javascript
/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
```

### 3. 配置数据库

创建 `.env` 文件：
```env
DB_HOST=localhost
DB_USER=astrop1
DB_PASS=123456
DB_NAME=astro_blog
```

### 4. 数据库结构

```sql
-- 创建数据库
CREATE DATABASE astro_blog;
USE astro_blog;

-- 语言表
CREATE TABLE languages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(50) NOT NULL
);

-- 分类表
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    slug VARCHAR(100) NOT NULL UNIQUE
);

-- 分类翻译表
CREATE TABLE category_translations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT NOT NULL,
    language_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (language_id) REFERENCES languages(id)
);

-- 文章表
CREATE TABLE posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    slug VARCHAR(200) NOT NULL UNIQUE,
    category_id INT NOT NULL,
    publish_date DATETIME NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- 文章翻译表
CREATE TABLE post_translations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT NOT NULL,
    language_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (language_id) REFERENCES languages(id)
);
```

### 5. 项目结构

```
astro-p1/
├── src/
│   ├── components/    # 可重用组件
│   ├── layouts/       # 布局组件
│   ├── pages/         # 路由页面
│   │   └── [lang]/    # 多语言路由
│   └── data/          # 数据访问层
├── public/            # 静态资源
├── .env              # 环境变量
├── astro.config.mjs   # Astro 配置
└── tailwind.config.mjs # Tailwind 配置
```

### 6. 关键文件说明

#### 数据访问层 (src/data/db.js)
```javascript
import mysql from 'mysql2/promise';
import 'dotenv/config';

export const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});
```

#### 基础布局 (src/layouts/BaseLayout.astro)
- 包含导航栏
- 响应式设计
- 深色主题

#### 多语言路由 (src/pages/[lang]/*)
- 动态路由支持
- SEO 优化
- 分类和文章页面

## 开发命令

```bash
# 开发环境
npm run dev

# 构建
npm run build

# 预览构建结果
npm run preview
```

## 注意事项

1. 确保 MySQL 服务已启动
2. 检查 .env 文件中的数据库配置
3. 运行前先导入数据库结构

## 下一步计划

- [ ] 添加文章评论功能
- [ ] 实现文章搜索
- [ ] 添加用户认证
- [ ] 优化移动端体验

## 贡献指南

1. Fork 项目
2. 创建特性分支
3. 提交改动
4. 发起 Pull Request

## 许可证

MIT
