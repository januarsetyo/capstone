const { response } = require('express');
const { User } = require('../models/UserModel');

const createProfilePicture = async (req, res) => {
  try {
    await User.create(req.body);

    res.status(201).json('Profile Picture Has Been Changed !');
  } catch (err) {
    console.log(err.message);
  }
};

const getProfilePicture = async (req, res) => {
  try {
    const response = await User.findOne({
      where: {
        userId: req.params.userId,
      },
    });

    res.status(200).json(response);
  } catch (err) {
    res.status(404);
    console.log(err.message);
  }
};

module.exports = { createProfilePicture, getProfilePicture };
