import 'package:capstone/domain/entities/article.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getArticle();
}
