import 'package:flutter/material.dart';
import 'package:universy/modules/student/calendar/widget/calendar.dart';
import 'package:universy/util/bloc.dart';

import 'states.dart';

class TableCalendarStateBuilder
    extends WidgetBuilderFactory<TableCalendarState> {
  @override
  Widget translate(TableCalendarState state) {
    return StudentCalendarWidget(
      studentEvents: state.studentEvents,
      selectedDate: state.dateSelected,
    );
  }
}
