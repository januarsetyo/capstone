import 'package:capstone/presentation/pages/home_page.dart';
import 'package:capstone/presentation/provider/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    value.setIsLogin(true);
                    Navigator.pushReplacementNamed(context, HomePage.routeName);
                  },
                ),
                ElevatedButton(
                  child: const Text('Check State'),
                  onPressed: () {
                    debugPrint('${value.isLogin}');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
