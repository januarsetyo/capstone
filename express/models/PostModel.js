const { Sequelize } = require('sequelize');
const { db } = require('../config/Database');
const moment = require('moment');

const { DataTypes } = Sequelize;

const Post = db.define(
  'post',
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },

    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    imageUrl: {
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

module.exports = { Post };

(async () => {
  await db.sync();
})();
