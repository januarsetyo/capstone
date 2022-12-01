import 'package:capstone/domain/repositories/comments_repository.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class CreateComments {
  final CommentsRepository repository;

  CreateComments(this.repository);

  Future<Either<Failure, String>> execute(int commentId, String name, String comments) {
    return repository.createComments(commentId, name, comments);
  }
}
