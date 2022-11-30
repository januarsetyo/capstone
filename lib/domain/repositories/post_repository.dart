import 'package:capstone/domain/entities/post.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPost();
}
