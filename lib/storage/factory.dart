import 'manifest.dart';

abstract class StorageFactory {
  AccountStorage accountStorage();
  StudentCareerStorage studentCareerStorage();
}
