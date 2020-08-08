import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';

class FlushBarBroker {
  static Flushbar currentFlushBar;

  String _message = "";
  Icon _icon;
  int _duration = 10;
  FlushbarDismissDirection _dismissDirection =
      FlushbarDismissDirection.HORIZONTAL;

  FlushBarBroker();

  FlushBarBroker.unknownError() {
    this._message = _unexpectedErrorMessage();
    this._icon = _unexpectedErrorIcon();
    this._duration = 5;
  }

  FlushBarBroker.noConnection() {
    this._message = _connectionErrorMessage();
    this._icon = _connectionErrorIcon();
  }

  FlushBarBroker.success() {
    this._icon = _successIcon();
    this._duration = 3;
  }

  FlushBarBroker.error() {
    this._icon = _errorIcon();
    this._duration = 3;
  }

  FlushBarBroker withMessage(String message) {
    this._message = message;
    return this;
  }

  FlushBarBroker withIcon(Icon icon) {
    this._icon = icon;
    return this;
  }

  FlushBarBroker withDuration(int seconds) {
    this._duration = seconds;
    return this;
  }

  FlushBarBroker verticalDismiss() {
    this._dismissDirection = FlushbarDismissDirection.VERTICAL;
    return this;
  }

  void show(BuildContext context) async {
    await clear();

    currentFlushBar = Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      duration: notNull(_duration) ? Duration(seconds: _duration) : null,
      message: _message,
      icon: _icon,
      isDismissible: true,
      dismissDirection: _dismissDirection,
    );

    currentFlushBar.show(context);
  }

  Future<void> clear() async {
    if (notNull(currentFlushBar) && currentFlushBar.isShowing()) {
      await currentFlushBar.dismiss();
    }
  }

  String _unexpectedErrorMessage() =>
      AppText.getInstance().get("login.error.unexpectedError");

  Icon _unexpectedErrorIcon() {
    return Icon(
      Icons.error_outline,
      color: Colors.redAccent,
    );
  }

  Icon _successIcon() {
    return Icon(Icons.check, color: Colors.green);
  }

  Icon _errorIcon() {
    return Icon(Icons.error_outline, color: Colors.redAccent);
  }

  String _connectionErrorMessage() =>
      AppText.getInstance().get("error.noConnection");

  Icon _connectionErrorIcon() {
    return Icon(
      Icons.signal_cellular_connected_no_internet_4_bar,
      color: Colors.redAccent,
    );
  }
}
