import 'package:capstone/data/datasources/article_remote_data_source.dart';
import 'package:capstone/data/repositories/article_repository_impl.dart';
import 'package:capstone/domain/repositories/article_repository.dart';
import 'package:capstone/domain/usecases/get_article.dart';
import 'package:capstone/presentation/provider/article_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => ArticleNotifier(
      locator(),
    ),
  );

  // usecases
  locator.registerLazySingleton(() => GetArticle(locator()));

  // repository
  locator.registerLazySingleton<ArticleRespository>(
    () => ArticleRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<ArticleRemoteDataSource>(
    () => ArticleRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
