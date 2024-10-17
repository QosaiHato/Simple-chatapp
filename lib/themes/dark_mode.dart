import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.blueGrey.shade700, 
    onPrimary: Colors.white, 
    secondary: Colors.teal.shade600, 
    onSecondary: Colors.white, 
    surface: Colors.grey.shade800, 
    onSurface: Colors.white, 
    background: Colors.black, 
    onBackground: Colors.white, 
    error: Colors.redAccent, 
    onError: Colors.white, 
    tertiary: Colors.grey.shade900, 
    inversePrimary: Colors.grey.shade300, 
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blueGrey.shade900, 
    foregroundColor: Colors.white, 
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.teal.shade600, 
    textTheme: ButtonTextTheme.primary, 
  ),
  scaffoldBackgroundColor: Colors.black, 

  iconTheme: IconThemeData(
    color: Colors.teal.shade400, 
  ),
  cardColor: Colors.grey.shade800, 
  dividerColor: Colors.grey.shade700, 
  hoverColor: Colors.grey.shade600, 

);
