import 'package:capstone/data/datasources/post_remote_data_source.dart';
import 'package:capstone/domain/entities/post.dart';
import 'package:capstone/domain/repositories/post_repository.dart';
import 'package:capstone/utils/exception.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Post>>> getPost() async {
    try {
      final result = await remoteDataSource.getPost();

      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, Post>> getPostById(int id) async {
    try {
      final result = await remoteDataSource.getPostById(id);

      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, String>> createPost(
      String username, String description, String imageUrl) async {
    try {
      final result = await remoteDataSource.createPost(username, description, imageUrl);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, String>> deletePostById(int id) async {
    try {
      final result = await remoteDataSource.deletePostById(id);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }
}
