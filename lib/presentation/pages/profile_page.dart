import 'package:capstone/presentation/pages/login_page.dart';
import 'package:capstone/presentation/provider/preferences_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static const String title = 'Profile';

  final _auth = FirebaseAuth.instance;

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: Center(
            child: ElevatedButton(
              child: const Text('Logout'),
              onPressed: () async {
                final navigator = Navigator.of(context);

                await _auth.signOut();
                value.setIsLogin(false);

                navigator.pushReplacementNamed(LoginPage.routeName);
              },
            ),
          ),
        );
      },
    );
  }
}
