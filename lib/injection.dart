import 'package:capstone/domain/usecases/get_articles.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // usecases
  locator.registerLazySingleton(
    () => GetArticles(
      locator(),
    ),
  );
}
