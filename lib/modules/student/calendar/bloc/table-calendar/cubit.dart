import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

const int FIRST_DAY_OF_MONTH = 1;
const int EXTRA_MONTH = 1;

class TableCalendarCubit extends Cubit<TableCalendarState> {
  final StudentEventService _studentEventsService;

  TableCalendarCubit(this._studentEventsService)
      : super(TableCalendarInitialState());

  Future<void> fetchStudentEventForPeriod(
      DateTime dateSelected, DateTime dateFrom, DateTime dateTo) async {
    var studentEvents =
        await _studentEventsService.getStudentEvents(dateFrom, dateTo);
    emit(TableCalendarEventsUpdatedState(dateSelected, studentEvents));
  }

  Future<void> fetchStudentEvents() {
    DateTime todayDate = DateTime.now();
    DateTime dateSelected =
        DateTime(todayDate.year, todayDate.month, todayDate.day);
    DateTime dateFrom =
        DateTime(dateSelected.year, dateSelected.month, FIRST_DAY_OF_MONTH);
    var dateToMonth = dateSelected.month + 1;
    DateTime dateTo =
        DateTime(dateSelected.year, dateToMonth, FIRST_DAY_OF_MONTH);

    return this.fetchStudentEventForPeriod(dateSelected, dateFrom, dateTo);
  }

  Future<void> refreshTableCalendar(DateTime dateSelected) async {
    DateTime dateFrom =
        DateTime(dateSelected.year, dateSelected.month, FIRST_DAY_OF_MONTH);
    DateTime dateTo =
        DateTime(dateSelected.year, dateSelected.month + EXTRA_MONTH, 0);
    var studentEvents =
        await _studentEventsService.getStudentEvents(dateFrom, dateTo);
    emit(TableCalendarEventsUpdatedState(dateSelected, studentEvents));
  }
}
