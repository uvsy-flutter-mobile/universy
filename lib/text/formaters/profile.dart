import 'package:universy/constants/strings.dart';
import 'package:universy/model/account.dart';
import 'package:universy/util/object.dart';
import 'package:universy/util/strings.dart';

class AliasFormatter {
  static const String ALIAS_PREFIX = "@";

  final Profile _profile;

  AliasFormatter(this._profile);

  String format() {
    if (notNull(_profile)) {
      String alias = _profile.alias;
      if (notNullOrEmpty(alias)) {
        return "$ALIAS_PREFIX$alias";
      }
    }
    return N_A;
  }
}

class CompleteNameFormatter {
  final Profile _profile;

  CompleteNameFormatter(this._profile);

  String format() {
    if (notNull(_profile)) {
      String name = _profile.name;
      String lastName = _profile.lastName;

      if (notNullOrEmpty(name) && notNullOrEmpty(lastName)) {
        return "$name $lastName";
      }
    }
    return N_A;
  }
}

class InitialsFormatter {
  static const FIRST_LETTER_INDEX = 0;

  final Profile _profile;

  InitialsFormatter(this._profile);

  String format() {
    if (_profile != null) {
      String initials = EMPTY_STRING;
      String name = _profile.name;
      String lastName = _profile.lastName;

      if (name != null && name.isNotEmpty) {
        initials += name[FIRST_LETTER_INDEX];
      }

      if (lastName != null && lastName.isNotEmpty) {
        initials += lastName[FIRST_LETTER_INDEX];
      }

      return initials;
    }
    return N_A;
  }
}
