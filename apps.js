require('dotenv').config();
const express = require('express');
const mysql = require('mysql2/promise');
const app = express();
app.use(express.json());

const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASS || '',
  database: 'medtrack',
  waitForConnections: true,
  connectionLimit: 5
});

app.get('/api/medications', async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM medications');
  res.json(rows);
});

app.get('/api/lowstock', async (req, res) => {
  const [rows] = await pool.query(`
    SELECT m.name, SUM(i.quantity) AS total_qty
    FROM medications m JOIN inventory i ON m.med_id = i.med_id
    GROUP BY m.med_id
    HAVING total_qty <= ?
  `, [parseInt(req.query.threshold || '10')]);
  res.json(rows);
});

app.listen(3000, () => console.log('API running on port 3000'));
