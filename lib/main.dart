import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_launcher/design/themes.dart';
import 'package:productivity_launcher/home_page/home_page.dart';
import 'package:productivity_launcher/utils/app_folder.dart';
import 'package:translator/translator.dart';

late GoogleTranslator translator;
// var translation = await translator.translate("Dart is very cool!", to: 'pl');

void main() async {
  setTheme(defaultTheme);

  translator = GoogleTranslator();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
    systemNavigationBarColor: Colors.black,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  AppFolderManager.instance.initializeFolders();
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
