import 'package:universy/model/institution/subject.dart';

String getConditionDisplayName(CorrelativeCondition condition) {
  // TODO: Text
  if (condition == CorrelativeCondition.APPROVED) {
    return "Aprobada";
  } else if (condition == CorrelativeCondition.REGULAR) {
    return "Regular";
  }
  throw StateError("Correlative Condition not found");
}
