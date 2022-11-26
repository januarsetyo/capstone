import 'package:capstone/presentation/pages/article_page.dart';
import 'package:capstone/presentation/pages/forum_page.dart';
import 'package:capstone/presentation/pages/live_chat_page.dart';
import 'package:capstone/presentation/provider/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidgets = [
    const ForumPage(),
    const LiveChatPage(),
    const ArticlePage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: ForumPage.title,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: LiveChatPage.title,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: ArticlePage.title,
    ),
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   debugPrint('${Provider.of<PreferencesProvider>(context, listen: false).isLogin}');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidgets[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }
}
