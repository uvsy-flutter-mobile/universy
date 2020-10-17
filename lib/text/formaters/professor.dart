import 'package:universy/constants/strings.dart';
import 'package:universy/model/institution/professor.dart';
import 'package:universy/util/object.dart';
import 'package:universy/util/strings.dart';

class ProfessorNameFormatter {
  static const String IN_BETWEEN_SIGN = ",";
  final Professor _professor;

  ProfessorNameFormatter(this._professor);

  String format() {
    if (notNull(_professor)) {
      String name = _professor.name.trim();
      String lastName = _professor.lastName.trim();
      if (notNullOrEmpty(name) && notNullOrEmpty(lastName)) {
        return "$name$IN_BETWEEN_SIGN $lastName";
      } else {
        return "$name $lastName";
      }
    } else {
      return EMPTY_STRING;
    }
  }
}
