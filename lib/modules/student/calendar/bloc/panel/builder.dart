import 'package:flutter/material.dart';
import 'package:universy/modules/student/calendar/widget/panel-widget.dart';
import 'package:universy/util/bloc.dart';

import 'states.dart';

class TableCalendarStateBuilder extends WidgetBuilderFactory<EventsPanelState> {
  @override
  Widget translate(EventsPanelState state) {
    if (state is DaySelectedChangeState) {
      return StudentEventsPanelWidget(events: state.studentEvents);
    } else {
      return StudentEventsPanelWidget(events: []);
    }
  }
}
