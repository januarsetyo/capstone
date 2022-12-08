const { Sequelize } = require('sequelize');

const db = new Sequelize('curhatin_db', 'root', '', {
  host: 'localhost',
  dialect: 'mysql',
});

module.exports = { db };
