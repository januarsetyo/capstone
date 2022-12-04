import 'package:capstone/domain/repositories/post_repository.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class CreatePost {
  final PostRepository repository;

  CreatePost(this.repository);

  Future<Either<Failure, String>> execute(
    String username,
    String description,
    String imageUrl,
  ) {
    return repository.createPost(username, description, imageUrl);
  }
}
