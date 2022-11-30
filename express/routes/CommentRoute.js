const express = require('express');
const commentRouter = express.Router();

const { getComments, createComment, getCommentById } = require('../controllers/CommentController');

commentRouter.get('/', getComments);
commentRouter.post('/', createComment);
commentRouter.get('/:id', getCommentById);

module.exports = { commentRouter };
