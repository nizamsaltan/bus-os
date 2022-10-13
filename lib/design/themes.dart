// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

appTheme currentTheme = appTheme();

appTheme defaultTheme = appTheme();

void setTheme(appTheme newTheme) {
  defaultTheme.backgroundColor = const Color.fromRGBO(217, 217, 217, 0.4);
  defaultTheme.secondaryBackgroundColor =
      const Color.fromRGBO(45, 45, 45, 0.95);
  defaultTheme.shadowColor = Colors.white24;
  defaultTheme.textColor = Colors.white;
  defaultTheme.backgroundImagePath = 'assets/images/bg.jpg';

  currentTheme = newTheme;
}

class appTheme {
  late Color backgroundColor;
  late Color secondaryBackgroundColor;
  late Color shadowColor;
  late Color textColor;
  late String backgroundImagePath;
}
