import 'package:flutter/material.dart';
import 'package:universy/constants/subject_level_color.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/text/formaters/subject.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/inkwell/clipped.dart';
import 'package:universy/widgets/paddings/edge.dart';

class InstitutionSubjectCardWidget extends StatelessWidget {
  final InstitutionSubject _institutionSubject;
  final InstitutionSubjectCardTap _onCardTap;

  const InstitutionSubjectCardWidget(
      {Key key,
      InstitutionSubject institutionSubject,
      InstitutionSubjectCardTap onCardTap})
      : this._institutionSubject = institutionSubject,
        this._onCardTap = onCardTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AllEdgePaddedWidget(
      padding: 5.0,
      child: getSubjectCard(context),
    );
  }

  Widget getSubjectCard(BuildContext context) {
    int level = _institutionSubject.level;
    Color color = getLevelColor(level);
    return Center(
      child: ClippedInkWell(
        radius: 12,
        onTap: onTap(context),
        splashColor: color,
        child: Container(
          width: 370,
          height: 52,
          child: Row(
            children: <Widget>[
              Expanded(child: _getColorTag(color), flex: 1),
              Expanded(child: _getLevel(), flex: 2),
              VerticalDivider(),
              Expanded(child: _getSubjectName(), flex: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getColorTag(Color color) {
    return SizedBox(child: Container(color: color));
  }

  Widget _getLevel() {
    return OnlyEdgePaddedWidget.left(
      padding: 12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(InstitutionSubjectLevelFormatter(_institutionSubject).format()),
        ],
      ),
    );
  }

  Widget _buildSubjectTypeSubtitle(InstitutionSubject subjects) {
    return Text(AppText.getInstance().get("student.subjects.optative"),
        style: TextStyle(fontSize: 12, color: Colors.grey));
  }

  Widget _getSubjectName() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_institutionSubject.name),
          _institutionSubject.isOptative()
              ? _buildSubjectTypeSubtitle(_institutionSubject)
              : Container()
        ]);
  }

  VoidCallback onTap(BuildContext context) {
    return () => _onCardTap(context, _institutionSubject);
  }
}

typedef InstitutionSubjectCardTap = void Function(
    BuildContext context, InstitutionSubject subject);
