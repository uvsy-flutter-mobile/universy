import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optional/optional.dart';
import 'package:universy/constants/event_types.dart';
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

  StudentEvent(this.userId,
      this.eventId,
      this.title,
      this.date,
      this.eventType,
      this.description,
      this.timeTo,
      this.timeFrom,);

  factory StudentEvent.fromJson(Map<String, dynamic> json) {
    TimeOfDayIntConverter timeOfDayIntConverter = TimeOfDayIntConverter();
    DateFormat dateFormat = DateFormat(DATE_FORMAT);

    DateTime dateTimeFromJson;
    var dateFromJson = json["date"];

    if (dateFromJson is int) {
      dateTimeFromJson = DateTime.fromMillisecondsSinceEpoch(dateFromJson);
    } else if (dateFromJson is String) {
      dateTimeFromJson = dateFormat.parse(dateFromJson);
    }

    String userId = json["userId"];
    String eventId = json["eventId"];
    String title = json["title"];
    DateTime date = dateTimeFromJson;
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
      "date": dateFormatted,
      "eventType": eventType,
      "description": description,
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

class EventTypeItem {
  final String _eventType;
  final String _description;
  final IconData _iconData;

  EventTypeItem(this._eventType, this._description, this._iconData);

  String get description => _description;

  String get eventType => _eventType;

  IconData get iconData => _iconData;

  static List<EventTypeItem> getEventTypes() {
    EventTypeDescriptionTranslator eventTypeTranslator =
    EventTypeDescriptionTranslator();
    return EventType.values()
        .map((type) =>
        EventTypeItem(
            type, eventTypeTranslator.translate(type), EventType.getIcon(type)))
        .toList();
  }
}
