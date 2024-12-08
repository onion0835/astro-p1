import { pool } from './db.js';

export async function getLanguages() {
  const [rows] = await pool.query('SELECT * FROM languages');
  return rows;
}

export async function getAllCategoriesByLanguage(languageCode) {
  const [rows] = await pool.query(`
    SELECT c.slug, ct.name
    FROM categories c
    JOIN category_translations ct ON c.id = ct.category_id
    JOIN languages l ON l.id = ct.language_id
    WHERE l.code = ?
  `, [languageCode]);
  return rows;
}

export async function getAllPostsByLanguage(languageCode) {
  const [rows] = await pool.query(`
    SELECT p.slug, pt.title, p.publish_date
    FROM posts p
    JOIN post_translations pt ON p.id = pt.post_id
    JOIN languages l ON l.id = pt.language_id
    WHERE l.code = ?
    ORDER BY p.publish_date DESC
  `, [languageCode]);
  return rows;
}

export async function getPostBySlugAndLanguage(slug, languageCode) {
  const [rows] = await pool.query(`
    SELECT p.slug, pt.title, pt.content, p.publish_date,
           c.slug as category_slug, ct.name as category_name
    FROM posts p
    JOIN post_translations pt ON p.id = pt.post_id
    JOIN languages l ON l.id = pt.language_id
    JOIN categories c ON p.category_id = c.id
    JOIN category_translations ct ON c.id = ct.category_id AND ct.language_id = pt.language_id
    WHERE p.slug = ? AND l.code = ?
  `, [slug, languageCode]);
  return rows[0];
}

export async function getPostsByCategory(categorySlug, languageCode) {
  const [rows] = await pool.query(`
    SELECT p.slug, pt.title, p.publish_date
    FROM posts p
    JOIN post_translations pt ON p.id = pt.post_id
    JOIN languages l ON l.id = pt.language_id
    JOIN categories c ON p.category_id = c.id
    WHERE c.slug = ? AND l.code = ?
    ORDER BY p.publish_date DESC
  `, [categorySlug, languageCode]);
  return rows;
}
