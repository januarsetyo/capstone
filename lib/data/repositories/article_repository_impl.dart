import 'package:capstone/data/datasources/article_remote_data_source.dart';
import 'package:capstone/domain/entities/article.dart';
import 'package:capstone/domain/repositories/article_repository.dart';
import 'package:capstone/utils/exception.dart';
import 'package:capstone/utils/failure.dart';
import 'package:dartz/dartz.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;

  ArticleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Article>>> getArticle() async {
    try {
      final result = await remoteDataSource.getArticle();

      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }
}
