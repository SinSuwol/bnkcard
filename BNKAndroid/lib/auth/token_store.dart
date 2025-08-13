import 'package:shared_preferences/shared_preferences.dart';

class TokenStore {
  TokenStore._();
  static final I = TokenStore._();
  static const _key = 'jwt_token';

  Future<void> save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, token);
  }

  Future<String?> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
