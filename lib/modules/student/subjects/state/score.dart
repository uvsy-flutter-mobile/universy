import 'package:flutter/material.dart';
import 'package:optional/optional_internal.dart';
import 'package:universy/model/subject.dart';

class ScoreSubjectWidget extends StatefulWidget {
  final Subject subject;

  const ScoreSubjectWidget({Key key, this.subject}) : super(key: key);

  @override
  _ScoreSubjectWidgetState createState() => _ScoreSubjectWidgetState();
}

class _ScoreSubjectWidgetState extends State<ScoreSubjectWidget> {
  Subject _subject;
  double _sliderValue;

  @override
  void initState() {
    this._sliderValue = 10.0;
    this._subject = widget.subject;
    super.initState();
  }

  @override
  void dispose() {
    this._sliderValue = null;
    this._subject = null;
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.0),
      child: Column(
        children: <Widget>[
          _buildScoreLabel(),
          _buildScoreSlide(),
        ],
      ),
    );
  }

  Widget _buildScoreLabel() {
    bool enable = _validateMilestoneApproved();
    return FloatingActionButton(
      elevation: 0.0,
      onPressed: enable ? () {} : null,
      shape: _buildScoreShape(),
      backgroundColor: enable ? Colors.lightBlue : Colors.grey,
      child: _buildValidateScore(),
    );
  }

  Widget _buildValidateScore() {
    int score = _validateMilestoneScoreExist();
    return Text(score == 0 ? "-" : score.toString(),
        textAlign: TextAlign.left,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30.0));
  }

  ShapeBorder _buildScoreShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)));
  }

  bool _validateMilestoneApproved() {
    bool enable = _subject.isApproved();
    return enable;
  }

  int _validateMilestoneScoreExist() {
    int score = _subject.score ?? 0;
    return score;
  }

  Widget _buildScoreSlide() {
    bool enable = _subject.isApproved();
    int score = _subject.score ?? 0;
    return Slider(
      min: 0.0,
      max: 10.0,
      divisions: 10,
      activeColor: Colors.lightBlue,
      inactiveColor: Colors.grey,
      label: (_sliderValue.toInt().toString()),
      onChanged: enable ? updateSlider : null,
      value: score.toDouble(),
    );
  }

  void updateSlider(double value) {
    setState(() {
      _sliderValue = value;
      _subject.score = Optional.ofNullable(_sliderValue)
          .map((value) => value.toInt())
          .filter((value) => value > 0)
          .orElse(null);
    });
  }
}
