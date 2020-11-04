import 'package:intl/intl.dart';
import 'package:universy/util/object.dart';

const NO_SCHEDULE_SCRATCH_TIME_TEXT = "...";

class ScheduleScratchTimeRangeFormatter {
  String format(DateTime beginTime, DateTime endTIme) {
    DateFormat dateFormat = DateFormat("MMM yyyy");
    if (notNull(beginTime) && notNull(endTIme)) {
      String beginTimeFormatted = dateFormat.format(beginTime);
      String endTImeFormatted = dateFormat.format(endTIme);
      return "$beginTimeFormatted - $endTImeFormatted";
    }
    return NO_SCHEDULE_SCRATCH_TIME_TEXT;
  }
}
