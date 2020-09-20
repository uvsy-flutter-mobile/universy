import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/student/event.dart';

import 'states.dart';

const int FIRST_DAY_OF_MONTH = 1;

class EventPanelCubit extends Cubit<EventsPanelState> {
  EventPanelCubit() : super(EventsPanelInitialState());

  Future<void> daySelectedChange(List<StudentEvent> studentEvents) async {
    emit(DaySelectedChangeState(studentEvents));
  }
}
