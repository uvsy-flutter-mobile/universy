import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/modules/student/calendar/bloc/panel/builder.dart';
import 'package:universy/modules/student/calendar/bloc/panel/cubit.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/text/text.dart';

import 'bloc/table-calendar/builder.dart';
import 'bloc/table-calendar/cubit.dart';

class StudentCalendarModule extends StatefulWidget {
  @override
  _StudentCalendarModuleState createState() => _StudentCalendarModuleState();
}

class _StudentCalendarModuleState extends State<StudentCalendarModule> {
  TableCalendarCubit _tableCalendarCubit;
  EventPanelCubit _eventPanelCubic;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _buildTableCalendarCubit();
    _buildEventPanelCubit();
    super.didChangeDependencies();
  }

  void _buildTableCalendarCubit() {
    if (_tableCalendarCubit == null) {
      var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
      var studentEventService = sessionFactory.studentEventService();
      this._tableCalendarCubit = TableCalendarCubit(studentEventService);
      this._tableCalendarCubit.fetchStudentEvents();
    }
  }

  void _buildEventPanelCubit() {
    if (_eventPanelCubic == null) {
      var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
      var studentEventService = sessionFactory.studentEventService();
      this._eventPanelCubic = EventPanelCubit(studentEventService);
      this._eventPanelCubic.refreshPanelCalendar(DateTime.now());
    }
  }

  @override
  void dispose() {
    this._tableCalendarCubit = null;
    this._eventPanelCubic = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => _tableCalendarCubit,
        ),
        BlocProvider(
          create: (BuildContext context) => _eventPanelCubic,
        )
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text(AppText.getInstance().get("student.calendar.title")),
            leading: _returnToMain()),
        body: SlidingUpPanel(
          backdropEnabled: false,
          isDraggable: true,
          slideDirection: SlideDirection.UP,
          panel: BlocBuilder(
            cubit: _eventPanelCubic,
            builder: EventsPanelStateBuilder().builder(),
          ),
          body: Scaffold(
            body: BlocBuilder(
              cubit: _tableCalendarCubit,
              builder: TableCalendarStateBuilder().builder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _returnToMain() {
    return BackButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.HOME);
      },
    );
  }
}
