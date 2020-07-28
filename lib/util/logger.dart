import 'package:logger/logger.dart';

import 'object.dart';

class Log {
  final Logger _loggerImpl;

  static Log _instance;

  Log._internal(this._loggerImpl);

  factory Log.getLogger() {
    if (isNull(_instance)) {
      var logger = Logger(
        printer:
            PrettyPrinter(), // Use the PrettyPrinter to format and print log
      );
      _instance = Log._internal(logger);
    }
    return _instance;
  }

  void info(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _loggerImpl.i(message, error, stackTrace);
  }

  void error(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _loggerImpl.e(message, error, stackTrace);
  }

  void warning(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _loggerImpl.w(message, error, stackTrace);
  }
}
