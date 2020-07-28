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
  Future<void> clear() async {
    try {
      final storage = FlutterSecureStorage();
      await storage.deleteAll();
    } catch (e) {
      Log.getLogger().error("Error cleaning account info.", e);
    }
  }

  @override
  Future getItem(String key) async {
    try {
      final storage = FlutterSecureStorage();
      await storage.read(key: key);
    } catch (e) {
      Log.getLogger().error("Error reading account info.", e);
    }
  }

  @override
  Future removeItem(String key) async {
    try {
      final storage = FlutterSecureStorage();
      await storage.delete(key: key);
    } catch (e) {
      Log.getLogger().error("Error removing account info.", e);
    }
  }

  @override
  Future setItem(String key, value) async {
    try {
      final storage = FlutterSecureStorage();
      await storage.write(key: key, value: value);
    } catch (e) {
      Log.getLogger().error("Error writting account info.", e);
    }
  }
}
