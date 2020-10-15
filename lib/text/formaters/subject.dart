import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/util/strings.dart';

abstract class LevelFormatter {
  static const String ORDINAL_SIGN = "º";
  static const String NO_LEVEL = "-";

  String format() {
    if (notNullOrEmpty(level)) {
      return "$level$ORDINAL_SIGN";
    }
    return NO_LEVEL;
  }

  String get level;
}

class SubjectLevelFormatter extends LevelFormatter {
  final Subject _subject;

  SubjectLevelFormatter(this._subject);

  @override
  String get level {
    return _subject?.level?.toString();
  }
}

class InstitutionSubjectLevelFormatter extends LevelFormatter {
  final InstitutionSubject _institutionSubject;

  InstitutionSubjectLevelFormatter(this._institutionSubject);

  @override
  String get level {
    return _institutionSubject?.level?.toString();
  }
}

class CorrelativeItemLevelFormatter extends LevelFormatter {
  final CorrelativeItem _correlativeItem;

  CorrelativeItemLevelFormatter(this._correlativeItem);

  @override
  String get level {
    return _correlativeItem?.level?.toString();
  }
}
