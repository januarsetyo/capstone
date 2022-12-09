const { Article } = require('../models/ArticleModel');

const createArticle = async (req, res) => {
  try {
    await Article.create(req.body);

    res.status(201).json('Article Created !');
  } catch (err) {
    console.log(err.message);
  }
};

const getArticle = async (req, res) => {
  try {
    const response = await Article.findAll();

    res.status(200).json(response);
  } catch (err) {
    console.log(err.message);
  }
};

module.exports = { createArticle, getArticle };
