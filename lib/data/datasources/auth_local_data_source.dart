import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  final SharedPreferences prefs;

  AuthLocalDataSource(this.prefs);

  static const String _loginKey = 'is_logged_in';

  bool get isLoggedIn {
    return prefs.getBool(_loginKey) ?? false;
  }

  Future<void> saveLoginStatus(bool value) async {
    await prefs.setBool(_loginKey, value);
  }

  Future<void> logout() async {
    await prefs.remove(_loginKey);
  }
}