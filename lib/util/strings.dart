import 'object.dart';

bool notNullOrEmpty(String string) {
  return notNull(string) && string.isNotEmpty;
}

bool nullOrEmpty(String string) {
  return isNull(string) && string.isEmpty;
}
