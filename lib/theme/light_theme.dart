import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.black,
    secondary: Colors.grey,
  ),
  bottomAppBarTheme:  BottomAppBarTheme(
    shadowColor: Colors.grey[100],
  ),
  textTheme: TextTheme(
    headlineSmall: TextStyle(fontSize: 18.0,),
  ),
  
);