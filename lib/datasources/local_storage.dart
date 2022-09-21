import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<bool?> getBool(String key);
  Future<bool> setBool(String key, bool value);
}

class LocalStorageImpl implements LocalStorage {
  @override
  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(key);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setBool(key, value);
  }
}
