import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color.fromRGBO(18, 18, 18, 1),
    primary: Color.fromRGBO(255, 255, 255, 0.87),
    secondary: Colors.grey,
    tertiary: Color.fromRGBO(0, 125, 66, 0.7),
    surface: Color.fromRGBO(33, 33, 33, 1),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(18, 18, 18, 1),
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
    centerTitle: true,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    shadowColor: Colors.grey[900],
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4)),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromRGBO(255, 255, 255, 0.6)),
      borderRadius: BorderRadius.circular(10.0),
    ),
    filled: true,
    fillColor: const Color.fromRGBO(25, 25, 25, 1),
    hintStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4)),
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 17.0,
      color: Color.fromRGBO(255, 255, 255, 0.87),
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 27.0,
      color: Color.fromRGBO(255, 255, 255, 0.87),
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 20.0,
      color: Color.fromRGBO(255, 255, 255, 0.87),
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 15.0,
      color: Color.fromRGBO(255, 255, 255, 0.87),
    ),
    bodyLarge: TextStyle(
      fontSize: 18.0,
      color: Color.fromRGBO(255, 255, 255, 0.87),
    ),
    labelLarge: TextStyle(
      fontSize: 18.0,
      color: Color.fromRGBO(158, 158, 158, 1),
    ),
    displayMedium: TextStyle(
      fontSize: 16.0,
      color: Color.fromRGBO(255, 255, 255, 0.87),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor:  const Color.fromRGBO(0, 125, 66, 0.7),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
    ), 
    
    //foregroundColor: Colors.grey[800]
  ),
  searchBarTheme: SearchBarThemeData(
      backgroundColor: MaterialStateProperty.all(Colors.grey[850]),
      hintStyle: MaterialStateProperty.all(
          const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4)))),
);
