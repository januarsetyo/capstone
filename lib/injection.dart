import 'package:capstone/data/datasources/article_remote_data_source.dart';
import 'package:capstone/data/datasources/comments_remote_data_source.dart';
import 'package:capstone/data/datasources/post_remote_data_source.dart';
import 'package:capstone/data/datasources/user_remote_data_source.dart';
import 'package:capstone/data/repositories/article_repository_impl.dart';
import 'package:capstone/data/repositories/comments_repository_impl.dart';
import 'package:capstone/data/repositories/post_repository_impl.dart';
import 'package:capstone/data/repositories/user_repository_impl.dart';
import 'package:capstone/domain/repositories/article_repository.dart';
import 'package:capstone/domain/repositories/comments_repository.dart';
import 'package:capstone/domain/repositories/post_repository.dart';
import 'package:capstone/domain/repositories/user_repository.dart';
import 'package:capstone/domain/usecases/create_comments.dart';
import 'package:capstone/domain/usecases/create_post.dart';
import 'package:capstone/domain/usecases/create_profile_picture.dart';
import 'package:capstone/domain/usecases/delete_post_by_id.dart';
import 'package:capstone/domain/usecases/get_article.dart';
import 'package:capstone/domain/usecases/get_comments_by_id.dart';
import 'package:capstone/domain/usecases/get_post.dart';
import 'package:capstone/domain/usecases/get_post_by_id.dart';
import 'package:capstone/domain/usecases/get_profile_picture_by_id.dart';
import 'package:capstone/presentation/provider/article_notifier.dart';
import 'package:capstone/presentation/provider/comments_notifier.dart';
import 'package:capstone/presentation/provider/post_notifier.dart';
import 'package:capstone/presentation/provider/user_notifier.dart';
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
  locator.registerFactory(
    () => PostNotifier(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => CommentsNotifier(
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => UserNotifier(
      locator(),
      locator(),
    ),
  );

  // usecases
  locator.registerLazySingleton(() => GetArticle(locator()));
  locator.registerLazySingleton(() => GetPost(locator()));
  locator.registerLazySingleton(() => GetPostById(locator()));
  locator.registerLazySingleton(() => CreatePost(locator()));
  locator.registerLazySingleton(() => GetCommentsById(locator()));
  locator.registerLazySingleton(() => CreateComments(locator()));
  locator.registerLazySingleton(() => DeletePostById(locator()));
  locator.registerLazySingleton(() => CreateProfilePicture(locator()));
  locator.registerLazySingleton(() => GetProfilePictureById(locator()));

  // repository
  locator.registerLazySingleton<ArticleRespository>(
    () => ArticleRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<CommentsRepository>(
    () => CommentsRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<ArticleRemoteDataSource>(
    () => ArticleRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<CommentsRemoteDataSource>(
    () => CommentsRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
