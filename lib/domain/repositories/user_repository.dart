import 'package:capstone/data/models/user_model.dart';
import 'package:capstone/domain/entities/user.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> createProfilePicture(String userId, String imageUrl);
  Future<Either<Failure, dynamic>> getProfilePictureById(String userId);
}
