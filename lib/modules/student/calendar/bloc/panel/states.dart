import 'package:equatable/equatable.dart';
import 'package:universy/model/student/events/student-event.dart';

abstract class EventsPanelState extends Equatable {
  EventsPanelState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class EventsPanelInitialState extends EventsPanelState {}

class DaySelectedChangeState extends EventsPanelState {
  final List<StudentEvent> studentEvents;

  DaySelectedChangeState(this.studentEvents) : super([studentEvents]);
}
