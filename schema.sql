-- Create database
CREATE DATABASE IF NOT EXISTS astro_blog;
USE astro_blog;

-- Create languages table
CREATE TABLE languages (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(10) NOT NULL,
  name VARCHAR(100) NOT NULL
);

-- Create categories table
CREATE TABLE categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  slug VARCHAR(100) NOT NULL UNIQUE
);

-- Create category translations table
CREATE TABLE category_translations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,
  language_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(id),
  FOREIGN KEY (language_id) REFERENCES languages(id)
);

-- Create posts table
CREATE TABLE posts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  slug VARCHAR(100) NOT NULL UNIQUE,
  category_id INT NOT NULL,
  publish_date DATETIME NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Create post translations table
CREATE TABLE post_translations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  post_id INT NOT NULL,
  language_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  FOREIGN KEY (post_id) REFERENCES posts(id),
  FOREIGN KEY (language_id) REFERENCES languages(id)
);

-- Insert sample data
-- Languages
INSERT INTO languages (code, name) VALUES
  ('en', 'English'),
  ('en-US', 'English (US)'),
  ('en-GB', 'English (UK)'),
  ('en-CA', 'English (Canada)'),
  ('zh', '中文'),
  ('zh-hk', '繁體中文 (香港)'),
  ('zh-tw', '繁體中文 (台灣)'),
  ('ja', '日本語'),
  ('ko', '한국어'),
  ('hi', 'हिन्दी'),
  ('ms', 'Bahasa Melayu'),
  ('id', 'Bahasa Indonesia'),
  ('fr', 'Français'),
  ('fr-CA', 'Français (Canada)'),
  ('tl', 'Tagalog'),
  ('vi', 'Tiếng Việt');

-- Categories
INSERT INTO categories (slug) VALUES
  ('tech'),
  ('life');

-- Category translations
INSERT INTO category_translations (category_id, language_id, name) VALUES
  -- Technology category translations
  (1, (SELECT id FROM languages WHERE code = 'en'), 'Technology'),
  (1, (SELECT id FROM languages WHERE code = 'en-US'), 'Technology'),
  (1, (SELECT id FROM languages WHERE code = 'en-GB'), 'Technology'),
  (1, (SELECT id FROM languages WHERE code = 'en-CA'), 'Technology'),
  (1, (SELECT id FROM languages WHERE code = 'zh'), '技术'),
  (1, (SELECT id FROM languages WHERE code = 'zh-hk'), '技術'),
  (1, (SELECT id FROM languages WHERE code = 'zh-tw'), '技術'),
  (1, (SELECT id FROM languages WHERE code = 'ja'), 'テクノロジー'),
  (1, (SELECT id FROM languages WHERE code = 'ko'), '기술'),
  (1, (SELECT id FROM languages WHERE code = 'hi'), 'प्रौद्योगिकी'),
  (1, (SELECT id FROM languages WHERE code = 'ms'), 'Teknologi'),
  (1, (SELECT id FROM languages WHERE code = 'id'), 'Teknologi'),
  (1, (SELECT id FROM languages WHERE code = 'fr'), 'Technologie'),
  (1, (SELECT id FROM languages WHERE code = 'fr-CA'), 'Technologie'),
  (1, (SELECT id FROM languages WHERE code = 'tl'), 'Teknolohiya'),
  (1, (SELECT id FROM languages WHERE code = 'vi'), 'Công nghệ'),

  -- Life category translations
  (2, (SELECT id FROM languages WHERE code = 'en'), 'Life'),
  (2, (SELECT id FROM languages WHERE code = 'en-US'), 'Life'),
  (2, (SELECT id FROM languages WHERE code = 'en-GB'), 'Life'),
  (2, (SELECT id FROM languages WHERE code = 'en-CA'), 'Life'),
  (2, (SELECT id FROM languages WHERE code = 'zh'), '生活'),
  (2, (SELECT id FROM languages WHERE code = 'zh-hk'), '生活'),
  (2, (SELECT id FROM languages WHERE code = 'zh-tw'), '生活'),
  (2, (SELECT id FROM languages WHERE code = 'ja'), '生活'),
  (2, (SELECT id FROM languages WHERE code = 'ko'), '생활'),
  (2, (SELECT id FROM languages WHERE code = 'hi'), 'जीवन'),
  (2, (SELECT id FROM languages WHERE code = 'ms'), 'Kehidupan'),
  (2, (SELECT id FROM languages WHERE code = 'id'), 'Kehidupan'),
  (2, (SELECT id FROM languages WHERE code = 'fr'), 'Vie'),
  (2, (SELECT id FROM languages WHERE code = 'fr-CA'), 'Vie'),
  (2, (SELECT id FROM languages WHERE code = 'tl'), 'Buhay'),
  (2, (SELECT id FROM languages WHERE code = 'vi'), 'Cuộc sống');

-- Sample posts
INSERT INTO posts (slug, category_id, publish_date) VALUES
  ('hello-world', 1, '2024-01-01 12:00:00'),
  ('my-first-blog', 2, '2024-01-02 12:00:00');

-- Post translations
INSERT INTO post_translations (post_id, language_id, title, content) VALUES
  -- Hello World post translations
  (1, (SELECT id FROM languages WHERE code = 'en'), 'Hello World', 'This is my first technical blog post.'),
  (1, (SELECT id FROM languages WHERE code = 'en-US'), 'Hello World', 'This is my first technical blog post.'),
  (1, (SELECT id FROM languages WHERE code = 'en-GB'), 'Hello World', 'This is my first technical blog post.'),
  (1, (SELECT id FROM languages WHERE code = 'en-CA'), 'Hello World', 'This is my first technical blog post.'),
  (1, (SELECT id FROM languages WHERE code = 'zh'), '你好，世界', '这是我的第一篇技术博客。'),
  (1, (SELECT id FROM languages WHERE code = 'zh-hk'), '你好，世界', '這是我的第一篇技術博客。'),
  (1, (SELECT id FROM languages WHERE code = 'zh-tw'), '你好，世界', '這是我的第一篇技術博客。'),
  (1, (SELECT id FROM languages WHERE code = 'ja'), 'こんにちは、世界', 'これは私の最初の技術ブログ記事です。'),
  (1, (SELECT id FROM languages WHERE code = 'ko'), '안녕하세요, 세계', '이것은 제 첫 번째 기술 블로그 게시물입니다.'),
  (1, (SELECT id FROM languages WHERE code = 'hi'), 'नमस्ते दुनिया', 'यह मेरी पहली तकनीकी ब्लॉग पोस्ट है।'),
  (1, (SELECT id FROM languages WHERE code = 'ms'), 'Hai Dunia', 'Ini adalah catatan blog teknikal pertama saya.'),
  (1, (SELECT id FROM languages WHERE code = 'id'), 'Halo Dunia', 'Ini adalah posting blog teknis pertama saya.'),
  (1, (SELECT id FROM languages WHERE code = 'fr'), 'Bonjour le Monde', 'Ceci est mon premier article de blog technique.'),
  (1, (SELECT id FROM languages WHERE code = 'fr-CA'), 'Bonjour le Monde', 'Ceci est mon premier article de blog technique.'),
  (1, (SELECT id FROM languages WHERE code = 'tl'), 'Kumusta Mundo', 'Ito ang aking unang technical blog post.'),
  (1, (SELECT id FROM languages WHERE code = 'vi'), 'Xin chào Thế giới', 'Đây là bài viết blog kỹ thuật đầu tiên của tôi.'),

  -- My First Blog post translations
  (2, (SELECT id FROM languages WHERE code = 'en'), 'My First Blog', 'Welcome to my personal blog about life.'),
  (2, (SELECT id FROM languages WHERE code = 'en-US'), 'My First Blog', 'Welcome to my personal blog about life.'),
  (2, (SELECT id FROM languages WHERE code = 'en-GB'), 'My First Blog', 'Welcome to my personal blog about life.'),
  (2, (SELECT id FROM languages WHERE code = 'en-CA'), 'My First Blog', 'Welcome to my personal blog about life.'),
  (2, (SELECT id FROM languages WHERE code = 'zh'), '我的第一篇博客', '欢迎来到我的生活博客。'),
  (2, (SELECT id FROM languages WHERE code = 'zh-hk'), '我的第一篇博客', '歡迎來到我的生活博客。'),
  (2, (SELECT id FROM languages WHERE code = 'zh-tw'), '我的第一篇博客', '歡迎來到我的生活博客。'),
  (2, (SELECT id FROM languages WHERE code = 'ja'), '私の最初のブログ', '私の生活ブログへようこそ。'),
  (2, (SELECT id FROM languages WHERE code = 'ko'), '내 첫 번째 블로그', '제 생활 블로그에 오신 것을 환영합니다.'),
  (2, (SELECT id FROM languages WHERE code = 'hi'), 'मेरा पहला ब्लॉग', 'मेरे जीवन के बारे में ब्लॉग में आपका स्वागत है।'),
  (2, (SELECT id FROM languages WHERE code = 'ms'), 'Blog Pertama Saya', 'Selamat datang ke blog peribadi saya tentang kehidupan.'),
  (2, (SELECT id FROM languages WHERE code = 'id'), 'Blog Pertama Saya', 'Selamat datang di blog pribadi saya tentang kehidupan.'),
  (2, (SELECT id FROM languages WHERE code = 'fr'), 'Mon Premier Blog', 'Bienvenue sur mon blog personnel sur la vie.'),
  (2, (SELECT id FROM languages WHERE code = 'fr-CA'), 'Mon Premier Blog', 'Bienvenue sur mon blog personnel sur la vie.'),
  (2, (SELECT id FROM languages WHERE code = 'tl'), 'Ang Aking Unang Blog', 'Maligayang pagdating sa aking personal na blog tungkol sa buhay.'),
  (2, (SELECT id FROM languages WHERE code = 'vi'), 'Blog Đầu Tiên Của Tôi', 'Chào mừng đến với blog cá nhân về cuộc sống của tôi.');
