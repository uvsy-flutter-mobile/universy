import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/services/manifest.dart';
import 'states.dart';

const int FIRST_DAY_OF_MONTH = 1;

class TableCubit extends Cubit<TableCalendarState> {
  final StudentCareerService _studentEventsService;

  TableCubit(this._studentEventsService) : super(TableCalendarInitialState());

  Future<void> fetchStudentEventForPeriod(
      DateTime dateSelected, DateTime dateFrom, DateTime dateTo) async {
    var studentEvents =
        await _studentEventsService.getStudentEvents(dateFrom, dateTo);
    emit(TableCalendarEventsUpdatedState(
        dateSelected, studentEvents.studentEvents));
  }

  Future<void> refreshTableCalendar(DateTime dateSelected) async {
    DateTime dateFrom =
        DateTime(dateSelected.year, dateSelected.month, FIRST_DAY_OF_MONTH);
    DateTime dateTo = DateTime(dateSelected.year, dateSelected.month + 1, 0);
    var studentEvents =
        await _studentEventsService.getStudentEvents(dateFrom, dateTo);
    emit(TableCalendarEventsUpdatedState(
        dateSelected, studentEvents.studentEvents));
  }
}
