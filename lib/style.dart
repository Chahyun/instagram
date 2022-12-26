import 'package:flutter/material.dart';
var theme = ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.lightBlueAccent,
      )
    ),
    appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 1,
        actionsIconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 25,)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
    )
);

