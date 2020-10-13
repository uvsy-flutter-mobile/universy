import 'package:optional/optional.dart';
import 'package:universy/apis/api.dart' as api;
import 'package:universy/model/institution/ratings.dart';
import 'package:universy/model/student/ratings.dart';

import 'requests.dart';

const basePath = "/rtngapi";

String _createPath(String resource) {
  return "$basePath$resource";
}

// Institution
Future<Optional<SubjectRating>> getSubjectRating(String subjectId) async {
  var resource = "/ratings/subjects/$subjectId";
  var path = _createPath(resource);

  return api.get<SubjectRating>(
    path,
    model: (content) => SubjectRating.fromJson(content),
  );
}

// Student
Future<Optional<StudentSubjectRating>> getStudentSubjectRating(
    String userId, String subjectId) async {
  var resource = "/ratings/students/$userId/subjects/$subjectId";
  var path = _createPath(resource);

  return api.get<StudentSubjectRating>(
    path,
    model: (content) => StudentSubjectRating.fromJson(content),
  );
}

Future<void> saveStudentSubjectRating(String userId, String subjectId,
    StudentSubjectRatingPayload payload) async {
  var resource = "/ratings/students/$userId/subjects/$subjectId";
  var path = _createPath(resource);

  await api.put(
    path,
    payload: payload,
  );
}
