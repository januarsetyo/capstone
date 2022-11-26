import 'package:capstone/presentation/pages/article_page.dart';
import 'package:capstone/presentation/pages/forum_page.dart';
import 'package:capstone/presentation/pages/live_chat_page.dart';
import 'package:capstone/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

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
    ProfilePage(),
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
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: ProfilePage.title,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidgets[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: true,
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
