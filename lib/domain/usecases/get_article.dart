import 'package:capstone/domain/entities/article.dart';
import 'package:capstone/domain/repositories/article_repository.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetArticle {
  final ArticleRespository repository;

  GetArticle(this.repository);

  Future<Either<Failure, List<Article>>> execute() {
    return repository.getArticle();
  }
}
