import 'package:capstone/domain/entities/post.dart';
import 'package:capstone/domain/repositories/post_repository.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetPost {
  final PostRepository repository;

  GetPost(this.repository);

  Future<Either<Failure, List<Post>>> execute() {
    return repository.getPost();
  }
}
