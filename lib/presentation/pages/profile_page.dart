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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/blank_profile.jpg'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(_auth.currentUser!.email.toString()),
                const SizedBox(
                  height: 10,
                ),
                Text('ID : ${_auth.currentUser!.uid}'),
              ],
            ),
          ),
        );
      },
    );
  }
}


// ElevatedButton(
//               child: const Text('Logout'),
//               onPressed: () async {
//                 final navigator = Navigator.of(context);

//                 await _auth.signOut();
//                 value.setIsLogin(false);

//                 navigator.pushReplacementNamed(LoginPage.routeName);
//               },
//             ),