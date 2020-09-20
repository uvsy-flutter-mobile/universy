import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/util/object.dart';

import 'bloc/builder.dart';
import 'bloc/cubit.dart';

class SubjectBoardModule extends StatefulWidget {
  @override
  _SubjectBoardModuleState createState() => _SubjectBoardModuleState();
}

class _SubjectBoardModuleState extends State<SubjectBoardModule> {
  SubjectBoardCubit _boardCubit;

  @override
  void didChangeDependencies() {
    if (isNull(_boardCubit)) {
      InstitutionSubject subject = ModalRoute.of(context).settings.arguments;
      var serviceFactory = Provider.of<ServiceFactory>(context, listen: false);
      var ratingsService = serviceFactory.ratingsService();
      var institutionService = serviceFactory.institutionService();
      this._boardCubit = SubjectBoardCubit(
        subject,
        ratingsService,
        institutionService,
      );
      this._boardCubit.loadBoard();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _boardCubit,
      child: BlocBuilder(
        cubit: _boardCubit,
        builder: SubjectBoardStateBuilder().builder(),
      ),
    );
  }
}
