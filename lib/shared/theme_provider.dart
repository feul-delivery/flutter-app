import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0x050505),
    primaryColor: Color(0x17181C),
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
  );
}
