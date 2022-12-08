const { Comments } = require('../models/CommentModel');

const getComments = async (req, res) => {
  try {
    const response = await Comments.findAll();

    res.status(200).json(response);
  } catch (err) {
    console.log(err.message);
  }
};

const createComment = async (req, res) => {
  try {
    await Comments.create(req.body);

    res.status(201).json('Comment Created !');
  } catch (err) {
    console.log(err.message);
  }
};

const getCommentById = async (req, res) => {
  try {
    const response = await Comments.findAll({
      where: {
        commentId: req.params.id,
      },
    });

    res.status(200).json(response);
  } catch (err) {
    console.log(err.message);
  }
};

module.exports = { getComments, createComment, getCommentById };
