import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:productivity_launcher/home.dart';
import 'package:productivity_launcher/utils/themes.dart';

late List<Application> apps;

void main() {
  setTheme(darkTheme);
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
