import 'package:flutter/material.dart';

ThemeData uvsyTheme = ThemeData(
  primaryColor: Colors.amber,
  accentColor: Colors.deepPurple,
  backgroundColor: Colors.amber[200],
  appBarTheme: AppBarTheme(color: Colors.white),
  buttonColor: Colors.deepPurple,
  primaryTextTheme: TextTheme(
    subtitle1: TextStyle(
      color: Colors.grey,
      fontSize: 25,
      fontFamily: 'Roboto'
    ),
    //button will be used for buttons text
    button: TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontFamily: 'Roboto',
    ),
    //body1 will be used for text fields
    bodyText1: TextStyle(
      color: Colors.black54,
      fontSize: 15,
      fontFamily: 'Roboto',
    ),
    // body2 will be used for errors, at least for now...
    bodyText2: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.redAccent,
      fontSize: 13,
    ),
  ),
);
