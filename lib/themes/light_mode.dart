import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.blue, 
    onPrimary: Colors.white, 
    secondary: Colors.green, 
    onSecondary: Colors.white, 
    background: Colors.white, 
    onBackground: Colors.black, 
    surface: Colors.grey.shade100, 
    onSurface: Colors.black, 
    error: Colors.red, 
    onError: Colors.white, 
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue, 
    foregroundColor: Colors.white, 
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue, 
    textTheme: ButtonTextTheme.primary, 
  ),
  scaffoldBackgroundColor: Colors.white, 


  iconTheme: IconThemeData(
    color: Colors.blue, 
  ),
  cardColor: Colors.white, 
  dividerColor: Colors.grey.shade300, 
  hoverColor: Colors.grey.shade200, 

);
