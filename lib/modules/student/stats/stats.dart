import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/modules/student/stats/career_history.dart';
import 'package:universy/modules/student/stats/charts.dart';
import 'package:universy/modules/student/stats/year_progress.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/widgets/decorations/box.dart';

class StatsModule extends StatelessWidget {
  final List<Subject> _subjects;

  const StatsModule({Key key, @required List<Subject> subjects})
      : this._subjects = subjects,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> chartsList = [
      _buildStudentCharts(),
      _buildYearProgress(),
      _buildCareerHistory()
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

  Widget _buildStatsBar() {
    return AppBar(
      title: Text("Estadistica del alumno"),
    );
  }

  Widget _buildStudentCharts() {
    return DisplayCharts(subjects: _subjects);
  }

  Widget _buildYearProgress() {
    return YearProgressChart(subjects: _subjects);
  }

  Widget _buildCareerHistory() {
    return Center(child: CareerHistory(subjects: _subjects));
  }
}
