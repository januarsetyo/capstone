import 'package:flutter/material.dart';

class ForumPage extends StatelessWidget {
  static const String title = 'Forum';

  const ForumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Forum Page'),
      ),
    );
  }
}
