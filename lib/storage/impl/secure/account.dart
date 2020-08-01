import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universy/storage/manifest.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/util/object.dart';

class SecureAccountStorage extends AccountStorage {
  static AccountStorage _instance;

  SecureAccountStorage._internal();

  factory SecureAccountStorage.instance() {
    if (isNull(_instance)) {
      _instance = SecureAccountStorage._internal();
    }
    return _instance;
  }

  @override
  Future<void> clear() {
    try {
      final storage = FlutterSecureStorage();
      return storage.deleteAll();
    } catch (e) {
      Log.getLogger().error("Error cleaning account info.", e);
      return null;
    }
  }

  @override
  Future<dynamic> getItem(String key) {
    try {
      final storage = FlutterSecureStorage();
      return storage.read(key: key);
    } catch (e) {
      Log.getLogger().error("Error reading account info.", e);
      return null;
    }
  }

  @override
  Future<dynamic> removeItem(String key) {
    try {
      final storage = FlutterSecureStorage();
      return storage.delete(key: key);
    } catch (e) {
      Log.getLogger().error("Error removing account info.", e);
    }
  }

  @override
  Future<dynamic> setItem(String key, value) {
    try {
      final storage = FlutterSecureStorage();
      return storage.write(key: key, value: value);
    } catch (e) {
      Log.getLogger().error("Error writting account info.", e);
      return null;
    }
  }
}
