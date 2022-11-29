import 'package:capstone/domain/entities/article.dart';
import 'package:capstone/domain/repositories/articles_repository.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetArticles {
  final ArticlesRepository repository;

  GetArticles(this.repository);

  Future<Either<Failure, List<Article>>> execute() {
    return repository.getArticles();
  }
}
