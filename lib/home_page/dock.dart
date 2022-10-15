import 'dart:developer';
import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:event/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:productivity_launcher/design/blur_widget.dart';
import 'package:productivity_launcher/design/text_sytles.dart';
import 'package:productivity_launcher/utils/app.dart';

var dockEvent = Event();

Future<File> get _localFile async {
  final directory = await getApplicationDocumentsDirectory();
  String path = directory.path;

  return File('$path/dockApps.txt');
}

bool hasDockApps = false;
Future<void> setDockAppsAtStart() async {
  if (!hasDockApps) {
    hasDockApps = true;
    dockApps = [];
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final appList = contents.split(',');
      for (var i = 0; i < appList.length; i++) {
        final newApp = apps
            .where((element) => element.appName == appList[i])
            .toList()
            .first;
        dockApps.add(newApp);
        dockEvent.broadcast();
      }
    } catch (e) {
      final file = await _localFile;
      file.writeAsString(apps[0].appName);
      dockApps = [];
      log(e.toString());
    }
  }
}

void addDockApp(Application app) async {
  dockApps.add(app);
  dockEvent.broadcast();

  try {
    final file = await _localFile;
    final contents = await file.readAsString();
    // ignore: prefer_interpolation_to_compose_strings
    file.writeAsString(contents + ',' + app.appName);
  } catch (e) {
    log(e.toString());
  }
}

late String newAppList;
void removeDockApp(Application app) async {
  dockApps.remove(app);
  dockEvent.broadcast();

  try {
    final file = await _localFile;
    final contents = await file.readAsString();
    final appList = contents.split(',');
    appList.remove(app.appName);
    newAppList = '';
    for (var i = 0; i < appList.length; i++) {
      newAppList += appList[i] + (i == appList.length - 1 ? '' : ',');
    }
    file.writeAsString(newAppList);
  } catch (e) {
    log(e.toString());
  }
}

class Dock extends StatefulWidget {
  const Dock({Key? key}) : super(key: key);

  @override
  State<Dock> createState() => _DockState();
}

class _DockState extends State<Dock> {
  @override
  void initState() {
    super.initState();
    dockEvent.subscribe((args) {
      setState(() {
        dockApps = dockApps;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlurWidget(
      child: Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, .2),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dockApps.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int position) {
                  Application app = dockApps[position];
                  return sampleApp(app);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 25)),
          )),
    );
  }

  Widget sampleApp(Application app) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 17),
        child: SizedBox(
            width: 55,
            child: InkWell(
                onTap: () {
                  app.openApp();
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dockAppDialog(app);
                      });
                },
                child: getAppIcon(app))));
  }

  Widget dockAppDialog(Application app) {
    return CupertinoAlertDialog(
      title: Row(
        children: [
          SizedBox(width: 45, height: 45, child: getAppIcon(app)),
          const SizedBox(width: 10),
          Text(app.appName,
              style:
                  headerTextStyle.copyWith(color: Colors.black, fontSize: 22)),
          const SizedBox(width: 10)
        ],
      ),
      actions: [
        dockAppDialogButton(Icons.delete_rounded, 'Remove App', () {
          app.uninstallApp();
        }),
        dockAppDialogButton(
            Icons.remove_circle_outline_rounded, 'Remove From Dock', () {
          removeDockApp(app);
          Navigator.pop(context);
        }),
        dockAppDialogButton(Icons.settings, 'App Settings', () {
          app.openSettingsScreen();
        })
      ],
    );
  }

  Widget dockAppDialogButton(
      IconData icon, String text, void Function() onPressed) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Row(
          children: [
            const SizedBox(width: 20),
            Icon(icon, color: Colors.black),
            const SizedBox(width: 10),
            Text(text, style: standardTextStyle.copyWith(color: Colors.black)),
          ],
        ));
  }
}
