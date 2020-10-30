import 'package:intl/intl.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/util/object.dart';

const NO_SCHEDULE_SCRATCH_TIME_TEXT = "...";

class ScheduleScratchTimeRangeFormatter {
  final StudentScheduleScratch _scheduleScratch;

  ScheduleScratchTimeRangeFormatter(this._scheduleScratch);

  String format() {
    if (notNull(_scheduleScratch)) {
      int beginTime = _scheduleScratch.beginDate;
      int endTime = _scheduleScratch.endDate;
      if (notNull(beginTime) && notNull(beginTime)) {
        String beginTimeFormatted = _formatTime(beginTime);
        String endTImeFormatted = _formatTime(endTime);
        return "$beginTimeFormatted - $endTImeFormatted";
      }
    }
    return NO_SCHEDULE_SCRATCH_TIME_TEXT;
  }

  String _formatTime(int time) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(time, isUtc: true);
    DateFormat monthNameFormat = DateFormat.MMMM();
    String monthText = monthNameFormat.format(dateTime);
    String yearText = dateTime.year.toString();
    return "$monthText $yearText";
  }
}
