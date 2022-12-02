import 'package:capstone/domain/repositories/user_repository.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class CreateProfilePicture {
  final UserRepository repository;

  CreateProfilePicture(this.repository);

  Future<Either<Failure, String>> execute(String userId, String imageUrl) {
    return repository.createProfilePicture(userId, imageUrl);
  }
}
