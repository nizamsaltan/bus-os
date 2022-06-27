// ignore_for_file: library_private_types_in_public_api

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:productivity_launcher/utils/themes.dart';

class AppsListScreen extends StatefulWidget {
  const AppsListScreen({Key? key}) : super(key: key);

  @override
  _AppsListScreenState createState() => _AppsListScreenState();
}

class _AppsListScreenState extends State<AppsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _AppsListScreenContent(
          includeSystemApps: true,
          onlyAppsWithLaunchIntent: true,
          key: GlobalKey()),
    );
  }
}

class _AppsListScreenContent extends StatelessWidget {
  final bool includeSystemApps;
  final bool onlyAppsWithLaunchIntent;

  const _AppsListScreenContent(
      {Key? key,
      this.includeSystemApps = true,
      this.onlyAppsWithLaunchIntent = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Application>>(
      future: DeviceApps.getInstalledApplications(
          includeAppIcons: true,
          includeSystemApps: includeSystemApps,
          onlyAppsWithLaunchIntent: onlyAppsWithLaunchIntent),
      builder: (BuildContext context, AsyncSnapshot<List<Application>> data) {
        if (data.data == null) {
          return Center(
              child: CircularProgressIndicator(
            color: currentTheme.secondaryBackgroundColor,
          ));
        } else {
          List<Application> apps = data.data!;

          return Scrollbar(
            child: ListView.builder(
                itemBuilder: (BuildContext context, int position) {
                  Application app = apps[position];
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: app is ApplicationWithIcon
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(app.icon),
                                backgroundColor: Colors.white,
                              )
                            : null,
                        onTap: () => onAppClicked(context, app),
                        title: Text(app.appName), // ${app.packageName}
                        /*subtitle: Text('Version: ${app.versionName}\n'
                              'System app: ${app.systemApp}\n'
                              'APK file path: ${app.apkFilePath}\n'
                              'Data dir: ${app.dataDir}\n'
                              'Installed: ${DateTime.fromMillisecondsSinceEpoch(app.installTimeMillis).toString()}\n'
                              'Updated: ${DateTime.fromMillisecondsSinceEpoch(app.updateTimeMillis).toString()}'), */
                      ),
                    ],
                  );
                },
                itemCount: apps.length),
          );
        }
      },
    );
  }

  void onAppClicked(BuildContext context, Application app) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(app.appName),
            actions: <Widget>[
              _AppButtonAction(
                label: 'Open app',
                onPressed: () => app.openApp(),
              ),
              _AppButtonAction(
                label: 'Open app settings',
                onPressed: () => app.openSettingsScreen(),
              ),
              _AppButtonAction(
                label: 'Uninstall app',
                onPressed: () async => app.uninstallApp(),
              ),
            ],
          );
        });
  }
}

class _AppButtonAction extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _AppButtonAction({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed?.call();
        Navigator.of(context).maybePop();
      },
      child: Text(label),
    );
  }
}
