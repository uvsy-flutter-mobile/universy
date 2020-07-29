import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';

class WillPopOutWidget extends StatelessWidget {
  final Widget _child;

  const WillPopOutWidget({Key key, @required Widget child})
      : this._child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: _child,
      onWillPop: () => _onWillPop(context),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppText.getInstance().get("general.exit.title")),
            content: Text(AppText.getInstance().get("general.exit.content")),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(AppText.getInstance().get("general.no")),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(AppText.getInstance().get("general.yes")),
              ),
            ],
          ),
        ) ??
        false;
  }
}
