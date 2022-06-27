import 'package:device_apps/device_apps.dart';

late List<Application> apps;

void getApps(bool includeSystemApps, bool includeAppIcons) async {
  // Returns a list of only those apps that have launch intent
  apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: includeSystemApps,
      includeAppIcons: includeAppIcons);
}

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
