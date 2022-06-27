// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

theme currentTheme = theme();

theme blackTheme = theme();
theme whiteTheme = theme();
theme darkTheme = theme();

void setTheme(theme newTheme) {
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

  currentTheme = newTheme;
}

class theme {
  late Color backgroundColor;
  late Color secondaryBackgroundColor;
  late Color shadowColor;
  late Color textColor;
  bool hasBackgroundImage = false;
}
