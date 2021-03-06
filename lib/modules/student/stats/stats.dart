import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/modules/student/stats/career_history.dart';
import 'package:universy/modules/student/stats/career_state_chart.dart';
import 'package:universy/modules/student/stats/charts.dart';
import 'package:universy/modules/student/stats/year_progress.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/decorations/box.dart';

class StatsModule extends StatelessWidget {
  final List<Subject> _subjects;
  final CorrelativesValidator _validator;

  const StatsModule(
      {Key key,
      @required List<Subject> subjects,
      CorrelativesValidator validator})
      : this._subjects = subjects,
        this._validator = validator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> chartsList = [
      _buildStudentCharts(),
      _buildCareerState(),
      _buildYearProgress(),
      _buildCareerHistory(),
    ];
    return Scaffold(
        appBar: _buildStatsBar(),
        body: Container(
          decoration: assetImageDecoration(Assets.UNIVERSY_CITY_BACKGROUND),
          child: Swiper(
            itemCount: chartsList.length,
            pagination: new SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    color: Colors.grey, activeColor: Colors.deepPurple)),
            itemBuilder: (BuildContext context, int index) {
              return chartsList[index];
            },
          ),
        ));
  }

  Widget _buildCareerState() {
    return CareerStateChart(subjects: _subjects);
  }

  Widget _buildStatsBar() {
    return AppBar(
      title: Text(AppText.getInstance().get("student.stats.title")),
    );
  }

  Widget _buildStudentCharts() {
    return DisplayCharts(subjects: _subjects);
  }

  Widget _buildYearProgress() {
    return YearProgressChart(
        subjects: _subjects, correlativesValidator: _validator);
  }

  Widget _buildCareerHistory() {
    return Center(child: CareerHistory(subjects: _subjects));
  }
}
