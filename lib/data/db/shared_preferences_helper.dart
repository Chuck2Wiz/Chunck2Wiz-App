import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _preferences;

  static Future<SharedPreferences> getInstance() async {
    _preferences ??= await SharedPreferences.getInstance();

    return _preferences!;
  }

  static Future<void> saveUserNum(String userNum) async {
    final prefs = await getInstance();
    await prefs.setString('userNum', userNum);
  }

  static Future<void> saveNick(String nick) async {
    final prefs = await getInstance();
    await prefs.setString('nick', nick);
  }

  static Future<void> saveToken(String token) async {
    final prefs = await getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getUserNum() async {
    final prefs = await getInstance();

    return prefs.getString('userNum');
  }

  static Future<String?> getNick() async {
    final prefs = await getInstance();

    return prefs.getString('nick');
  }
}