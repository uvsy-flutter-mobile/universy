import 'dart:ui';

import 'package:flutter/material.dart';

const Map<int, Color> SUBJECT_LEVEL_COLORS = {
  1: Colors.deepOrange,
  2: Colors.green,
  3: Colors.blue,
  4: Colors.orangeAccent,
  5: Colors.indigo
};

const Map<int, Color> SUBJECT_LEVEL_TEXT_COLORS = {
  1: Colors.white,
  2: Colors.white,
  3: Colors.white,
  4: Colors.black,
  5: Colors.white
};

Color getLevelColor(int level) {
  return SUBJECT_LEVEL_COLORS[level];
}

Color getLevelTextColor(int level) {
  return SUBJECT_LEVEL_TEXT_COLORS[level];
}
