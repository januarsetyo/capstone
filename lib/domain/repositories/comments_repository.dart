import 'package:capstone/domain/entities/comments.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<Comments>>> getCommentsById(int commentId);
  Future<Either<Failure, String>> createComments(
      int commentId, String name, String comments);
}
