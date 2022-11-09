import 'dart:convert';
import 'dart:developer';

import 'package:device_apps/device_apps.dart';
import 'package:event/event.dart';
import 'package:flutter/material.dart';
import 'package:productivity_launcher/utils/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

late List<AppFolder> folders;
Event onNewFolderCreated = Event();

const String _folderFileKey = 'folders.json';

class AppFolderManager {
  static AppFolderManager get instance => AppFolderManager();

  Future<AppFolder> appFolderFromMap(String str) async =>
      AppFolder.fromMap(json.decode(str));
  String appFolderToMap(AppFolder data) => json.encode(data.toMap());

  // Get saved folders
  Future<void> initializeFolders() async {
    folders = [];
    folders.clear();

    final prefs = await SharedPreferences.getInstance();
    final appList = prefs.getStringList(_folderFileKey);
    log(appList.toString());
    for (var element in appList!) {
      AppFolder folder = await appFolderFromMap(element);
      folders.add(folder);
      onNewFolderCreated.broadcast();

      log('Folders initialized successfuly');
    }
  }

  // Remove existing folder
  Future<void> removeFolder(AppFolder folder) async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? folderList = prefs.getStringList(_folderFileKey);
    if (folderList == null) {
      log('0 folder exist');
      return;
    }

    var folderData = appFolderToMap(folder);
    if (folderList.contains(folderData)) {
      folderList.remove(folderData);
      await prefs.setStringList(_folderFileKey, folderList);
      folders.remove(folder);
      log('Folder removed succesfuly');

      initializeFolders();
    } else {
      log('Folder not exist');
    }
  }

  // Add new empty folder and save it as json
  Future<void> addNewFolder(String folderName, IconData folderIcon) async {
    final prefs = await SharedPreferences.getInstance();
    List<Application> emptyApps = [];
    AppFolder newFolder = AppFolder(folderName, folderIcon, emptyApps);

    var lastFolderList = prefs.getStringList(_folderFileKey);
    lastFolderList ??= [];

    lastFolderList.add(appFolderToMap(newFolder));
    await prefs.setStringList(_folderFileKey, lastFolderList);
    folders.add(newFolder);

    initializeFolders();
  }
}

IconData getIcon(int iconOneCodePoint, String? iconOneFontFamily,
    String? iconOneFontPackage, bool iconOneDirection) {
  final IconData iconData = IconData(iconOneCodePoint,
      fontFamily: iconOneFontFamily,
      fontPackage: iconOneFontPackage,
      matchTextDirection: iconOneDirection);
  return iconData;
}

List<Application> getAppList(List<dynamic> apkPathList) {
  List<String> newAppApkList = [];
  List<Application> newAppList = [];

  for (var element in apkPathList) {
    newAppApkList.add(element);
  }

  for (var element in newAppApkList) {
    newAppList.add(getApp(element)!);
  }

  return newAppList;
}

Application? getApp(String apkPath) {
  Application? newApp;
  for (var element in apps) {
    if (element.apkFilePath == apkPath) {
      newApp = element;
    }
  }

  return newApp;
}

List<String> getAppsApkFilePath(List<Application> selectedApps) {
  List<String> paths = [];
  for (var element in selectedApps) {
    paths.add(element.apkFilePath);
  }

  return paths;
}

class AppFolder {
  final String folderName;
  final IconData folderIcon;
  final List<Application> folderApps;

  AppFolder(this.folderName, this.folderIcon, this.folderApps);

  AppFolder.fromMap(Map<String, dynamic> json)
      : folderName = json['folder_name'],
        folderIcon = getIcon(
            json['folder_icon_codePoint'],
            json['folder_icon_fontFamily'],
            json['folder_icon_fontPackage'],
            json['folder_icon_matchTextDirection']),
        folderApps = getAppList(json['apps_apkFilePath']);

  Map<String, dynamic> toMap() => {
        "folder_name": folderName,
        "folder_icon_codePoint": folderIcon.codePoint,
        "folder_icon_fontFamily": folderIcon.fontFamily,
        "folder_icon_fontPackage": folderIcon.fontPackage,
        "folder_icon_matchTextDirection": folderIcon.matchTextDirection,
        "apps_apkFilePath": getAppsApkFilePath(folderApps)
      };
}
