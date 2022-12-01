import 'package:capstone/domain/repositories/post_repository.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class DeletePostById {
  final PostRepository repository;

  DeletePostById(this.repository);

  Future<Either<Failure, String>> execute(int id) {
    return repository.deletePostById(id);
  }
}
