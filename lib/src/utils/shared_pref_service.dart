import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  SharedPrefKeys._();
}

class SharedPrefService {
  SharedPrefService._();
  static SharedPreferencesAsync? _prefs;
  static Future<void> init() async {
    _prefs = SharedPreferencesAsync();
  }

  static SharedPreferencesAsync get _instance {
    if (_prefs == null) {
      throw Exception(
        'SharedPrefService belum diinisialisasi. Pastikan Anda sudah memanggil `SharedPrefService.init()` di dalam `main()`.',
      );
    }
    return _prefs!;
  }

  /// ======== Setter ==========
  static Future<void> setString(String key, String value) =>
      _instance.setString(key, value);

  static Future<void> setBool(String key, bool value) =>
      _instance.setBool(key, value);

  static Future<void> setInt(String key, int value) =>
      _instance.setInt(key, value);

  static Future<void> setDouble(String key, double value) =>
      _instance.setDouble(key, value);

  static Future<void> setStringList(String key, List<String> value) =>
      _instance.setStringList(key, value);

  /// ======== Getter=============
  static Future<String?> getString(String key) async {
    return await _instance.getString(key);
  }

  static Future<bool?> getBool(String key) {
    return _instance.getBool(key);
  }

  static Future<int?> getInt(String key) {
    return _instance.getInt(key);
  }

  static Future<double?> getDouble(String key) {
    return _instance.getDouble(key);
  }

  static Future<List<String>?> getStringList(String key) {
    return _instance.getStringList(key);
  }

  static Future<void> remove(String key) => _instance.remove(key);
  static Future<void> clear() => _instance.clear();
}
