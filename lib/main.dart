import 'package:capstone/data/datasources/preferences_helper.dart';
import 'package:capstone/firebase_options.dart';
import 'package:capstone/presentation/pages/article_webview_page.dart';
import 'package:capstone/presentation/pages/home_page.dart';
import 'package:capstone/presentation/pages/login_page.dart';
import 'package:capstone/presentation/pages/post_detail_page.dart';
import 'package:capstone/presentation/pages/post_page.dart';
import 'package:capstone/presentation/pages/signup_page.dart';
import 'package:capstone/presentation/provider/preferences_notifier.dart';
import 'package:capstone/presentation/provider/post_notifier.dart';
import 'package:capstone/presentation/provider/comments_notifier.dart';
import 'package:capstone/presentation/provider/user_notifier.dart';
import 'package:capstone/presentation/provider/article_notifier.dart';
import 'package:capstone/styles/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:capstone/injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  PreferencesHelper preferencesHelper = PreferencesHelper(
    sharedPreferences: SharedPreferences.getInstance(),
  );

  debugPrint('${await preferencesHelper.isLogin}');

  di.init();

  runApp(
    await preferencesHelper.isLogin
        ? const MyApp(
            pageRouteName: HomePage.routeName,
          )
        : const MyApp(
            pageRouteName: LoginPage.routeName,
          ),
  );
}

class MyApp extends StatelessWidget {
  final String pageRouteName;

  const MyApp({super.key, required this.pageRouteName});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PreferencesNotifier(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PostNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<CommentsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<UserNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ArticleNotifier>(),
        ),
      ],
      child: Consumer<PreferencesNotifier>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Capstone Project',
            theme: ThemeData(textTheme: myTextTheme),
            initialRoute: pageRouteName,
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              LoginPage.routeName: (context) => const LoginPage(),
              SignupPage.routeName: (context) => const SignupPage(),
              PostPage.routeName: (context) => const PostPage(),
              PostDetailPage.routeName: (context) => PostDetailPage(
                    ModalRoute.of(context)?.settings.arguments as int,
                  ),
              ArticleWebViewPage.routeName: (context) => ArticleWebViewPage(
                    ModalRoute.of(context)?.settings.arguments as String,
                  ),
            },
          );
        },
      ),
    );
  }
}
