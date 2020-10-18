import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const double SEPARATOR_SPACE = 15;

class ScheduleConfirmMessage extends StatelessWidget {
  final String _alertMessage;
  final String _scheduleName;
  final String _confirmMessage;

  ScheduleConfirmMessage(
      {@required String scheduleName,
      String alertMessage,
      String confirmMessage})
      : this._scheduleName = scheduleName,
        this._alertMessage = alertMessage,
        this._confirmMessage = confirmMessage,
        super();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            _alertMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: SEPARATOR_SPACE,
          ),
          Text(
            _scheduleName,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: SEPARATOR_SPACE,
          ),
          Text(_confirmMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1)
        ],
      ),
    );
  }
}
