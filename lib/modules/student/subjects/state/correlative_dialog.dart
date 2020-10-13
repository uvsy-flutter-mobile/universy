import 'package:flutter/material.dart';
import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/modules/institution/correlatives/correlatives.dart';
import 'package:universy/text/text.dart';

class CorrelativeRestrictionDialog extends StatelessWidget {
  final CorrelativeValidation _correlativeValidation;

  const CorrelativeRestrictionDialog(
      {Key key, CorrelativeValidation correlativeValidation})
      : this._correlativeValidation = correlativeValidation,
        super(key: key);

  Widget build(BuildContext context) {
    return AlertDialog(
      shape: _buildShapeDialog(),
      elevation: 80.0,
      title: Text(
        AppText.getInstance().get("student.subjects.correlatives.title"),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: _buildDialogBody(),
      actions: <Widget>[
        ForceButton(),
        CancelButton(),
      ],
    );
  }

  ShapeBorder _buildShapeDialog() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)));
  }

  Widget _buildDialogBody() {
    return Container(
      width: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildDivider(),
          _buildCorrelativesBody(),
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

  Widget _buildCorrelativesBody() {
    List correlatives = _correlativeValidation.correlatives;
    correlatives.sort((a, b) => a._subject.level.compareTo(b._subject.level));
    return Container(
      height: 200.0,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: correlatives
            .map((correlativeCheck) => _buildCorrelative(correlativeCheck))
            .toList(),
      ),
    );
  }

  Widget _buildCorrelative(CorrelativeCheck correlativeCheck) {
    return Row(
      children: <Widget>[
        Expanded(
            child: _buildCorrelativeAlert(correlativeCheck.isNotValid),
            flex: 2),
        Expanded(child: _buildCorrelativeSubject(correlativeCheck), flex: 7)
      ],
    );
  }

  Widget _buildCorrelativeAlert(bool isNotValid) {
    if (isNotValid) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffebe9e4),
        ),
        child: Icon(Icons.priority_high, color: Colors.red, size: 30.0),
      );
    } else {
      return Container();
    }
  }

  Widget _buildCorrelativeSubject(CorrelativeCheck correlativeCheck) {
    return CorrelativeSubjectWidget(
      subject: correlativeCheck.subject,
      condition: correlativeCheck.condition,
    );
  }
}

class ForceButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return FlatButton(
        splashColor: Colors.amber,
        color: Colors.orange,
        shape: _getForceButtonShape(),
        child: _getChangeTextWidget(),
        onPressed: () => _forceAddMilestone(context));
  }

  void _forceAddMilestone(BuildContext context) async {
    Navigator.of(context).pop(true);
  }

  Text _getChangeTextWidget() {
    return Text(
      AppText.getInstance().get("student.subjects.correlatives.actions.force"),
      style: TextStyle(color: Colors.white),
    );
  }

  RoundedRectangleBorder _getForceButtonShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );
  }
}

class CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _doNotForceAddMilestone(context),
      splashColor: Colors.amber,
      icon: Icon(Icons.thumb_up, color: Colors.orange, size: 35.0),
    );
  }

  void _doNotForceAddMilestone(BuildContext context) {
    Navigator.of(context).pop(false);
  }
}
