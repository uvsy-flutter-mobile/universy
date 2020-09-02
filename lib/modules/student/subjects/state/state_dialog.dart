import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/model/lock.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';

import 'state.dart';

class SubjectStateDialog extends StatefulWidget {
  final Subject _subject;
  final Function(Subject subject) _onUpdate;
  final CorrelativesValidator _correlativesValidator;

  const SubjectStateDialog(
      {Key key,
      @required Subject subject,
      @required Function(Subject subject) onUpdate,
      CorrelativesValidator correlativeValidator})
      : this._subject = subject,
        this._onUpdate = onUpdate,
        this._correlativesValidator = correlativeValidator,
        super(key: key);

  @override
  _SubjectStateDialogState createState() => _SubjectStateDialogState();
}

class _SubjectStateDialogState extends State<SubjectStateDialog> {
  Subject _subject;
  StateLock _stateLock;

  @override
  void initState() {
    this._subject = widget._subject;
    this._stateLock = StateLock.lock(snapshot: _subject);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<CorrelativesValidator>.value(
      value: widget._correlativesValidator,
      child: AlertDialog(
        shape: _buildShapeDialog(),
        elevation: 80.0,
        title: Text(_subject.name, textAlign: TextAlign.center),
        contentPadding: EdgeInsets.only(top: 10.0),
        content: _buildDialogBody(),
        actions: <Widget>[
          SaveButton(onSave: () => updateSubject(context)),
          CancelButton(onCancel: () => Navigator.of(context).pop()),
        ],
      ),
    );
  }

  ShapeBorder _buildShapeDialog() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)));
  }

  Widget _buildDialogBody() {
    return Container(
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildDivider(),
          SubjectStateWidget(subject: _subject),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey,
      height: 4.0,
    );
  }

  void updateSubject(BuildContext context) {
    if (_stateLock.hasChange(_subject)) {
      widget._onUpdate(_subject);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }
}
