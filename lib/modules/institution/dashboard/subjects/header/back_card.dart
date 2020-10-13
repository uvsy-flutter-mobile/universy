import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/student/ratings.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/flushbar/builder.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'bloc/back/cubit.dart';
import 'star_rating.dart';

const int INITIAL_RATING = 0;

class SubjectHeaderBackCard extends StatefulWidget {
  final int rating;

  SubjectHeaderBackCard._({Key key, this.rating}) : super(key: key);

  factory SubjectHeaderBackCard.from(StudentSubjectRating studentRating) {
    return SubjectHeaderBackCard._(rating: studentRating.rating);
  }

  factory SubjectHeaderBackCard.empty() {
    return SubjectHeaderBackCard._(rating: INITIAL_RATING);
  }

  @override
  _SubjectHeaderBackCardState createState() => _SubjectHeaderBackCardState();
}

class _SubjectHeaderBackCardState extends State<SubjectHeaderBackCard> {
  int rating;
  HeaderBackCardCubit backCubit;

  @override
  void initState() {
    this.rating = widget.rating;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isNull(backCubit)) {
      this.backCubit = BlocProvider.of<HeaderBackCardCubit>(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _getRateQuestion(),
        _buildStarRating(),
        Divider(height: 0),
        _getSaveAndCancelButtons()
      ],
    );
  }

  Widget _getRateQuestion() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 2,
      child: Text(
        //TODO: Apptext
        "Que te parecio esta materia", //AppText.getInstance().get("subjectBoard.whatYouThink"),
        style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStarRating() {
    return StarDisplayWidget(
      onChanged: _changeStarRate,
      stars: rating,
    );
  }

  void _changeStarRate(int stars) {
    setState(() {
      this.rating = stars;
    });
  }

  Widget _getSaveAndCancelButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SaveButton(onSave: _onSave),
        CancelButton(onCancel: _onCancel),
        SizedBox(width: 10)
      ],
    );
  }

  void _onSave() async {
    await AsyncModalBuilder()
        .perform(_saveStudentSubjectRate)
        .withTitle("Guardando valoración") //TODO: apptext
        .then(_buildFlashBarOk)
        .build()
        .run(context);
  }

  void _onCancel() {
    backCubit.flip();
    setState(() {
      this.rating = widget.rating;
    });
  }

  Future<void> _saveStudentSubjectRate(BuildContext context) async {
    await backCubit.saveRating(this.rating);
  }

  void _buildFlashBarOk(BuildContext context) {
    FlushBarBroker()
        .withDuration(5)
        .withIcon(Icon(Icons.spellcheck, color: Colors.green))
        .withMessage(
            // TODO: APPtext
            "Se guardo la evaluacion") //AppText.getInstance().get("subjectBoard.rates.evaluationSaved"))
        .show(context);
  }
}
