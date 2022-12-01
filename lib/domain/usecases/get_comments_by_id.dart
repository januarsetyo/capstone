import 'package:capstone/domain/entities/comments.dart';
import 'package:capstone/domain/repositories/comments_repository.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetCommentsById {
  final CommentsRepository repository;

  GetCommentsById(this.repository);

  Future<Either<Failure, List<Comments>>> execute(int commentId) {
    return repository.getCommentsById(commentId);
  }
}
