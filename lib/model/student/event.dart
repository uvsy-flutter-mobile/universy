import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optional/optional.dart';
import 'package:universy/model/copyable.dart';
import 'package:universy/model/json.dart';
import 'package:universy/text/translators/event_type.dart';
import 'package:universy/util/object.dart';
import 'package:universy/util/time-of-day.dart';

const DATE_FORMAT = "dd-MMM-yyyy";
const String EMPTY_STRING = "";

class StudentEvent implements JsonConvertible, Copyable<StudentEvent> {
  String userId;
  String eventId;
  String title;
  DateTime date;
  String eventType;
  String description;
  TimeOfDay timeTo;
  TimeOfDay timeFrom;

  StudentEvent.empty();

  StudentEvent(
    this.userId,
    this.eventId,
    this.title,
    this.date,
    this.eventType,
    this.description,
    this.timeTo,
    this.timeFrom,
  );

  factory StudentEvent.fromJson(Map<String, dynamic> json) {
    TimeOfDayIntConverter timeOfDayIntConverter = TimeOfDayIntConverter();
    DateFormat dateFormat = DateFormat(DATE_FORMAT);

    String userId = json["userId"];
    String eventId = json["eventId"];
    String title = json["title"];
    DateTime date = dateFormat.parse(json["date"]);
    String eventType = json["eventType"];
    String description = json["description"];
    TimeOfDay timeTo = timeOfDayIntConverter.convertFromInt(json["timeTo"]);
    TimeOfDay timeFrom = timeOfDayIntConverter.convertFromInt(json["timeFrom"]);

    return StudentEvent(
      userId,
      eventId,
      title,
      date,
      eventType,
      description,
      timeTo,
      timeFrom,
    );
  }

  bool get isNewEvent => isNull(eventId);

  @override
  Map<String, dynamic> toJson() {
    DateFormat dateFormat = DateFormat(DATE_FORMAT);
    TimeOfDayIntConverter timeOfDayIntConverter = TimeOfDayIntConverter();

    String description =
        Optional.ofNullable(this.description).orElse(EMPTY_STRING);
    int timeFromSend = timeOfDayIntConverter.convertFromTimeOfDay(timeFrom);
    int timeToSend = timeOfDayIntConverter.convertFromTimeOfDay(timeTo);
    String dateFormatted = dateFormat.format(date);

    var json = {
      "userId": userId,
      "title": title,
      "date": description,
      "eventType": eventType,
      "description": dateFormatted,
      "timeTo": timeFromSend,
      "timeFrom": timeToSend,
    };
    if (!isNewEvent) {
      json["eventId"] = eventId;
    }
    return json;
  }

  @override
  StudentEvent copy() {
    return StudentEvent.fromJson(this.toJson());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentEvent &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          eventId == other.eventId &&
          title == other.title &&
          date == other.date &&
          timeTo == other.timeTo &&
          timeFrom == other.timeFrom &&
          eventType == other.eventType &&
          description == other.description;

  @override
  int get hashCode =>
      userId.hashCode ^
      eventId.hashCode ^
      title.hashCode ^
      date.hashCode ^
      timeTo.hashCode ^
      timeFrom.hashCode ^
      eventType.hashCode ^
      description.hashCode;
}

abstract class EventType {
  static const String DUE_DATE = "DUE_DATE";
  static const String EXTRA_CLASS = "EXTRA_CLASS";
  static const String FINAL_EXAM = "FINAL_EXAM";
  static const String LABORATORY = "LABORATORY";
  static const String NO_CLASS = "NO_CLASS";
  static const String PRESENTATION = "PRESENTATION";
  static const String RECUP_EXAM = "RECUP_EXAM";
  static const String REGULAR_EXAM = "REGULAR_EXAM";
  static const String REPORT_SIGN_OFF = "REPORT_SIGN_OFF";

  static List<String> values() {
    return [
      DUE_DATE,
      EXTRA_CLASS,
      FINAL_EXAM,
      LABORATORY,
      NO_CLASS,
      PRESENTATION,
      RECUP_EXAM,
      REGULAR_EXAM,
      REPORT_SIGN_OFF,
    ];
  }
}

class EventTypeDescription {
  final String _eventType;
  final String _description;

  EventTypeDescription(this._eventType, this._description);

  String get description => _description;

  String get eventType => _eventType;

  static List<EventTypeDescription> getEventTypes() {
    EventTypeTranslator eventTypeTranslator = EventTypeTranslator();
    return EventType.values()
        .map((type) =>
            EventTypeDescription(type, eventTypeTranslator.translate(type)))
        .toList();
  }
}
