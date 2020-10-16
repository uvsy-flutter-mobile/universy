import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/modules/institution/dashboard/subjects/courses/bloc/builder.dart';
import 'package:universy/modules/institution/dashboard/subjects/courses/bloc/cubit.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/paddings/edge.dart';

class SubjectBoardCourses extends StatefulWidget {
  final InstitutionSubject subject;

  SubjectBoardCourses({
    Key key,
    InstitutionSubject subject,
  })  : this.subject = subject,
        super(key: key);

  @override
  _SubjectBoardCoursesState createState() => _SubjectBoardCoursesState();
}

class _SubjectBoardCoursesState extends State<SubjectBoardCourses> {
  BoardCoursesCubit cubit;

  @override
  void didChangeDependencies() {
    var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
    var institutionService = sessionFactory.institutionService();
    if (isNull(cubit)) {
      this.cubit = BoardCoursesCubit(widget.subject, institutionService);
    }
    this.cubit.fetchCourses();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 5,
      child: BlocProvider(
        create: (_) => cubit,
        child: BlocBuilder(
          cubit: cubit,
          builder: BoardCoursesStateBuilder().builder(),
        ),
      ),
    );
  }
}
