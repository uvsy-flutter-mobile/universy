import 'package:flutter/material.dart';

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

  static IconData getIcon(String eventType) {
    if (eventType == EventType.REGULAR_EXAM) {
      return Icons.assignment;
    } else if (eventType == EventType.FINAL_EXAM) {
      return Icons.assignment_turned_in;
    } else if (eventType == EventType.NO_CLASS) {
      return Icons.event_seat;
    } else if (eventType == EventType.DUE_DATE) {
      return Icons.work;
    } else if (eventType == EventType.RECUP_EXAM) {
      return Icons.swap_horiz;
    } else if (eventType == EventType.PRESENTATION) {
      return Icons.record_voice_over;
    } else if (eventType == EventType.LABORATORY) {
      return Icons.opacity;
    } else {
      return Icons.adjust;
    }
  }
}
