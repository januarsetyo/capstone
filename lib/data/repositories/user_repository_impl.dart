import 'package:capstone/data/datasources/user_remote_data_source.dart';
import 'package:capstone/domain/repositories/user_repository.dart';
import 'package:capstone/utils/exception.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> createProfilePicture(
      String userId, String imageUrl) async {
    try {
      final result = await remoteDataSource.createProfilePicture(userId, imageUrl);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getProfilePictureById(String userId) async {
    try {
      final result = await remoteDataSource.getProfilePictureById(userId);

      if (result == null) {
        return Right(null);
      } else {
        return Right(result.toEntity());
      }
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }
}
