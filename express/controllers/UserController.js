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
      limit: 1,
      where: {
        userId: req.params.userId,
      },
      order: [['createdAt', 'DESC']],
    });

    res.status(200).json(response);
  } catch (err) {
    console.log(err.message);
  }
};

const deleteProfilePictureById = async (req, res) => {
  try {
    await User.destroy({
      where: {
        userId: req.params.userId,
      },
    });

    res.status(200).json('Profile Picture Has Been Deleted !');
  } catch (err) {
    console.log(err.message);
  }
};

module.exports = { createProfilePicture, getProfilePicture, deleteProfilePictureById };
