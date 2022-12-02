const { Sequelize } = require('sequelize');
const { db } = require('../config/Database');

const { DataTypes } = Sequelize;

const User = db.define(
  'user',
  {
    userId: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    imageUrl: {
      type: DataTypes.STRING,
      allowNull: false,
    },
  },
  {
    freezeTableName: true,
    timestamps: false,
  }
);

User.removeAttribute('id');

module.exports = { User };

(async () => {
  await db.sync();
})();
