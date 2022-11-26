import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  static const String title = 'Article';

  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Article Page'),
      ),
    );
  }
}
