import 'package:capstone/data/datasources/comments_remote_data_source.dart';
import 'package:capstone/domain/entities/comments.dart';
import 'package:capstone/domain/repositories/comments_repository.dart';
import 'package:capstone/utils/exception.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsRemoteDataSource remoteDataSource;

  CommentsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Comments>>> getCommentsById(int commentId) async {
    try {
      final result = await remoteDataSource.getCommentsById(commentId);

      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }
}
