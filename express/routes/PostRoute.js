const express = require('express');
const postRouter = express.Router();
const { getPost, createPost, getPostById, updatePost, deletePostById } = require('../controllers/PostController');

postRouter.get('/', getPost);
postRouter.get('/:id', getPostById);
postRouter.post('/', createPost);
postRouter.put('/:id', updatePost);
postRouter.delete('/:id', deletePostById);

module.exports = { postRouter };
