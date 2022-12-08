const express = require('express');
const userRouter = express.Router();

const { createProfilePicture, getProfilePicture, deleteProfilePictureById } = require('../controllers/UserController');

userRouter.post('/', createProfilePicture);
userRouter.get('/:userId', getProfilePicture);
userRouter.delete('/:userId', deleteProfilePictureById);

module.exports = { userRouter };
