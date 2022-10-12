// ignore_for_file: must_be_immutable

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

late List<Application> apps;
late List<Application> searchApps;
late List<Application> dockApps;

void openApp(String path) {
  // EXAMPLE: openApp('com.frandroid.app');
  DeviceApps.openApp(path);
}

void openAppSettings(String path) {
  // EXAMPLE: openAppSettings('com.frandroid.app');
  DeviceApps.openAppSettings(path);
}

void uninstallApp(String path) {
  // EXAMPLE: uninstallApp('com.frandroid.app');
  DeviceApps.uninstallApp(path);
}

Widget getAppIcon(Application app) {
  if (app is ApplicationWithIcon) {
    return GFAvatar(
      backgroundImage: MemoryImage(app.icon),
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      shape: GFAvatarShape.square,
    );
  } else {
    return Container(color: Colors.red);
  }
}
