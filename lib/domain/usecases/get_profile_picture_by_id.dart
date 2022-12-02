import 'package:capstone/data/models/user_model.dart';
import 'package:capstone/domain/entities/user.dart';
import 'package:capstone/domain/repositories/user_repository.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetProfilePictureById {
  final UserRepository repository;

  GetProfilePictureById(this.repository);

  Future<Either<Failure, dynamic>> execute(String userId) {
    return repository.getProfilePictureById(userId);
  }
}
