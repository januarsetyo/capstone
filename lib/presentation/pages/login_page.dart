import 'package:capstone/presentation/pages/home_page.dart';
import 'package:capstone/presentation/pages/signup_page.dart';
import 'package:capstone/presentation/provider/preferences_notifier.dart';
import 'package:capstone/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesNotifier>(
      builder: (context, value, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: secondaryColor,
                      ))
                    : Container(),
                Text(
                  'Hello Again!',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Welcome back, you\'ve been missed',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25.0),
                Hero(
                    tag: 'Image',
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.asset(
                          'assets/icon.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                    )),
                const SizedBox(height: 10.0),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 20.0),
                MaterialButton(
                  color: primaryColor,
                  textTheme: ButtonTextTheme.primary,
                  height: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      final navigator = Navigator.of(context);
                      final email = _emailController.text;
                      final password = _passwordController.text;

                      await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      value.setIsLogin(true);

                      navigator.pushReplacementNamed(HomePage.routeName);
                    } catch (err) {
                      final snackBar = SnackBar(content: Text(err.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  child: Text(
                    'Don\'t have account yet ? Signup Here',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    SignupPage.routeName,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
