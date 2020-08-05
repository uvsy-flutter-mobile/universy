import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:optional/optional.dart';
import 'package:universy/apis/status_code.dart';
import 'package:universy/apis/url.dart';
import 'package:universy/model/account.dart';
import 'package:universy/model/json.dart';
import 'package:universy/services/impl/default/account.dart';

import 'errors.dart';

void checkStatus(http.Response response) {
  var code = response.statusCode;
  if (!SUCCESS_STATUS.contains(code)) {
    throw (errors[code] ?? UnexpectedAPIError(code, response.body));
  }
}

Future<Optional<R>> get<R>(String resource,
    {Map<String, String> queryParams,
    R Function(Map<String, dynamic>) model}) async {
  var url = UrlBuilder(resource: resource, queryParams: queryParams).build();
  var headers = await _getHeaders();

  var response = await http.get(
    url,
    headers: headers,
  );

  checkStatus(response);

  if (response.statusCode == HTTP_OK) {
    return Optional.ofNullable(
        model(json.decode(utf8.decode(response.bodyBytes))));
  }
  return Optional.empty();
}

Future<void> put(String resource, {JsonConvertible payload}) async {
  var url = UrlBuilder(resource: resource).build();
  var headers = await _getHeaders();
  var body = _encodeBody(payload);

  var response = await http.put(
    url,
    headers: headers,
    body: body,
  );

  checkStatus(response);
}

Future<void> post(String resource, {JsonConvertible payload}) async {
  var url = UrlBuilder(resource: resource).build();
  var headers = await _getHeaders();
  var body = _encodeBody(payload);

  var response = await http.post(
    url,
    headers: headers,
    body: body,
  );

  checkStatus(response);
}

dynamic _encodeBody(JsonConvertible payload) {
  return json.encode(payload.toJson());
}

Future<Map<String, String>> _getHeaders() async {
  Token token = await DefaultAccountService.instance().getAuthToken();
  return {
    "Authentication": token.idToken,
  };
}
