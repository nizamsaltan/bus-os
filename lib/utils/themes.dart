// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

appTheme currentTheme = appTheme();

appTheme blackTheme = appTheme();
appTheme whiteTheme = appTheme();
appTheme darkTheme = appTheme();

void setTheme(appTheme newTheme) {
  blackTheme.backgroundColor = Colors.black;
  blackTheme.secondaryBackgroundColor = const Color.fromARGB(255, 37, 37, 37);
  blackTheme.shadowColor = Colors.white24;
  blackTheme.textColor = Colors.white;
  blackTheme.hasBackgroundImage = false;

  whiteTheme.backgroundColor = Colors.white;
  whiteTheme.secondaryBackgroundColor =
      const Color.fromARGB(255, 202, 202, 202);
  whiteTheme.shadowColor = Colors.black26;
  whiteTheme.textColor = Colors.black;
  whiteTheme.hasBackgroundImage = false;

  darkTheme.backgroundColor = Colors.black;
  darkTheme.secondaryBackgroundColor = const Color.fromARGB(255, 37, 37, 37);
  darkTheme.shadowColor = Colors.white24;
  darkTheme.textColor = Colors.white;
  darkTheme.hasBackgroundImage = true;
  darkTheme.backgroundImagePath = 'assets/images/background_1.jpg';

  currentTheme = newTheme;
}

class appTheme {
  late Color backgroundColor;
  late Color secondaryBackgroundColor;
  late Color shadowColor;
  late Color textColor;
  bool hasBackgroundImage = false;
  late String backgroundImagePath;
}
