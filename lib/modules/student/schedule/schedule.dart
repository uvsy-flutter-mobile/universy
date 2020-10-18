import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/modules/student/schedule/bloc/cubit.dart';
import 'package:universy/modules/student/schedule/schedule_list.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/decorations/box.dart';

import 'bloc/builder.dart';

class ScheduleModule extends StatefulWidget {
  @override
  _ScheduleModuleState createState() => _ScheduleModuleState();
}

class _ScheduleModuleState extends State<ScheduleModule> {
  ScheduleCubit _scheduleCubit;

  @override
  void didChangeDependencies() {
    if (isNull(_scheduleCubit)) {
      /*var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
      var studentScheduleService = sessionFactory.studentScheduleService();
      this._scheduleCubit = ScheduleCubit(studentScheduleService);*/
      this._scheduleCubit = ScheduleCubit();
      this._scheduleCubit.fetchNotes();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) => _scheduleCubit,
        child: Container(
          decoration: assetImageDecoration(Assets.UNIVERSY_CITY_BACKGROUND),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _buildAppBar(),
            body: _buildBody(),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(AppText.getInstance().get("student.schedule.title")),
      elevation: 10.0,
      automaticallyImplyLeading: true,
    );
  }

  Widget _buildBody() {
    return BlocBuilder(
      cubit: _scheduleCubit,
      builder: ScheduleStateBuilder().builder(),
    );
  }
}
