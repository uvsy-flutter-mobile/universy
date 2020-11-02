import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/modules/student/schedule/bloc/builders/appBar.dart';
import 'package:universy/modules/student/schedule/bloc/cubit.dart';
import 'package:universy/modules/student/schedule/schedule_list.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/decorations/box.dart';

import 'bloc/builders/schedule.dart';

class ScheduleModule extends StatefulWidget {
  @override
  _ScheduleModuleState createState() => _ScheduleModuleState();
}

class _ScheduleModuleState extends State<ScheduleModule> {
  ScheduleCubit _scheduleCubit;

  @override
  void didChangeDependencies() {
    if (isNull(_scheduleCubit)) {
      var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
      var studentScheduleService = sessionFactory.studentScheduleService();
      var studentCareerService = sessionFactory.studentCareerService();
      var institutionService = sessionFactory.institutionService();

      this._scheduleCubit = ScheduleCubit(
        studentScheduleService,
        institutionService,
        studentCareerService,
      );
      this._scheduleCubit.fetchScratches();
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
            appBar: ScheduleAppBar(),
            body: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder(
      cubit: _scheduleCubit,
      builder: ScheduleStateBuilder().builder(),
    );
  }
}

class ScheduleAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ScheduleCubit>(context);
    return BlocBuilder(
      cubit: cubit,
      builder: AppBarStateBuilder().builder(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
