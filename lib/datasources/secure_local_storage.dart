import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureLocalStorage {
  Future<void> set({
    required String key,
    required String? value,
  });

  Future<void> delete({
    required String key,
  });

  Future<String?> get({
    required String key,
  });
}

class SecureLocalStorageImpl implements SecureLocalStorage {
  final storage = const FlutterSecureStorage();
  @override
  Future<void> delete({required String key}) {
    return storage.delete(key: key);
  }

  @override
  Future<String?> get({required String key}) {
    return storage.read(key: key);
  }

  @override
  Future<void> set({required String key, required String? value}) {
    return storage.write(key: key, value: value);
  }
}
