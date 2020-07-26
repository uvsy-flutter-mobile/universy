import 'json.dart';

class User implements JsonConvertible {
  final String _username;
  final String _password;

  User(this._username, this._password);

  String get username => _username;

  String get password => _password;

  @override
  Map<String, String> toJson() {
    return {
      "username": _username,
      "password": _password,
    };
  }
}
