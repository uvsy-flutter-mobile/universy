import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optional/optional.dart';
import 'package:provider/provider.dart';
import 'package:universy/constants/subject_level_color.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/ratings.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'bloc/builder.dart';
import 'bloc/cubit.dart';
import 'dialog/dialog.dart';
import 'header.dart';
import 'periods.dart';

const FADING_GRADIENT_FRACTION = 0.045;

class CourseBoardModule extends StatefulWidget {
  @override
  _CourseBoardModuleState createState() => _CourseBoardModuleState();
}

class _CourseBoardModuleState extends State<CourseBoardModule> {
  static const ZERO = 0;

  CourseRatingCubit ratingCubit;
  InstitutionSubject subject;
  Commission commission;
  Course course;

  @override
  void didChangeDependencies() {
    this.extractArgument();
    this.buildCourseRateBloc();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    this.ratingCubit = null;
    super.dispose();
  }

  void extractArgument() {
    CourseBoardModuleArguments arguments =
        ModalRoute.of(context).settings.arguments;
    this.subject = arguments.subject;
    this.course = arguments.course;
    this.commission = arguments.commission;
  }

  void buildCourseRateBloc() {
    if (isNull(ratingCubit)) {
      var ratingsService =
          Provider.of<ServiceFactory>(context).ratingsService();
      this.ratingCubit = CourseRatingCubit(course, ratingsService);
      this.ratingCubit.fetchRating();
    }
  }

  @override
  Widget build(BuildContext context) {
    CourseBoardModuleArguments arguments =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
          backgroundColor: Colors.white, title: Text(arguments.subject.name)),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return EdgePaddingWidget(
      EdgeInsets.all(15),
      ListView(
        controller: ScrollController(),
        children: <Widget>[
          _buildCourseName(context),
          _buildCourseRate(),
          _buildSinglePeriod(),
        ],
      ),
    );
  }

  Widget _buildCourseName(context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 5,
      child: Row(
        children: <Widget>[
          CourseHeaderWidget(
            course: course,
            commission: commission,
            subject: subject,
          ),
          SizedBox(
            width: 14,
          ),
          _buildButtonRatingStar(context)
        ],
      ),
    );
  }

  Widget _buildCourseRate() {
    return CircularRoundedRectangleCard(
      radius: 16.0,
      color: Colors.white,
      child: BlocBuilder(
        cubit: ratingCubit,
        builder: InstitutionCourseRateBuilder().builder(),
      ),
    );
  }

  ListView _buildSinglePeriod() {
    return ListView.builder(
      controller: ScrollController(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return PeriodInformationItem(
          period: course.periods[position],
        );
      },
      itemCount: Optional.of(course)
          .map((course) => course.periods)
          .map((periods) => periods.length)
          .orElse(ZERO),
    );
  }

  Widget _buildButtonRatingStar(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: getLevelColor(subject.level),
      child: Icon(
        Icons.star,
        size: 34,
      ),
      onPressed: () async {
        StudentCourseRating rating = await ratingCubit.fetchStudentRating();
        showDialog(
          context: context,
          builder: (_) => BlocProvider.value(
            value: ratingCubit,
            child: StudentCourseRatingAlertDialog(
              commission: commission,
              studentCourseRating: rating,
              onSaved: _refreshView,
            ),
          ),
        );
      },
    );
  }

  void _refreshView() {}
}

class CourseBoardModuleArguments {
  final InstitutionSubject subject;
  final Commission commission;
  final Course course;

  CourseBoardModuleArguments(this.subject, this.commission, this.course);
}
