import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optional/optional.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/lock.dart';
import 'package:universy/model/student/ratings.dart';
import 'package:universy/modules/institution/dashboard/course/bloc/cubit.dart';
import 'package:universy/modules/institution/dashboard/course/dialog/slider.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/flushbar/builder.dart';

import 'tags.dart';
import 'take_again.dart';

const SPACE_BETWEEN = " ";

const int INITIAL_OVERALL_RATING = 3;
const int INITIAL_DIFFICULTY_RATING = 3;
const bool INITIAL_WOULD_TAKE_AGAIN = true;
const List<String> INITIAL_TAG_CODES = [];

class StudentCourseRatingAlertDialog extends StatefulWidget {
  final StudentCourseRating _studentCourseRating;
  final Commission _commission;
  final Function() _onSaved;

  const StudentCourseRatingAlertDialog({
    Key key,
    @required StudentCourseRating studentCourseRating,
    @required Function() onSaved,
    @required Commission commission,
  })  : this._studentCourseRating = studentCourseRating,
        this._commission = commission,
        this._onSaved = onSaved,
        super(key: key);

  @override
  _StudentCourseRatingAlertDialogState createState() =>
      _StudentCourseRatingAlertDialogState();
}

class _StudentCourseRatingAlertDialogState
    extends State<StudentCourseRatingAlertDialog> {
  StudentCourseRating _studentCourseRating;
  Commission _commission;
  StateLock<StudentCourseRating> _studentCourseRatingLock;

  @override
  void initState() {
    this._commission = widget._commission;
    this._studentCourseRating = widget._studentCourseRating.copy();
    this._studentCourseRatingLock =
        StateLock.lock(snapshot: widget._studentCourseRating);
    this._prepareStudentCourseRating();
    super.initState();
  }

  void _prepareStudentCourseRating() {
    this._studentCourseRating.overall = _getInitialOverallValue();
    this._studentCourseRating.difficulty = _getInitialDifficultyValue();
    this._studentCourseRating.wouldTakeAgain = _getInitialWouldTakeAgainValue();
    this._studentCourseRating.tags = _getInitialTagCodes();
  }

  @override
  void dispose() {
    this._studentCourseRating = null;
    this._commission = null;
    this._studentCourseRatingLock = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: _buildShape(),
      elevation: 80.0,
      title: _buildTitle(),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: _buildRateContent(),
      actions: <Widget>[
        SaveButton(onSave: _onSaveButtonPressed),
        CancelButton(onCancel: () => Navigator.pop(context)),
      ],
    );
  }

  RichText _buildTitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
              text: AppText.getInstance()
                  .get("institution.dashboard.course.actions.rate")),
          TextSpan(text: SPACE_BETWEEN),
          TextSpan(
            text: _commission.name,
            style: TextStyle(
              color: Colors.orangeAccent,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
        style: TextStyle(color: Colors.black, fontSize: 35),
      ),
    );
  }

  ShapeBorder _buildShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)));
  }

  void _onSaveButtonPressed() async {
    if (_studentCourseRatingLock.hasChange(_studentCourseRating)) {
      await AsyncModalBuilder()
          .perform((_) => _saveStudentCourseRating(_studentCourseRating))
          .withTitle(AppText.getInstance()
              .get("institution.dashboard.course.info.saving"))
          .then(_afterSave)
          .build()
          .run(context);
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _saveStudentCourseRating(StudentCourseRating rating) {
    return BlocProvider.of<CourseRatingCubit>(context)
        .saveStudentRating(rating);
  }

  void _afterSave(BuildContext context) {
    Navigator.pop(context);
    this._buildFlashBarOk(context);
  }

  void _buildFlashBarOk(BuildContext context) {
    FlushBarBroker()
        .withDuration(5)
        .withIcon(Icon(Icons.spellcheck, color: Colors.green))
        .withMessage(AppText.getInstance()
            .get("institution.dashboard.course.info.saved"))
        .show(context);
  }

  void _changeOverallRate(int value) {
    setState(() {
      _studentCourseRating.overall = value;
    });
  }

  void _changeDifficultyRate(int value) {
    setState(() {
      _studentCourseRating.difficulty = value;
    });
  }

  void _wouldTakeAgainRate(bool value) {
    setState(() {
      _studentCourseRating.wouldTakeAgain = value;
    });
  }

  Widget _buildRateContent() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 15),
      child: Wrap(
        children: <Widget>[
          _buildOverallSlider(),
          _buildDifficultySlider(),
          StudentCourseWouldTakeAgainWidget(
            onChange: _wouldTakeAgainRate,
            wouldTakeAgain: _studentCourseRating.wouldTakeAgain,
          ),
          Divider(),
          StudentCourseRageTagsWidget(
            selectedTags: _studentCourseRating.tags,
            onTagPressed: (tagCode, pressTag) => _tagPressed(tagCode, pressTag),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallSlider() {
    return StudentCourseRateSliderWidget(
      onChange: _changeOverallRate,
      sliderValue: _studentCourseRating.overall,
      sliderLabel: AppText.getInstance()
          .get("institution.dashboard.course.labels.overallTitle"),
    );
  }

  Widget _buildDifficultySlider() {
    return StudentCourseRateSliderWidget(
      onChange: _changeDifficultyRate,
      sliderValue: _studentCourseRating.difficulty,
      sliderLabel: AppText.getInstance()
          .get("institution.dashboard.course.labels.dificultyTitle"),
      negativeRating: true,
    );
  }

  int _getInitialOverallValue() {
    return Optional.ofNullable(_studentCourseRating)
        .map((studentCourseRating) => studentCourseRating.overall)
        .orElse(INITIAL_OVERALL_RATING);
  }

  int _getInitialDifficultyValue() {
    return Optional.ofNullable(_studentCourseRating)
        .map((studentCourseRating) => studentCourseRating.difficulty)
        .orElse(INITIAL_DIFFICULTY_RATING);
  }

  bool _getInitialWouldTakeAgainValue() {
    return Optional.ofNullable(_studentCourseRating)
        .map((studentCourseRating) => studentCourseRating.wouldTakeAgain)
        .orElse(INITIAL_WOULD_TAKE_AGAIN);
  }

  List<String> _getInitialTagCodes() {
    return Optional.ofNullable(_studentCourseRating)
        .map((studentCourseRating) => studentCourseRating.tags)
        .orElse(INITIAL_TAG_CODES);
  }

  void _tagPressed(dynamic tagCode, bool pressTag) {
    if (pressTag) {
      _studentCourseRating.addTag(tagCode);
    } else {
      _studentCourseRating.removeTag(tagCode);
    }
  }
}
