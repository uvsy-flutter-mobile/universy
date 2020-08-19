import 'package:optional/optional.dart';
import 'package:universy/apis/api.dart' as api;
import 'package:universy/model/student/account.dart';
import 'package:universy/model/student/career.dart';

import 'requests.dart';

const basePath = "/stdnapi";

String _createPath(String resource) {
  return "$basePath$resource";
}

// Career

Future<List<StudentCareer>> getCareers(String userId) async {
  var resource = "/students/$userId/careers";
  var path = _createPath(resource);

  var response = await api.getList<StudentCareer>(
    path,
    model: (content) => StudentCareer.fromJson(content),
  );

  return response.orElse([]);
}

Future<Optional<StudentCareer>> getCareer(
    String userId, String programId) async {
  var resource = "/students/$userId/careers/$programId";
  var path = _createPath(resource);

  return await api.get<StudentCareer>(
    path,
    model: (content) => StudentCareer.fromJson(content),
  );
}

// Profile

Future<Optional<Profile>> getProfile(String userId) {
  var resource = "/profile/$userId";
  var path = _createPath(resource);

  return api.get<Profile>(
    path,
    model: (content) => Profile.fromJson(content),
  );
}

Future<void> updateProfile(String userId, UpdateProfileRequest request) {
  var resource = "/profile/$userId";

  return api.put(
    resource,
    payload: request,
  );
}

Future<void> createProfile(Profile profile) {
  var resource = "/profile";
  var path = _createPath(resource);

  return api.post(
    path,
    payload: profile,
  );
}

Future<void> checkAliasProfile(String userId, String newAlias) {
  var resource = "/alias/availability";
  var path = _createPath(resource);

  return api.get(path, queryParams: {"user_id": userId, "alias": newAlias});
}
