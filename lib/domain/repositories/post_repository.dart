import 'package:capstone/domain/entities/post.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPost();
  Future<Either<Failure, Post>> getPostById(int id);
  Future<Either<Failure, String>> createPost(String username, String description);
  Future<Either<Failure, String>> deletePostById(int id);
}
