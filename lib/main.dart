import 'package:capstone/data/datasources/preferences_helper.dart';
import 'package:capstone/firebase_options.dart';
import 'package:capstone/presentation/pages/home_page.dart';
import 'package:capstone/presentation/pages/login_page.dart';
import 'package:capstone/presentation/pages/signup_page.dart';
import 'package:capstone/presentation/provider/preferences_provider.dart';
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
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        )
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Capstone Project',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: pageRouteName,
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              LoginPage.routeName: (context) => const LoginPage(),
              SignupPage.routeName: (context) => const SignupPage(),
            },
          );
        },
      ),
    );
  }
}
