import 'package:capstone/presentation/pages/home_page.dart';
import 'package:capstone/presentation/pages/signup_page.dart';
import 'package:capstone/presentation/provider/preferences_provider.dart';
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
    return Consumer<PreferencesProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(),
                Hero(
                  tag: 'Capstone C22-117',
                  child: Text(
                    'Capstone C22-117',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                const SizedBox(height: 24.0),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 24.0),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
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
                          email: email, password: password);

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
                  child: const Text('Does not have an account yet ? Signup here'),
                  onPressed: () => Navigator.pushNamed(context, SignupPage.routeName),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
