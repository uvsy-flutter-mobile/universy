import 'package:optional/optional.dart';
import 'package:universy/apis/api.dart' as api;
import 'package:universy/model/account.dart';
import 'package:universy/model/json.dart';

Future<Optional<Profile>> getProfile(String userId) {
  var resource = "/profile/$userId";

  return api.get<Profile>(
    resource,
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

  return api.post(
    resource,
    payload: profile,
  );
}

class UpdateProfileRequest extends JsonConvertible {
  final String name;
  final String lastName;
  final String alias;

  UpdateProfileRequest(this.name, this.lastName, this.alias);

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "lastName": lastName,
      "alias": alias,
    };
  }
}
