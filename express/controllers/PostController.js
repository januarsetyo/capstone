const { Post } = require('../models/PostModel');

const getPost = async (req, res) => {
  try {
    const response = await Post.findAll();

    res.status(200).json(response);
  } catch (err) {
    console.log(err.message);
  }
};

const createPost = async (req, res) => {
  try {
    await Post.create(req.body);

    res.status(201).json('Post Created !');
  } catch (err) {
    console.log(err.message);
  }
};

const getPostById = async (req, res) => {
  try {
    const response = await Post.findOne({
      where: {
        id: req.params.id,
      },
    });

    res.status(200).json(response);
  } catch (err) {
    console.log(err.message);
  }
};

const updatePost = async (req, res) => {
  try {
    await Post.update(req.body, {
      where: {
        id: req.params.id,
      },
    });

    res.status(200).json('Post Updated !');
  } catch (err) {
    console.log(err.message);
  }
};

const deletePostById = async (req, res) => {
  try {
    await Post.destroy({
      where: {
        id: req.params.id,
      },
    });

    res.status(200).json('Post Deleted !');
  } catch (err) {
    console.log(err.message);
  }
};

module.exports = { getPost, createPost, getPostById, updatePost, deletePostById };
