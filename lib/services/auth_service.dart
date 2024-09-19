import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final SharedPreferences _preferences;

  AuthService(this._preferences);

  Future<void> saveToken(String token) async {
    await _preferences.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    return _preferences.getString('auth_token');
  }

  Future<void> clearToken() async {
    await _preferences.remove('auth_token');
  }
}
