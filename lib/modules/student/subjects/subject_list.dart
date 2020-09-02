import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/constants/gradient_fraction.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/modules/student/subjects/state/state_dialog.dart';

import 'subject/card.dart';

class StudentSubjectList extends StatelessWidget {
  final String _title;
  final List<Subject> _subjects;
  final Function(Subject subject) _onUpdate;

  const StudentSubjectList(
      {Key key,
      @required String title,
      @required List<Subject> subjects,
      @required Function(Subject subject) onUpdate})
      : this._title = title,
        this._subjects = subjects,
        this._onUpdate = onUpdate,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(_title)),
      body: FadingEdgeScrollView.fromScrollView(
        gradientFractionOnStart: GradientFraction.SMALL,
        gradientFractionOnEnd: GradientFraction.NONE,
        child: ListView.builder(
          controller: ScrollController(),
          itemCount: _subjects.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: _subjectBuilder,
        ),
      ),
    );
  }

  Widget _subjectBuilder(BuildContext context, int index) {
    Subject subject = _subjects[index];
    return SubjectCardWidget(subject: subject, onCardTap: showSubjectState);
  }

  void showSubjectState(BuildContext context, Subject subject) {
    CorrelativesValidator correlativesValidator =
        Provider.of<CorrelativesValidator>(context, listen: false);
    showDialog(
        context: context,
        builder: (BuildContext context) => SubjectStateDialog(
              subject: subject.copy(),
              onUpdate: _onUpdate,
              correlativeValidator: correlativesValidator,
            ));
  }
}
