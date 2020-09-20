import 'package:universy/model/institution/schedule.dart';
import 'package:universy/util/object.dart';

const NO_SCHEDULE_TIME_TEXT = "...";
const ZERO = "0";

class ScheduleTimeRangeFormatter {
  final Schedule _schedule;

  ScheduleTimeRangeFormatter(this._schedule);

  String format() {
    if (notNull(_schedule)) {
      int beginTime = _schedule.beginTime;
      int endTime = _schedule.endTime;
      if (notNull(beginTime) && notNull(beginTime)) {
        String beginTimeFormatted = _formatTime(beginTime);
        String endTImeFormatted = _formatTime(endTime);
        return "$beginTimeFormatted - $endTImeFormatted";
      }
    }
    return NO_SCHEDULE_TIME_TEXT;
  }

  String _formatTime(int time) {
    String hours = (time ~/ 100).toString().padLeft(2, ZERO);
    String minutes = (time % 100).toString().padLeft(2, ZERO);
    return "$hours:$minutes";
  }
}
