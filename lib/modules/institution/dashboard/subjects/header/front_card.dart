import 'package:flutter/material.dart';
import 'package:universy/constants/subject_level_color.dart';
import 'package:universy/model/institution/ratings.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/text/formaters/subject.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/paddings/edge.dart';

const DEFAULT_RATING = 0.0;
const DEFAULT_TOTAL = 0;

class SubjectHeaderFrontCard extends StatelessWidget {
  final InstitutionSubject _subject;
  final double _rating;
  final int _amountOfRatings;
  static const TOTAL = "/5";

  SubjectHeaderFrontCard._(
      {Key key, double rating, int amountOfRatings, InstitutionSubject subject})
      : this._rating = rating,
        this._amountOfRatings = amountOfRatings,
        this._subject = subject,
        super(key: key);

  factory SubjectHeaderFrontCard.from(
    InstitutionSubject subject,
    SubjectRating subjectRating,
  ) {
    return SubjectHeaderFrontCard._(
      subject: subject,
      rating: subjectRating.calculateAverage(),
      amountOfRatings: subjectRating.totalRatings(),
    );
  }

  factory SubjectHeaderFrontCard.empty(
    InstitutionSubject subject,
  ) {
    return SubjectHeaderFrontCard._(
      subject: subject,
      rating: DEFAULT_RATING,
      amountOfRatings: DEFAULT_TOTAL,
    );
  }

  @override
  Widget build(dynamic institutionSubjectRating) {
    return Column(
      children: <Widget>[
        Expanded(child: _buildSubjectNameRatingAndLevel(), flex: 12),
        Expanded(child: _buildAmountOfRatingsText(), flex: 3)
      ],
    );
  }

  Widget _buildSubjectNameRatingAndLevel() {
    return Row(
      children: <Widget>[
        Expanded(child: _buildSubjectNameAndRating(), flex: 6),
        Expanded(child: _buildSubjectLevel(), flex: 3)
      ],
    );
  }

  Widget _buildSubjectNameAndRating() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSubjectNameText(),
        _buildRating(),
      ],
    );
  }

  Widget _buildSubjectNameText() {
    return OnlyEdgePaddedWidget.left(
      padding: 20,
      child: Text(
        _subject.name,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildRating() {
    return OnlyEdgePaddedWidget.left(
      padding: 20,
      child: Row(
        children: <Widget>[
          _buildSubjectRatingText(),
          _buildSubjectRatingTextTotal(),
          _buildStar(),
        ],
      ),
    );
  }

  Widget _buildSubjectRatingText() {
    String ratingText = " - ";
    if (this._rating > 0) {
      ratingText = "${this._rating.toStringAsFixed(2)}";
    }
    return Text(
      ratingText,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  Widget _buildSubjectRatingTextTotal() {
    String ratingText = TOTAL;
    return Text(
      ratingText,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20, color: Colors.black87),
    );
  }

  Widget _buildStar() {
    return Icon(
      Icons.star,
      size: 25,
      color: Colors.black,
    );
  }

  Widget _buildSubjectLevel() {
    String yearText = InstitutionSubjectLevelFormatter(_subject).format();
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: getLevelColor(_subject.level), shape: BoxShape.circle),
      child: Text(yearText,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _buildAmountOfRatingsText() {
    if (this._amountOfRatings > 0) {
      return _buildTotalRatings();
    }
    return _buildNoExistingRating();
  }

  Widget _buildTotalRatings() {
    int amountOfRatings = this._amountOfRatings;
    String ratedBy = AppText.getInstance()
        .get("institution.dashboard.subject.label.ratedBy");
    String studentResource = amountOfRatings > 1 ? "students" : "student";
    String student = AppText.getInstance().get(
      "institution.dashboard.subject.label.$studentResource",
    );

    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 18, color: Colors.black),
        children: <TextSpan>[
          TextSpan(text: ratedBy),
          TextSpan(
            text: " $amountOfRatings ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: student),
        ],
      ),
    );
  }

  Widget _buildNoExistingRating() {
    return RichText(
      text: TextSpan(
        text: AppText.getInstance()
            .get("institution.dashboard.subject.label.noRating"),
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}
