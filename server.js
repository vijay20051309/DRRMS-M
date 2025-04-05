
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const db = require('./db');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// GET /locations - Fetch all locations
app.get('/locations', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM locations');
    res.json(rows);
  } catch (err) {
    console.error('Database error:', err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Start the server
app.listen(PORT, () => {
  console.log(` Server running at http://localhost:${PORT}`);
});
