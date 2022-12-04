import 'package:capstone/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = '/signup';

  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _isLoading ? const Center(child: CircularProgressIndicator()) : Container(),
            Text(
              'Sign Up',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12.0),
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
            const SizedBox(height: 30.0),
            Text(
              'Create your account',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
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
            const SizedBox(height: 24.0),
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

                  await _auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  navigator.pop();
                } catch (err) {
                  final snackBar = SnackBar(content: Text(err.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: const Text('Signup'),
            ),
            TextButton(
              child: Text(
                'Already have an account ? Login Here',
                style: Theme.of(context).textTheme.caption,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
