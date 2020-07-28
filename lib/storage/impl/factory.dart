import 'package:universy/storage/factory.dart';
import 'package:universy/storage/impl/secure/account.dart';
import 'package:universy/storage/manifest.dart';
import 'package:universy/util/object.dart';

class DefaultStorageFactory extends StorageFactory {
  static StorageFactory _instance;

  DefaultStorageFactory._internal();

  factory DefaultStorageFactory.instance() {
    if (isNull(_instance)) {
      _instance = DefaultStorageFactory._internal();
    }
    return _instance;
  }

  @override
  AccountStorage accountStorage() {
    return SecureAccountStorage.instance();
  }
}
