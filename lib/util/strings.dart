import 'object.dart';

bool notNullOrEmpty(String string) {
  return notNull(string) && string.isNotEmpty;
}

bool nullOrEmpty(String string) {
  return isNull(string) && string.isEmpty;
}

bool stringEquals(String string1, String string2) {
  return notNull(string1) && notNull(string2) && string1 == string2;
}
