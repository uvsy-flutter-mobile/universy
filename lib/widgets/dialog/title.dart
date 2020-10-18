import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double ACTION_PADDING = 8;

class TitleDialog extends StatelessWidget {
  final String _title;
  final List<Widget> _actions;
  final Widget _content;

  TitleDialog({@required String title, List<Widget> actions, Widget content})
      : this._title = title,
        this._actions = actions,
        this._content = content,
        super();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: _buildShape(),
      elevation: 80.0,
      actionsPadding:
          EdgeInsets.only(right: ACTION_PADDING, bottom: ACTION_PADDING),
      title: Text(
        _title,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
      content: _content,
      actions: _actions,
    );
  }

  ShapeBorder _buildShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)));
  }
}
