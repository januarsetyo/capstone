const { Sequelize } = require('sequelize');
const { db } = require('../config/Database');
const moment = require('moment');

const { DataTypes } = Sequelize;

const Article = db.define(
  'article',
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    title: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    url: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    createdAt: {
      type: DataTypes.DATE,
      allowNull: false,
      get() {
        return moment(this.getDataValue('createdAt')).fromNow();
      },
    },
    updatedAt: {
      type: DataTypes.DATE,
      allowNull: false,
      get() {
        return moment(this.getDataValue('updatedAt')).fromNow();
      },
    },
  },
  {
    freezeTableName: true,
  }
);

module.exports = { Article };

(async () => {
  await db.sync();
})();
