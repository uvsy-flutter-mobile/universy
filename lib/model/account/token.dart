import 'package:universy/model/json.dart';

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
