import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/util/object.dart';

const double ACTION_PADDING = 8;

class TitleDialog extends StatelessWidget {
  final String _title;
  final List<Widget> _actions;
  final Widget _content;
  final Widget _titleAction;

  TitleDialog({
    @required String title,
    List<Widget> actions,
    Widget content,
    Widget titleAction,
  })  : this._title = title,
        this._actions = actions,
        this._content = content,
        this._titleAction = titleAction,
        super();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: _buildShape(),
      elevation: 80.0,
      actionsPadding:
          EdgeInsets.only(right: ACTION_PADDING, bottom: ACTION_PADDING),
      title: _buildTitle(context),
      content: _content,
      actions: _actions,
    );
  }

  Widget _buildTitle(BuildContext context) {
    TextAlign textAlign =
        isNull(_titleAction) ? TextAlign.center : TextAlign.start;
    if (isNull(_titleAction)) {
      return Text(
        _title,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            _title,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.start,
          ),
          _titleAction
        ],
      );
    }
  }

  ShapeBorder _buildShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)));
  }
}
