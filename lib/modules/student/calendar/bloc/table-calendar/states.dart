import 'package:equatable/equatable.dart';
import 'package:universy/model/student/event.dart';

abstract class TableCalendarState extends Equatable {
  final DateTime dateSelected;
  final List<StudentEvent> studentEvents;

  TableCalendarState(this.dateSelected, this.studentEvents) : super();

  @override
  List<Object> get props => [dateSelected, studentEvents];
}

class TableCalendarInitialState extends TableCalendarState {
  TableCalendarInitialState() : super(DateTime.now(), List());
}

class TableCalendarEventsUpdatedState extends TableCalendarState {
  TableCalendarEventsUpdatedState(
      DateTime dateSelected, List<StudentEvent> studentEvents)
      : super(dateSelected, studentEvents);
}
