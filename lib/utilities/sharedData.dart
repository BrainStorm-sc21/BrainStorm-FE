import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  static dynamic putInt(key, value) async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    var res = prefs.setInt("$key", value);
    return res;
  }

  static dynamic putDouble(key, value) async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    var res = prefs.setDouble("$key", value);
    return res;
  }

  static dynamic putString(key, value) async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    var res = prefs.setString("$key", value);
    return res;
  }

  static dynamic getInt(key) async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    int? res = prefs.getInt("$key");
    return res;
  }

  static dynamic getDouble(key) async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    double? res = prefs.getDouble("$key");
    return res;
  }

  static dynamic getString(key) async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    String? res = prefs.getString("$key");
    return res;
  }
}
