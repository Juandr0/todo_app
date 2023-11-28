import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);
    return seen;
  }

  static Future<void> setFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', true);
  }

  static Future<void> setThemeIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeIndex', index);
  }

  static Future<int> getThemeIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt('themeIndex') ?? 4;
    return index;
  }
}
