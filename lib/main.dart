import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_launcher/home_page/home.dart';
import 'package:productivity_launcher/utils/themes.dart';

// TODO: Drawboards is in progress
// TODO: Change app page design and functionality
// TODO: Change app loading screen

void main() {
  setTheme(defaultTheme);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
