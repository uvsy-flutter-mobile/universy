import 'package:universy/apis/status_code.dart';

Map<int, APIError> errors = {
  HTTP_BAD_REQUEST: BadRequest(),
  HTTP_UNAUTHORIZED: Unauthorized(),
  HTTP_FORBIDDEN: Forbidden(),
  HTTP_NOT_FOUND: NotFound(),
  HTTP_CONFLICT: Conflict(),
  HTTP_INTERNAL_ERROR: InternalError(),
};

class APIError implements Exception {}

class UnexpectedAPIError implements Exception {
  final int statusCode;
  final String message;

  UnexpectedAPIError(this.statusCode, this.message);

  String toString() {
    return "UnexpectedAPIError(code=$statusCode,message=$message)";
  }
}

class BadRequest extends APIError {}

class Unauthorized extends APIError {}

class Forbidden extends APIError {}

class NotFound extends APIError {}

class Conflict extends APIError {}

class InternalError extends APIError {}
