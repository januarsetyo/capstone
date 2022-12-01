import 'package:capstone/domain/entities/post.dart';
import 'package:capstone/domain/repositories/post_repository.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetPostById {
  final PostRepository repository;

  GetPostById(this.repository);

  Future<Either<Failure, Post>> execute(int id) {
    return repository.getPostById(id);
  }
}
