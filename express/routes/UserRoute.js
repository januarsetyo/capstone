const express = require('express');
const userRouter = express.Router();

const { createProfilePicture, getProfilePicture } = require('../controllers/UserController');

userRouter.post('/', createProfilePicture);
userRouter.get('/:userId', getProfilePicture);

module.exports = { userRouter };
