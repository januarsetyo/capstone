const { Sequelize } = require('sequelize');
const { db } = require('../config/Database');
const moment = require('moment');

const { DataTypes } = Sequelize;

const Comments = db.define(
  'comments',
  {
    commentId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    comments: {
      type: DataTypes.TEXT,
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

Comments.removeAttribute('id');

module.exports = { Comments };

(async () => {
  await db.sync();
})();
