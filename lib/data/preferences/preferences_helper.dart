import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  const PreferencesHelper({required this.sharedPreferences});

  static const String login = 'LOGIN';

  void setIsLogin(bool value) async {
    final prefs = await sharedPreferences;

    prefs.setBool(login, value);
  }

  Future<bool> get isLogin async {
    final prefs = await sharedPreferences;

    return prefs.getBool(login) ?? false;
  }
}
