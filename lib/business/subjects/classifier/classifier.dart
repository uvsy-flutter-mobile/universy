import 'package:universy/model/subject.dart';

abstract class SubjectClassifier<T> {
  T classify(List<Subject> subjects);
}
