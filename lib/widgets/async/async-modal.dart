import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optional/optional.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/flushbar/builder.dart';

typedef FutureContextCallable = Future<dynamic> Function(BuildContext context);
typedef ContextCallable = void Function(BuildContext context);

class AsyncModal {
  final Widget _widget;
  final FutureContextCallable _asyncAction;
  final ContextCallable _afterSuccess;
  final Map<Type, ContextCallable> _exceptionHandlers;

  AsyncModal(this._widget, this._asyncAction, this._afterSuccess,
      this._exceptionHandlers);

  Future<void> run(BuildContext context) async {
    try {
      _showDialogForSubmit(context);
      await _asyncAction(context);
      Navigator.of(context).pop();
      _afterSuccess(context);
    } catch (e) {
      Navigator.of(context).pop();
      Optional.ofNullable(_exceptionHandlers[e.runtimeType])
          .orElse(defaultHandler)(context);
    }
  }

  void defaultHandler(BuildContext context) {
    FlushBarBuilder.unknownError().show(context);
  }

  void _showDialogForSubmit(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) => _widget);
  }
}

class AsyncModalBuilder {
  FutureContextCallable _asyncAction =
      (context) => Future.delayed(Duration(seconds: 1));
  ContextCallable _afterSuccess = (context) => {};
  Map<Type, ContextCallable> _exceptionHandlers = Map();

  String _displayText = AppText.getInstance().get("student.loading");

  AsyncModalBuilder perform(FutureContextCallable action) {
    this._asyncAction = action;
    return this;
  }

  AsyncModalBuilder then(ContextCallable action) {
    this._afterSuccess = action;
    return this;
  }

  AsyncModalBuilder withTitle(String displayText) {
    this._displayText = displayText;
    return this;
  }

  AsyncModalBuilder handle(
      Type exception, Function(BuildContext context) action) {
    this._exceptionHandlers[exception] = action;
    return this;
  }

  Widget _buildWidgetToDisplay() {
    return SubmitAlertDialog(
      textToDisplay: _displayText,
    );
  }

  AsyncModal build() {
    return AsyncModal(_buildWidgetToDisplay(), _asyncAction, _afterSuccess,
        _exceptionHandlers);
  }
}

class SubmitAlertDialog extends StatelessWidget {
  final String _textToDisplay;

  SubmitAlertDialog({String textToDisplay})
      : this._textToDisplay = textToDisplay,
        super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.black54,
        content: SizedBox(
          height: 200,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 40),
              AutoSizeText(
                _textToDisplay,
                style: TextStyle(fontSize: 20, color: Colors.white),
                maxLines: 2,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
