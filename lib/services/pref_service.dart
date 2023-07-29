import 'package:shared_preferences/shared_preferences.dart';

sealed class Prefs {
  static Future<bool> store(StorageKey key, String data) async {
    final db = await SharedPreferences.getInstance();
    return db.setString(key.name, data);
  }

  static Future<String?> read(StorageKey key) async {
    final db = await SharedPreferences.getInstance();
    return db.getString(key.name);
  }

  static Future<bool> remove(StorageKey key) async {
    final db = await SharedPreferences.getInstance();
    return db.remove(key.name);
  }
}

enum StorageKey {
  language,
  mode,
  toke,
  id,
  user,
  /// for testing
  data,
}