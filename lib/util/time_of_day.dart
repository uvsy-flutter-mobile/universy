import 'package:flutter/material.dart';
import 'package:universy/util/object.dart';

class TimeOfDayIntConverter {
  static const int DEFAULT_MINUTE = 0;

  TimeOfDay convertFromInt(int timeInt) {
    if (timeInt != DEFAULT_MINUTE) {
      int hours = timeInt ~/ 100;
      int minutes = timeInt % 100;
      return TimeOfDay(hour: hours, minute: minutes);
    }
    return TimeOfDay(hour: DEFAULT_MINUTE, minute: DEFAULT_MINUTE);
  }

  int convertFromTimeOfDay(TimeOfDay time) {
    if (notNull(time)) {
      int hour = time.hour;
      int minutes = time.minute;
      return hour * 100 + minutes;
    }
    return DEFAULT_MINUTE;
  }
}

class TimeOfDayComparator {
  bool isAfter(TimeOfDay comparedTimeOfDay, TimeOfDay referenceTimeOfDay) {
    TimeOfDayIntConverter converter = TimeOfDayIntConverter();
    int referenceIntTime = converter.convertFromTimeOfDay(referenceTimeOfDay);
    int comparedIntTime = converter.convertFromTimeOfDay(comparedTimeOfDay);
    return referenceIntTime < comparedIntTime;
  }

  bool isBefore(TimeOfDay comparedTimeOfDay, TimeOfDay referenceTimeOfDay) {
    TimeOfDayIntConverter converter = TimeOfDayIntConverter();
    int referenceIntTime = converter.convertFromTimeOfDay(referenceTimeOfDay);
    int comparedIntTime = converter.convertFromTimeOfDay(comparedTimeOfDay);
    return referenceIntTime > comparedIntTime;
  }

  bool areEqual(TimeOfDay comparedTimeOfDay, TimeOfDay referenceTimeOfDay) {
    TimeOfDayIntConverter converter = TimeOfDayIntConverter();
    int referenceIntTime = converter.convertFromTimeOfDay(referenceTimeOfDay);
    int comparedIntTime = converter.convertFromTimeOfDay(comparedTimeOfDay);
    return referenceIntTime == comparedIntTime;
  }
}
