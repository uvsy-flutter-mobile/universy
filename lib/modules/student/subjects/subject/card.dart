import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/constants/subject_level_color.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/text/formaters/subject.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/inkwell/clipped.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'icon.dart';

class SubjectCardWidget extends StatelessWidget {
  final Subject _subject;
  final SubjectCardTap _onCardTap;

  const SubjectCardWidget({Key key, Subject subject, SubjectCardTap onCardTap})
      : this._subject = subject,
        this._onCardTap = onCardTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return EdgePaddingWidget(EdgeInsets.all(5.0), getSubjectCard(context));
  }

  Widget getSubjectCard(BuildContext context) {
    int level = _subject.level;
    Color color = getLevelColor(level);
    return Center(
      child: ClippedInkWell(
        onTap: onTap(context),
        splashColor: color,
        child: Container(
          width: 300,
          height: 75,
          child: Row(
            children: <Widget>[
              Expanded(child: getColorTag(color), flex: 1),
              Expanded(child: getLogoAndLevel(level, context), flex: 3),
              VerticalDivider(width: 2),
              Expanded(child: getSubjectName(), flex: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget getColorTag(Color color) {
    return SizedBox(child: Container(color: color));
  }

  Widget getLogoAndLevel(int level, BuildContext context) {
    CorrelativesValidator correlativesValidator =
        Provider.of<CorrelativesValidator>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(SubjectIconResolver(correlativesValidator).getSubjectIcon(
          _subject,
        )),
        SizedBox(height: 10),
        Container(
          child: Center(
            child: Text(
              SubjectLevelFormatter(_subject).format(),
            ),
          ),
        ),
        (_subject.isOptative()) ? Text(AppText.getInstance().get("student.subjects.optative"),style: TextStyle(fontSize: 12),):Container()
      ],
    );
  }

  Widget getSubjectName() {
    return OnlyEdgePaddedWidget.left(
      padding: 16,
      child: Container(
          child: Text(_subject.name), alignment: Alignment.centerLeft),
    );
  }

  VoidCallback onTap(BuildContext context) {
    return () => _onCardTap(context, _subject);
  }
}

typedef SubjectCardTap = void Function(BuildContext context, Subject subject);
