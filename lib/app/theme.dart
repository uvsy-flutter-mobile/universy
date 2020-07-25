import 'package:flutter/material.dart';

ThemeData uvsyTheme = ThemeData(
  primaryColor: Colors.amber,
  appBarTheme: AppBarTheme(color: Colors.white),
  primaryTextTheme: TextTheme(
    subtitle1: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 25),

    // body2 will be used for errors, at least for now...
    bodyText2: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.redAccent, fontSize: 13),
  ),
);
