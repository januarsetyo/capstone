import 'package:capstone/data/preferences/preferences_helper.dart';
import 'package:flutter/widgets.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getIsLogin();
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  void _getIsLogin() async {
    _isLogin = await preferencesHelper.isLogin;
    notifyListeners();

    debugPrint(_isLogin ? 'isLogin true' : 'isLogin false');
  }

  void setIsLogin(bool value) async {
    preferencesHelper.setIsLogin(value);
    _getIsLogin();
  }
}
