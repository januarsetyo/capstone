import 'package:capstone/domain/entities/article.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ArticlesRepository {
  Future<Either<Failure, List<Article>>> getArticles();
}
