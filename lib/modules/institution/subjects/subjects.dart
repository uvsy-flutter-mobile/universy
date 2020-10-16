import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/util/object.dart';

import 'bloc/builder.dart';
import 'bloc/cubit.dart';

class InstitutionSubjectsModule extends StatefulWidget {
  @override
  _InstitutionSubjectsModuleState createState() =>
      _InstitutionSubjectsModuleState();
}

class _InstitutionSubjectsModuleState extends State<InstitutionSubjectsModule> {
  InstitutionSubjectsCubit _subjectCubit;

  @override
  void didChangeDependencies() {
    if (isNull(_subjectCubit)) {
      var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
      var studentCareerService = sessionFactory.studentCareerService();
      var institutionService = sessionFactory.institutionService();
      this._subjectCubit = InstitutionSubjectsCubit(
        studentCareerService,
        institutionService,
      );
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
        builder: InstitutionSubjectsStateBuilder().builder(),
      ),
    );
  }
}
