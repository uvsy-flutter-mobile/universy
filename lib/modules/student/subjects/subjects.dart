import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/util/object.dart';

import 'bloc/builder.dart';
import 'bloc/cubit.dart';

class StudentSubjectsModule extends StatefulWidget {
  @override
  _StudentSubjectsModuleState createState() => _StudentSubjectsModuleState();
}

class _StudentSubjectsModuleState extends State<StudentSubjectsModule> {
  SubjectCubit _subjectCubit;

  @override
  void didChangeDependencies() {
    if (isNull(_subjectCubit)) {
      var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
      var careerService = sessionFactory.studentCareerService();
      this._subjectCubit = SubjectCubit(careerService);
      this._subjectCubit.fetchSubjects();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _subjectCubit,
      child: BlocBuilder(
        cubit: _subjectCubit,
        builder: SubjectStateBuilder().builder(),
      ),
    );
  }
}
