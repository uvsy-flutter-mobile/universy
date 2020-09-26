import 'package:flutter/material.dart';
import 'package:universy/util/object.dart';

class TimeOfDayIntConverter {
  static const int NULL_INT = 0;
  static const int DEFAULT_HOUR = 00;

  TimeOfDay convertFromInt(int timeInt) {
    if (timeInt != NULL_INT) {
      int hours = timeInt ~/ 100;
      int minutes = timeInt % 100;
      return TimeOfDay(hour: hours, minute: minutes);
    }
    return TimeOfDay(hour: DEFAULT_HOUR, minute: DEFAULT_HOUR);
  }

  int convertFromTimeOfDay(TimeOfDay time) {
    if (notNull(time)) {
      int hour = time.hour;
      int minutes = time.minute;
      return hour * 100 + minutes;
    }
    return NULL_INT;
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
