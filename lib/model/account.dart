import 'package:universy/model/copyable.dart';

import "json.dart";

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

class Token implements JsonConvertible {
  final String _idToken;
  final String _accessToken;
  final String _refreshToken;

  Token(this._idToken, this._accessToken, this._refreshToken);

  String get idToken => _idToken;

  String get accessToken => _accessToken;

  String get refreshToken => _refreshToken;

  @override
  Map<String, String> toJson() {
    return {
      "idToken": _idToken,
      "accessToken": _accessToken,
      "refreshToken": _refreshToken,
    };
  }
}

class Profile implements JsonConvertible, Copyable<Profile> {
  final String _userId;
  final String _name;
  final String _lastName;
  final String _alias;

  Profile(this._userId, this._name, this._lastName, this._alias);

  String get userId => _userId;

  String get name => _name;

  String get lastName => _lastName;

  String get alias => _alias;

  @override
  Map<String, String> toJson() {
    return {
      "userId": _userId,
      "name": _name,
      "lastName": _lastName,
      "alias": _alias,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    var data = json["data"];
    return Profile(
      data["userId"],
      data["name"],
      data["lastName"],
      data["alias"],
    );
  }

  @override
  String toString() {
    return 'Profile{_userId: $_userId, _name: $_name, _lastName: $_lastName, _alias: $_alias}';
  }

  @override
  Profile copy() {
    return Profile.fromJson(this.toJson());
  }
}
