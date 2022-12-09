const express = require('express');
const articleRouter = express.Router();
const { createArticle, getArticle } = require('../controllers/ArticleController');

articleRouter.post('/', createArticle);
articleRouter.get('/', getArticle);

module.exports = { articleRouter };
