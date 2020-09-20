import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/util/object.dart';
import 'package:universy/util/strings.dart';

class SubjectLevelFormatter {
  static const String ORDINAL_SIGN = "º";
  static const String NO_LEVEL = "-";
  final Subject _subject;

  SubjectLevelFormatter(this._subject);

  String format() {
    if (notNull(_subject)) {
      String level = _subject.level.toString();

      if (notNullOrEmpty(level)) {
        return "$level$ORDINAL_SIGN";
      }
    }
    return NO_LEVEL;
  }
}

class InstitutionSubjectLevelFormatter {
  static const String ORDINAL_SIGN = "º";
  static const String NO_LEVEL = "-";
  final InstitutionSubject _institutionSubject;

  InstitutionSubjectLevelFormatter(this._institutionSubject);

  String format() {
    if (notNull(_institutionSubject)) {
      String level = _institutionSubject.level.toString();

      if (notNullOrEmpty(level)) {
        return "$level$ORDINAL_SIGN";
      }
    }
    return NO_LEVEL;
  }
}
