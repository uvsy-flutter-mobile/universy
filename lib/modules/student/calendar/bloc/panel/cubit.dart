import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

const int FIRST_DAY_OF_MONTH = 1;
const int EXTRA_MONTH = 1;

class EventPanelCubit extends Cubit<EventsPanelState> {
  final StudentEventService _studentEventsService;

  EventPanelCubit(this._studentEventsService) : super(EventsPanelInitialState());

  Future<void> daySelectedChange(List<StudentEvent> studentEvents) async {
    emit(DaySelectedChangeState(studentEvents));
  }

  Future<void> refreshPanelCalendar(DateTime dateSelected) async {
    DateTime dateFrom = DateTime(dateSelected.year, dateSelected.month, FIRST_DAY_OF_MONTH);
    DateTime dateTo = DateTime(dateSelected.year, dateSelected.month + EXTRA_MONTH, 0);
    var studentEvents = await _studentEventsService.getStudentEvents(dateFrom, dateTo);
    return this.daySelectedChange(studentEvents);
  }
}
