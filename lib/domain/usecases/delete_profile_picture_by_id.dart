import 'package:capstone/domain/repositories/user_repository.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class DeleteProfilePictureById {
  final UserRepository repository;

  DeleteProfilePictureById(this.repository);

  Future<Either<Failure, String>> execute(String userId) {
    return repository.deleteProfilePictureById(userId);
  }
}
